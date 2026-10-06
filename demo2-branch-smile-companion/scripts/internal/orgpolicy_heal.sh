#!/bin/bash
# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# =============================================================================
# Repair a Cloud Run deploy that an organization policy refused.
#
# WHY THIS FILE EXISTS, AND WHY IT IS NOT PART OF THE SHIPPED SAMPLE
#
# Hardened orgs pin two list constraints on Cloud Run:
#
#   constraints/run.allowedVPCEgress
#       allowedValues e.g. [all-traffic]
#   constraints/run.allowedBinaryAuthorizationPolicies
#       allowedValues e.g. [projects/bcid-cloud-run-policy/platforms/cloudRun/
#                           policies/bcidManagedPolicy]
#
# A CreateService that never mentions VPC egress or Binary Authorization sets
# those annotations to null, and null is not in a non-empty allowedValues list,
# so the deploy is rejected before Cloud Build is even asked for a build. The
# operator of such a project typically cannot read the policy on the folder, let
# alone change it: `orgpolicy.policies.list` lives on the folder or org, and a
# sandbox project's owner has neither.
#
# What IS available is the ability to satisfy the constraints. `--vpc-egress` is
# refused unless a network arrives with it, so satisfying the first one means
# attaching a VPC - which means this file creates network infrastructure. That is
# a reasonable thing for an internal tool to do to an internal sandbox, and an
# unreasonable thing for a public sample to do to a reader's project without
# being asked, which is why `tools/port_prepare.py` denies this whole directory
# and the public copy carries only the diagnostic in setup_and_deploy.sh.
#
# CONTRACT WITH ITS CALLERS
#
# Two of them, and they are not the same shape:
#
#   setup_and_deploy.sh (the CLI skill) sources this from the demo root as
#     `. scripts/internal/orgpolicy_heal.sh`.
#   Code.gs (the Web UI) carries this file as a base64 constant, materialises it
#     into a temp file on failure and sources THAT - from inside `adk_agent`,
#     because its deploy runs `--source ..`.
#
# So nothing here may assume the working directory. The two files it reads,
# `.env` and `adk_agent/app/mcp_config.json`, are each looked up in a way that
# works from either. Everything else is passed in:
#
#   called as:    ge_orgpolicy_heal "$AGENT_DEPLOY_LOG"
#                 (that log is REWRITTEN by every deploy_agent_service call, so
#                  reading it after a retry reads the retry's failure)
#   reads:        PROJECT_ID, REGION, SERVICE_NAME, bool01, GE_ORGPOLICY_*
#   writes:       GE_RUN_EXTRA_FLAGS, .env (the four GE_RUN_* keys)
#   retries via:  deploy_agent_service, defined by the caller
#   returns:      0 once the service is deployed, non-zero when it gave up
#                 (having printed what a human has to do next)
#
# The caller has already printed the neutral diagnostic by the time this runs,
# so everything here is about what is being ATTEMPTED, not about what went wrong.
#
# OVERRIDES
#
#   GE_ORGPOLICY_HEAL=0   caller skips this file entirely (diagnostic only)
#   GE_ORGPOLICY_NAT=1/0  force Cloud NAT on or off; default is on only when the
#                         demo configures MCP servers, which are the only part of
#                         the runtime that reaches hosts outside googleapis.com
#   GE_ORGPOLICY_NETWORK  use this network instead of choosing one
#   GE_ORGPOLICY_SUBNET   use this subnet instead of choosing one
# =============================================================================

# The network this file creates when it cannot reuse one. Shared by every demo in
# the project, on purpose: a per-demo network would hit the 15-network quota after
# fifteen demos and leave the sixteenth with a failure nobody could read. Never
# deleted by cleanup.sh for the same reason - it belongs to the project, not to
# the demo being torn down.
_GEOH_NETWORK_NAME="ge-demo-net"

# Ranges tried in order when cutting the subnet. Any one of them may already be
# taken by something else in the project; overlapping is the only failure mode
# that matters here and it is reported clearly by the API.
_GEOH_SUBNET_RANGES="10.90.0.0/24 10.91.0.0/24 10.92.0.0/24 10.93.0.0/24"

