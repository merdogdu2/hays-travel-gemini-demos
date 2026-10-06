# Hays Travel — Gemini Enterprise, A2UI v0.9 & Gemini Notebook Demo Suite

This repository contains **three end-to-end Google Cloud & Gemini demos** tailored for **Hays Travel**—spanning front-line retail branch consultants (450+ branches & Independence Group homeworkers), the in-house **Hays Travel Vista** tour operator desk, and **Sunderland HQ** back-office finance operations (`iBOS`).

---

## Executive Value Summary

When a customer walks into a high-street travel agency, consultants typically lose **20 minutes** hunting through duplicate customer profiles in `iSell`, another **15 minutes** comparing supplier portals, and **10 minutes** manually re-typing booking confirmations—while missing opportunities to switch 3rd-party quotes (~10.5% commission) to in-house **Hays Vista** packages (~21.8% commission).

This suite demonstrates how **Gemini Enterprise (with A2UI v0.9 interactive cards)** and **Gemini Notebook (NotebookLM)** act as an instant memory and commercial companion—cutting a 45-minute consultation to under 4 minutes, surfacing 20-year veteran destination tips, eliminating manual `iSell` re-keying, and **doubling branch commission while saving the customer money**.

---

## Repository Structure & The 3 Demos

| Demo Folder | Demo Name | Target Audience & Scope | Key Technologies |
| :--- | :--- | :--- | :--- |
| **[`demo1-enterprise-smile-sidekick/`](./demo1-enterprise-smile-sidekick/)** | **Demo 1: Hays Travel SMILE Sidekick** (`ge-demo-haystravel-6291`) | **Full Enterprise Demo (Branch + Vista + Sunderland HQ Finance):** Single Customer View deduplication, 3rd-party vs. Vista margin switch, `iSell` confirmation OCR, and Sunderland HQ `iBOS` commission discrepancy auditing. | Gemini Enterprise, ADK Multi-Agent, A2UI v0.9, BigQuery MCP, Firestore MCP, Agent Engine Code Sandbox, Cloud Run + IAP |
| **[`demo2-branch-smile-companion/`](./demo2-branch-smile-companion/)** | **Demo 2: Hays Branch SMILE Companion** (`ge-demo-haysbranch-7412`) | **Simple Retail Branch Desk Agent:** Stripped of HQ/Finance audit jargon—focused purely on the 3-step retail branch desk workflow (Walk-In Customer Card $\rightarrow$ Holiday & Cruise Finder with Veteran Tips $\rightarrow$ 1-Click Confirmation to `iSell`). | Gemini Enterprise, ADK Agent, A2UI v0.9, BigQuery (3 tables), Firestore Branch To-Do Queue, Cloud Run + IAP |
| **[`demo3-branch-gemini-notebook/`](./demo3-branch-gemini-notebook/)** | **Demo 3: Hays Branch Gemini Notebook Kit** | **Zero-Code Gemini Notebook / NotebookLM Demo:** 4 synthetic branch Markdown source documents + 3 CSV tables + 5 plain-English, ID-free prompts for instant source-cited briefings and end-of-day branch margin roll-ups. | Gemini Notebook / NotebookLM, Synthetic Markdown & CSV Sources |
| **[`docs/`](./docs/)** | **Presenter Guides & Interactive Customer Architecture Deck** | Includes the interactive single-page HTML customer architecture guide (`Hays_Travel_Customer_Architecture_Guide.html`), full storyboards, data maps, and copy-paste prompt playbooks. | Interactive HTML5 / Tailwind / Mermaid |

---

## Where the Data Comes From (Real-World Mapping)

All data in this repository is **100% synthetic** (zero real customer PII), modeled on the 6 core systems in Hays Travel's retail and HQ estate:

1. **`iSell` (Retail Point-of-Sale & Branch CRM):** Walk-in enquiries, quotes, bookings, and consultant free-text notes (where repeat customers often accumulate 3–5 duplicate records).
2. **`Databricks` Data Lakehouse (Bronze $\rightarrow$ Silver $\rightarrow$ Gold):** Entity resolution and Single Customer View (`SCV`) matching across historical branch bookings.
3. **`Hays Vista` (In-House Tour Operator Inventory):** Higher-margin in-house dynamic packages (~20–22% commission vs. ~10% on 3rd-party operators).
4. **3rd-Party Supplier Portals (TUI, Jet2holidays, P&O Cruises, Travelink):** External tour operator pricing feeds and PDF/image booking confirmations.
5. **`SMILE` (Internal Staff Intranet & Knowledge Base):** Ship inspection notes, cabin doorway widths, resort beach reviews, and commercial bulletins ("veteran tribal knowledge").
6. **`Sunny Spend` (Foreign Exchange) & `Holiday Extras` (Ancillaries):** Prepaid Mastercard FX wallet balances and airport parking/lounge add-ons.

---

## Quickstart

### Deploying Demo 1 or Demo 2 to Google Cloud & Gemini Enterprise
```bash
cd demo2-branch-smile-companion   # or demo1-enterprise-smile-sidekick
cp .env.example .env
# Edit .env with your PROJECT_ID and GCP_ACCOUNT
./setup_and_deploy.sh
```

### Running Demo 3 in Gemini Notebook / NotebookLM
1. Open **[`demo3-branch-gemini-notebook/README.md`](./demo3-branch-gemini-notebook/README.md)**.
2. Upload the 4 Markdown files in `demo3-branch-gemini-notebook/sources/` into your Gemini Notebook.
3. Paste the **5 plain-English, ID-free prompts** from the README!
