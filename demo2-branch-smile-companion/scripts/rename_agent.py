import json
import subprocess
import sys
import urllib.request
import urllib.error

project_id = "merdogdu-sandbox-398713"
location = "global"
app_id = "flooid-app_1789043114378"
agent_name = "ge-demo-haysbranch-7412"
agent_url = "https://ge-demo-haysbranch-7412-izrmfecp5a-uc.a.run.app/a2a/app"
new_display_name = "Hays Branch SMILE Companion (ge-demo-haysbranch-7412)"
new_desc = "Simple everyday retail branch companion for Hays Travel consultants—instant walk-in customer cards, natural-language holiday & cruise finder with tribal knowledge, and 1-click supplier screenshot-to-iSell auto-fill."

token = subprocess.check_output(["gcloud", "auth", "print-access-token"]).decode().strip()

base_url = f"https://discoveryengine.googleapis.com/v1alpha/projects/{project_id}/locations/{location}/collections/default_collection/engines/{app_id}/assistants/default_assistant/agents"
headers = {
    "Authorization": f"Bearer {token}",
    "Content-Type": "application/json",
    "X-Goog-User-Project": project_id,
}

def call(method, call_url, payload=None):
    body = json.dumps(payload).encode("utf-8") if payload is not None else None
    req = urllib.request.Request(call_url, data=body, headers=headers, method=method)
    try:
        with urllib.request.urlopen(req) as resp:
            return resp.getcode(), json.loads(resp.read().decode("utf-8") or "{}")
    except urllib.error.HTTPError as e:
        return e.code, {"error": e.read().decode("utf-8", "replace")[:500]}

code, listing = call("GET", base_url + "?pageSize=100")
target_res = ""
existing_obj = {}
for a in listing.get("agents", []):
    if agent_name in a.get("displayName", "") or agent_name in json.dumps(a.get("a2aAgentDefinition", {})):
        target_res = a.get("name", "")
        existing_obj = a
        break

if not target_res:
    print("Agent not found!", file=sys.stderr)
    sys.exit(1)

print("Found existing agent:", target_res, "Current displayName:", existing_obj.get("displayName"))
patch_body = dict(existing_obj)
patch_body["displayName"] = new_display_name
patch_body["description"] = new_desc

p_code, p_resp = call("PATCH", f"https://discoveryengine.googleapis.com/v1alpha/{target_res}?updateMask=displayName,description", patch_body)
print("PATCH status:", p_code)
print("Updated displayName:", p_resp.get("displayName"))
print("AGENT_ID:", target_res.split("/")[-1])