# The policy Cloud Run's own hardened baseline uses. Only reached when the policy
# itself cannot be read, which is the common case for a project whose folder the
# operator has no access to: better to spend one deploy attempt on the value that
# is right in every hardened org seen so far than to stop with nothing tried.
_GEOH_BCID_FALLBACK="projects/bcid-cloud-run-policy/platforms/cloudRun/policies/bcidManagedPolicy"

# Progress goes to stderr, not stdout. Two of the helpers below return a value by
# echoing it and are called inside $( ), so a progress line on stdout is not a
# message - it is the first word of the network name the caller then deploys with.
_geoh_log() {
  echo "     [org-policy repair] $1" >&2
}

# Allowed values of a list constraint, space separated, or empty when unreadable.
#
# Deliberately the v1 `gcloud resource-manager org-policies` surface rather than
# v2 `gcloud org-policies`: v2 fails with "API not enabled" on a project that has
# never turned on orgpolicy.googleapis.com, which is exactly the kind of project
# this runs in, while v1 answers anyway. `--effective` matters just as much - the
# policy is inherited from a folder, so the project-level read returns nothing.
_geoh_allowed_values() {
  gcloud resource-manager org-policies describe "$1" \
    --project="$PROJECT_ID" --effective \
    --format="value(listPolicy.allowedValues)" 2>/dev/null |
    tr ';' ' '
}

# The egress values to try, best first.
#
# private-ranges-only is preferred because it changes nothing about how the
# container reaches Google APIs: only RFC1918 destinations are pulled through the
# VPC, so the service behaves exactly as it did before the network existed. With
# all-traffic every packet goes through the subnet, which is why that path also
# has to care about Private Google Access and Cloud NAT.
_geoh_egress_candidates() {
  _geoh_allowed=$(_geoh_allowed_values constraints/run.allowedVPCEgress)
  if [ -z "$_geoh_allowed" ]; then
    # Unreadable policy: try the harmless value, then the strict one.
    echo "private-ranges-only all-traffic"
    return 0
  fi
  _geoh_ordered=""
  for _geoh_want in private-ranges-only all-traffic all; do
    for _geoh_have in $_geoh_allowed; do
      if [ "$_geoh_want" = "$_geoh_have" ]; then
        _geoh_ordered="$_geoh_ordered $_geoh_want"
      fi
    done
  done
  # A policy that allows only values this script does not know how to use is
  # still worth trying verbatim - the list is short and the API is the judge.
  if [ -z "$_geoh_ordered" ]; then
    _geoh_ordered="$_geoh_allowed"
  fi
  echo "$_geoh_ordered"
}

_geoh_binauthz_value() {
  _geoh_allowed=$(_geoh_allowed_values constraints/run.allowedBinaryAuthorizationPolicies)
  for _geoh_have in $_geoh_allowed; do
    echo "$_geoh_have"
    return 0
  done
  echo "$_GEOH_BCID_FALLBACK"
}

# "True"/"False"/"" - whether a subnet can reach googleapis.com without a NAT.
_geoh_subnet_pga() {
  gcloud compute networks subnets describe "$1" \
    --region="$REGION" --project="$PROJECT_ID" \
    --format="value(privateIpGoogleAccess)" 2>/dev/null
}

# An existing subnet worth reusing for this egress mode, as "network subnet", or
# empty.
#
# Only the auto-created `default` network is considered. Anything else in the
# project belongs to somebody, and a demo has no business guessing that a subnet
# named after a team is free for Direct VPC egress.
_geoh_reusable_network() {
  _geoh_egress="$1"
  if ! gcloud compute networks describe default \
    --project="$PROJECT_ID" --format="value(name)" >/dev/null 2>&1; then
    return 0
  fi
  if ! gcloud compute networks subnets describe default \
    --region="$REGION" --project="$PROJECT_ID" \
    --format="value(name)" >/dev/null 2>&1; then
    return 0
  fi
  if [ "$_geoh_egress" != "private-ranges-only" ]; then
    # all-traffic without Private Google Access is worse than no network at all:
    # the deploy succeeds and the container then cannot reach googleapis.com, so
    # the failure moves from a readable policy error to a runtime timeout. Turning
    # PGA on for somebody else's subnet is not this script's call, so it walks
    # away and cuts its own instead.
    if [ "$(_geoh_subnet_pga default)" != "True" ]; then
      _geoh_log "the default subnet has Private Google Access off; not touching it"
      return 0
    fi
  fi
  echo "default default"
}

# Create (idempotently) the shared demo network and return "network subnet".
_geoh_own_network() {
  _geoh_subnet="${_GEOH_NETWORK_NAME}-${REGION}"

  if ! gcloud compute networks describe "$_GEOH_NETWORK_NAME" \
    --project="$PROJECT_ID" --format="value(name)" >/dev/null 2>&1; then
    _geoh_log "creating network $_GEOH_NETWORK_NAME"
    gcloud compute networks create "$_GEOH_NETWORK_NAME" \
      --project="$PROJECT_ID" --subnet-mode=custom --quiet >/dev/null 2>&1 || true
  fi

  if ! gcloud compute networks subnets describe "$_geoh_subnet" \
    --region="$REGION" --project="$PROJECT_ID" \
    --format="value(name)" >/dev/null 2>&1; then
    for _geoh_range in $_GEOH_SUBNET_RANGES; do
      _geoh_log "creating subnet $_geoh_subnet ($_geoh_range) with Private Google Access"
      if gcloud compute networks subnets create "$_geoh_subnet" \
        --network="$_GEOH_NETWORK_NAME" --region="$REGION" \
        --range="$_geoh_range" --enable-private-ip-google-access \
        --project="$PROJECT_ID" --quiet >/dev/null 2>&1; then
        break
      fi
    done
  fi

  if ! gcloud compute networks subnets describe "$_geoh_subnet" \
    --region="$REGION" --project="$PROJECT_ID" \
    --format="value(name)" >/dev/null 2>&1; then
    return 1
  fi
  echo "$_GEOH_NETWORK_NAME $_geoh_subnet"
}

# Whether the runtime needs to reach hosts outside googleapis.com.
#
# Everything the agent does by default - Vertex, BigQuery, Firestore, Discovery
# Engine, Maps - is a googleapis.com host, and those are reachable through
# Private Google Access with no NAT and no external address. MCP servers are the
# exception: a demo that configures one is pointing the agent at somebody else's
# endpoint, and under all-traffic that packet has nowhere to go without a NAT.
_geoh_needs_nat() {
  if [ -n "${GE_ORGPOLICY_NAT:-}" ]; then
    [ "$(bool01 "$GE_ORGPOLICY_NAT")" = "1" ]
    return $?
  fi
  # Two callers, two working directories. setup_and_deploy.sh deploys from the
  # demo root (`--source .`); the Web UI generated script cd's into adk_agent
  # first and deploys with `--source ..`. Same file, so try both rather than
  # silently deciding "no MCP servers" - which under all-traffic is the
  # difference between an agent that can reach them and one that cannot.
  for _geoh_mcp in adk_agent/app/mcp_config.json app/mcp_config.json; do
    [ -s "$_geoh_mcp" ] || continue
    # An ENTRY, not just the envelope. The Web UI writes this file on every
    # demo, so with no imported servers it is a well-formed {"mcpServers": []} -
    # and the "does it contain a quote" test this used to run answered yes to
    # that, which would leave an idle NAT address behind every demo.
    _geoh_mcp_flat=$(tr -d ' \n\r\t' <"$_geoh_mcp")
    case "$_geoh_mcp_flat" in
    '' | '{}' | '[]' | '{"mcpServers":[]}' | '{"mcpServers":{}}') continue ;;
    esac
    return 0
  done
  return 1
}

_geoh_ensure_nat() {
  _geoh_network="$1"
  _geoh_router="${_geoh_network}-router-${REGION}"
  _geoh_nat="${_geoh_network}-nat-${REGION}"

  if ! gcloud compute routers describe "$_geoh_router" \
    --region="$REGION" --project="$PROJECT_ID" \
    --format="value(name)" >/dev/null 2>&1; then
    _geoh_log "creating Cloud Router $_geoh_router"
    gcloud compute routers create "$_geoh_router" \
      --network="$_geoh_network" --region="$REGION" \
      --project="$PROJECT_ID" --quiet >/dev/null 2>&1 || true
  fi
  if ! gcloud compute routers nats describe "$_geoh_nat" \
    --router="$_geoh_router" --region="$REGION" --project="$PROJECT_ID" \
    --format="value(name)" >/dev/null 2>&1; then
    _geoh_log "creating Cloud NAT $_geoh_nat"
    gcloud compute routers nats create "$_geoh_nat" \
      --router="$_geoh_router" --region="$REGION" \
      --auto-allocate-nat-external-ips \
      --nat-all-subnet-ip-ranges \
      --project="$PROJECT_ID" --quiet >/dev/null 2>&1 || true
  fi
}

# Write what worked back to .env, so the next run starts with the flags instead
# of spending the rejected deploy again - and so `cleanup.sh` and a human reading
# the file can both see that this demo is pinned to a network.
#
# `.env` lives at the demo root, which is the working directory for one caller
# and the parent of it for the other. The Web UI does symlink adk_agent/.env to
# it, so the plain name usually resolves either way, but a demo whose symlink
# never got made would otherwise lose the flags in silence - and losing them
# means the next run spends the rejected deploy all over again.
_geoh_persist_env() {
  _geoh_env=""
  for _geoh_cand in .env ../.env; do
    if [ -f "$_geoh_cand" ]; then
      _geoh_env="$_geoh_cand"
      break
    fi
  done
  [ -n "$_geoh_env" ] || return 0
  for _geoh_kv in "GE_RUN_NETWORK=$1" "GE_RUN_SUBNET=$2" \
    "GE_RUN_VPC_EGRESS=$3" "GE_RUN_BINAUTHZ=$4"; do
    [ -n "${_geoh_kv#*=}" ] || continue
    if ! grep -q "^${_geoh_kv%%=*}=" "$_geoh_env"; then
      echo "$_geoh_kv" >>"$_geoh_env"
    fi
  done
}

# Everything a human has to know once this file has run out of ideas.
_geoh_give_up() {
  echo ""
  echo "  ❌ The org-policy repair could not get a deploy through."
  echo "     Everything below was tried against project $PROJECT_ID in $REGION:"
  echo "       egress values : ${_GEOH_TRIED_EGRESS:-none}"
  echo "       network       : ${_GEOH_TRIED_NETWORK:-none}"
  echo "       binauthz      : ${_GEOH_TRIED_BINAUTHZ:-none}"
  echo ""
  echo "     Two things are worth checking before escalating:"
  echo "       1. Binary Authorization may be rejecting the IMAGE rather than the"
  echo "          policy name. A --source deploy builds into Cloud Build's"
  echo "          cloud-run-source-deploy repository, and a BCID policy that does"
  echo "          not trust that builder rejects it no matter which flags are set."
  echo "       2. constraints/run.allowedIngress may also be pinned. This service"
  echo "          deploys with --ingress internal, which is normally allowed."
  echo ""
  echo "     If neither applies, the project needs an org-policy exception. Googlers"
  echo "     request one through go/gustfront against the folder that carries the"
  echo "     constraint - note that /experimental top-level folders are documented as"
  echo "     not receiving exceptions, so a demo may have to move to another project."
  echo "     Set GE_ORGPOLICY_HEAL=0 to skip this repair entirely."
  echo ""
}

ge_orgpolicy_heal() {
  _geoh_deploy_log="$1"

  echo ""
  _geoh_log "attempting to satisfy the constraints rather than stopping here."
  _geoh_log "this creates or reuses a VPC in $PROJECT_ID; set GE_ORGPOLICY_HEAL=0 to opt out."

  # compute.googleapis.com is not in the demo's own API list - nothing else here
  # needs it - so a project that has never used Compute has it off, and every
  # describe below would fail for a reason that has nothing to do with policy.
  gcloud services enable compute.googleapis.com --project="$PROJECT_ID" --quiet >/dev/null 2>&1 || true

  _GEOH_TRIED_EGRESS=""
  _GEOH_TRIED_NETWORK=""
  _GEOH_TRIED_BINAUTHZ=""

  _geoh_binauthz=""
  if grep -q "run.allowedBinaryAuthorizationPolicies" "$_geoh_deploy_log" 2>/dev/null; then
    _geoh_binauthz=$(_geoh_binauthz_value)
    _GEOH_TRIED_BINAUTHZ="$_geoh_binauthz"
    _geoh_log "binary authorization policy: $_geoh_binauthz"
  fi

  for _geoh_egress in $(_geoh_egress_candidates); do
    _GEOH_TRIED_EGRESS="${_GEOH_TRIED_EGRESS} ${_geoh_egress}"

    if [ -n "${GE_ORGPOLICY_NETWORK:-}" ] && [ -n "${GE_ORGPOLICY_SUBNET:-}" ]; then
      _geoh_pair="$GE_ORGPOLICY_NETWORK $GE_ORGPOLICY_SUBNET"
    else
      _geoh_pair=$(_geoh_reusable_network "$_geoh_egress")
      if [ -z "$_geoh_pair" ]; then
        _geoh_pair=$(_geoh_own_network) || _geoh_pair=""
      fi
    fi
    if [ -z "$_geoh_pair" ]; then
      _geoh_log "no usable network for --vpc-egress=$_geoh_egress"
      continue
    fi

    _geoh_net=${_geoh_pair%% *}
    _geoh_sub=${_geoh_pair##* }
    _GEOH_TRIED_NETWORK="$_geoh_net/$_geoh_sub"

    if [ "$_geoh_egress" != "private-ranges-only" ] && _geoh_needs_nat; then
      # Only under all-traffic: with private-ranges-only the public internet is
      # still reached the way it always was, so a NAT would cost an address for
      # nothing.
      _geoh_ensure_nat "$_geoh_net"
    fi

    GE_RUN_EXTRA_FLAGS="--network=${_geoh_net} --subnet=${_geoh_sub} --vpc-egress=${_geoh_egress}"
    if [ -n "$_geoh_binauthz" ]; then
      GE_RUN_EXTRA_FLAGS="${GE_RUN_EXTRA_FLAGS} --binary-authorization=${_geoh_binauthz}"
    fi

    _geoh_log "retrying the deploy with: $GE_RUN_EXTRA_FLAGS"
    if deploy_agent_service; then
      _geoh_persist_env "$_geoh_net" "$_geoh_sub" "$_geoh_egress" "$_geoh_binauthz"
      echo ""
      _geoh_log "deploy succeeded. The flags are recorded in .env for the next run."
      _geoh_log "note: $_geoh_net is shared by every demo in this project and cleanup.sh leaves it alone."
      echo ""
      return 0
    fi

    # A second constraint can only surface once the first one is satisfied, so a
    # retry that fails on Binary Authorization is progress, not a dead end.
    if [ -z "$_geoh_binauthz" ] &&
      grep -q "run.allowedBinaryAuthorizationPolicies" "$_geoh_deploy_log" 2>/dev/null; then
      _geoh_binauthz=$(_geoh_binauthz_value)
      _GEOH_TRIED_BINAUTHZ="$_geoh_binauthz"
      _geoh_log "binary authorization is enforced too; retrying with $_geoh_binauthz"
      GE_RUN_EXTRA_FLAGS="${GE_RUN_EXTRA_FLAGS} --binary-authorization=${_geoh_binauthz}"
      if deploy_agent_service; then
        _geoh_persist_env "$_geoh_net" "$_geoh_sub" "$_geoh_egress" "$_geoh_binauthz"
        echo ""
        _geoh_log "deploy succeeded. The flags are recorded in .env for the next run."
        return 0
      fi
    fi

    # Anything that is not an org-policy refusal is a different problem, and
    # trying the next egress value would bury it under a second failure.
    if ! grep -q "run.allowed" "$_geoh_deploy_log" 2>/dev/null; then
      _geoh_log "the retry failed for a reason unrelated to org policy; stopping."
      return 1
    fi
  done

  _geoh_give_up
  return 1
}
