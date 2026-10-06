# Hays Travel Branch Office — Gemini Notebook (NotebookLM) Synthetic Data & 4-Prompt Demo Playbook

> [!TIP]
> **How to Set Up Your Gemini Notebook in 60 Seconds**
> You can load these synthetic branch sources into **Gemini Notebook / NotebookLM** in either of two ways:
> 1. **1-Click Download from Cloud Storage (Recommended):** Download the `.md` and `.csv` files (or the all-in-one `.zip`) from the links in Section 1 below and drop them into your Gemini Notebook as **Sources**.
> 2. **Direct Copy-Paste as "Copied Text" Sources:** Copy the 4 synthetic documents in **Section 3** below and paste them directly into Gemini Notebook under **Add Source $\rightarrow$ Copied Text**.

---

## 1. Ready-to-Upload Synthetic Data Files (Cloud Storage + Local Paths)

 *(Sign in with `branch.manager@example.com` to download directly in your browser)*

| Source # | File Name | What It Contains | Direct Browser Download Link |
| :--- | :--- | :--- | :--- |
| **All-in-One Bundle** | **`hays_branch_gemini_notebook_sources.zip`** | All 4 Markdown Guides + 3 CSV Tables below | [Download ZIP](https://storage.cloud.google.com/merdogdu-sandbox-398713-haysbranch-7412-docs/notebook-demo/hays_branch_gemini_notebook_sources.zip) |
| **Source 1 (MD)** | `01_Maidenhead_Branch_WalkIn_Customer_Profiles_and_iSell_Notes.md` | 5 walk-in households (`CUST-101` .. `CUST-105`), fragmented `iSell` IDs, dietary/scooter alerts, and `Sunny Spend` balances | [Download MD](https://storage.cloud.google.com/merdogdu-sandbox-398713-haysbranch-7412-docs/notebook-demo/01_Maidenhead_Branch_WalkIn_Customer_Profiles_and_iSell_Notes.md) |
| **Source 2 (MD)** | `02_Hays_Vista_vs_3rdParty_Holiday_and_Cruise_Handbook_2026.md` | Side-by-side 3rd-Party (TUI, Jet2, Kuoni) vs. **Hays Vista** package prices, commission %, and extra branch margin (£) | [Download MD](https://storage.cloud.google.com/merdogdu-sandbox-398713-haysbranch-7412-docs/notebook-demo/02_Hays_Vista_vs_3rdParty_Holiday_and_Cruise_Handbook_2026.md) |
| **Source 3 (MD)** | `03_Veteran_Consultant_Tribal_Knowledge_and_Destination_Secrets.md` | 20-year veteran tips: P&O *Arvia* Deck 8 lifeboat overhang trap, *Iona* 72cm scooter doorways, Torremolinos soft sand vs. stony Marbella | [Download MD](https://storage.cloud.google.com/merdogdu-sandbox-398713-haysbranch-7412-docs/notebook-demo/03_Veteran_Consultant_Tribal_Knowledge_and_Destination_Secrets.md) |
| **Source 4 (MD)** | `04_Supplier_Booking_Confirmations_and_48Hr_Branch_FollowUp_SOP.md` | Raw supplier confirmations (`DOC-BOOK-901`..`903`) for `iSell` auto-fill + 48-Hr Courtesy Follow-Up & Ancillary SOP | [Download MD](https://storage.cloud.google.com/merdogdu-sandbox-398713-haysbranch-7412-docs/notebook-demo/04_Supplier_Booking_Confirmations_and_48Hr_Branch_FollowUp_SOP.md) |
| **Table 1 (CSV)** | `branch_customers.csv` | 50 Maidenhead branch customer rows (with `iSell` duplicate counts, lifetime spend, and FX balances) | [Download CSV](https://storage.cloud.google.com/merdogdu-sandbox-398713-haysbranch-7412-docs/notebook-demo/branch_customers.csv) |
| **Table 2 (CSV)** | `holiday_cruise_catalog.csv` | 50 holiday & cruise packages comparing 3rd-Party vs. Hays Vista pricing, commission, and veteran tips | [Download CSV](https://storage.cloud.google.com/merdogdu-sandbox-398713-haysbranch-7412-docs/notebook-demo/holiday_cruise_catalog.csv) |
| **Table 3 (CSV)** | `branch_quotes_and_tasks.csv` | 55 active Maidenhead branch quotes (`QT-MAID-901` .. `955`), re-keying minutes saved, and 48-hr follow-up status | [Download CSV](https://storage.cloud.google.com/merdogdu-sandbox-398713-haysbranch-7412-docs/notebook-demo/branch_quotes_and_tasks.csv) |

---

## 2. The 4 Prompts to Use in Your Gemini Notebook Demo

### Prompt 1 — Instant Walk-In Customer Briefing (Kills the 20-Minute `iSell` Search)
> **What to tell the customer:** *"When David and Sarah Henderson walk into our Maidenhead branch on a busy Saturday, the consultant just types their names—no IDs needed. Watch how Gemini Notebook synthesizes all 4 of their fragmented `iSell` records in one second:"*

```text
David and Sarah Henderson just walked into the Maidenhead branch for their 30th wedding anniversary trip. Merge all of their fragmented iSell profiles into a single Walk-In Consultant Briefing Card: list their legacy iSell IDs, total combined lifetime spend, cabin and dining preferences, any critical medical or dietary alerts, and what is currently sitting on their Sunny Spend card.
```

**What Gemini Notebook will highlight (with citations to Source 1):**
* **4 Merged `iSell` IDs:** `ISELL-88210`, `ISELL-88214`, `ISELL-90102`, `ISELL-94311` (**£28,450** combined lifetime spend — Gold Loyalty Tier).
* **Motion Sickness & Cabin Rule:** David gets motion sickness forward/aft — **must have a Mid-Ship Balcony**.
* **Critical Dietary Alert:** Sarah was diagnosed with **Coeliac Disease** in 2023 (`ISELL-90102`) — requires strict Gluten-Free dining (`GF-MED-COELIAC`) pre-logged 14+ days before sailing.
* **Unspent Foreign Currency:** **£410.00 (approx. €480)** is still sitting on their `Sunny Spend` card `#SS-9941-EUR` from their 2024 Rhodes trip.

---

### Prompt 2 — "Veteran Consultant Brain" + Vista Commission Uplift (Couples & Families)
> **What to tell the customer:** *"Newer branch staff often quote standard 3rd-party packages and miss critical destination or ship traps—like booking a balcony right above the lifeboats or sending a young family to a stony beach in Marbella. Watch Gemini Notebook cross-reference our Vista catalog with 20 years of veteran tribal knowledge using just the customers' names:"*

```text
Recommend the best package for two walk-in customers today: (1) David & Sarah Henderson wanting a 14-night Canary Islands cruise & stay, and (2) Emma & Tom Miller wanting a 7-night Spain family beach holiday under £3,500 with soft sand and a short transfer for their travel-sick 6-year-old. For both, compare the 3rd-party price and commission against our Hays Vista Exclusive, calculate our total extra branch commission, and flag the Veteran Consultant warnings!
```

**What Gemini Notebook will highlight (with citations to Sources 1, 2 & 3):**
1. **For the Hendersons (`B629C` — P&O *Arvia* 10N + 4N 5* Riu Palace Tenerife):**
   * **Price & Commission:** Vista is **£6,140** vs. TUI **£6,290** (**saves the customer £150**), while Maidenhead branch commission jumps from **£660.45 (10.5%) to £1,338.52 (21.8%) = +£678.07 extra commission**.
   * **Veteran Ship Trap Avoided:** Warns **NOT to book Deck 8 Balcony** (yellow lifeboats and steel davits block the downward sea view and Promenade walkers can see in) — allocate **Deck 12 Mid-Ship (`Cabin C1204`)** and pre-book Coeliac dining at *The Olive Grove*.
2. **For the Miller Family (`FAM-TOR-402` — 4* Sol Principe Torremolinos):**
   * **Price & Commission:** Vista is **£3,240** vs. Jet2 **£3,390** (**saves the family £150**), while branch commission jumps from **£339.00 (10%) to £680.40 (21%) = +£341.40 extra commission**.
   * **Veteran Beach Trap Avoided:** Warns **against Marbella** (coarse stony shingle, steep 3m drop-off shelf, and 50-minute coach transfer) and switches them to **Playamar in Torremolinos** (flat golden sand, shallow water, and a **12-minute private taxi transfer** from Malaga Airport for 6-year-old Maya).
   * **Combined Branch Commission Uplift on Just Two Walk-Ins:** **+£1,019.47 extra margin!**

---

### Prompt 3 — Accessibility & Compliance Check (Mobility Scooter Cruise Verification)
> **What to tell the customer:** *"Accessibility mistakes cost branches thousands in re-accommodation fees and ruin holidays. Let’s ask the Notebook to verify whether Arthur Pendelton’s mobility scooter fits on a no-fly Fjords cruise:"*

```text
Margaret and Arthur Pendelton want a 7-night no-fly Norwegian Fjords cruise from Southampton and need to bring Arthur's folding Pride mobility scooter. Why did they have a problem on a past cruise, which exact package and cabin in our catalog is verified safe for them, and what port parking perk is included?
```

**What Gemini Notebook will highlight (with citations to Sources 1, 2, 3 & 4):**
* **Past Issue (`ISELL-65890`):** Standard cruise cabin doorways are only **54cm–58cm wide**, so Arthur's **62cm scooter** couldn't fit inside and SOLAS fire rules prohibit leaving scooters in corridors.
* **Verified Solution (`CRU-IONA-510` — P&O *Iona*, `Cabin E1108` Deck 11 Mid-Ship):** Confirmed **72cm clear doorway opening** (exceeds their 68cm minimum), zero-step threshold, 170cm turning circle, roll-in wet room, plus **free CPS Southampton Mayflower Terminal Valet Disability Parking (worth £135)** and **+£235.75 extra Vista commission**.

---

### Prompt 4 — Instant `iSell` Auto-Fill Block & 48-Hour Courtesy Script (Kills the 10-Min Re-Keying Tax)
> **What to tell the customer:** *"Finally, instead of spending 10 minutes typing flight numbers and PNR codes from a supplier confirmation into `iSell`, the consultant asks Gemini Notebook to generate the structured `iSell` paste block and the 48-hour courtesy message using just the customer's name:"*

```text
Using the P&O Arvia supplier booking confirmation for David & Sarah Henderson, generate: (1) a structured iSell Auto-Fill Summary Table with every reference, flight, cabin, SSR code, and commission figure ready to copy-paste, (2) the two high-margin branch ancillaries we must attach under the "Rule of Two", and (3) a warm 48-hour courtesy WhatsApp/email message from Chloe at Maidenhead branch.
```

**What Gemini Notebook will highlight (with citations to Sources 3 & 4):**
* **Structured `iSell` Paste Block:** Quote `QT-MAID-901` | PNR `ARV-99412-PO / VISTA-HT-88412` | Flights `TOM4122 / TOM4123` (`LGW-TFS`, 14–28 Nov 2026) | Cabin `C1204` (Deck 12 Mid-Ship) | Hotel `Riu Palace Tenerife` | SSR `GF-MED-COELIAC` | Gross `£6,140.00` | Commission `£1,338.52 (21.8%)`.
* **"Rule of Two" Ancillaries:** (1) `Holiday Extras` Gatwick Meet & Greet + No1 Lounge (`HX-LGW-MGL` at **£209.00**, earning **£50.16** branch commission), and (2) Top up their existing `Sunny Spend` card `#SS-9941-EUR` (which already holds **£410**) by £500+ for preferential branch Euro rates.
* **Ready-to-Send 48-Hour Courtesy Message** from Chloe Evans at Maidenhead Branch.

---

### Prompt 5 — Saturday Branch Manager Huddle: Full-Day Vista Margin Roll-Up & Urgent 48-Hr Chasers
> **What to tell the customer:** *"To close the demo, let’s look at the branch manager’s view at the end of a busy Saturday. With one prompt, we roll up all 5 walk-in appointments—including Priya & Raj Patel’s Mauritius honeymoon and Callum & Fiona MacLeod’s New York & Boston trip—to see our total customer savings, total extra Vista commission for the branch, and which quotes need an urgent 48-hour call:"*

```text
Create an End-of-Day Branch Huddle Summary table for Maidenhead across all 5 of today's walk-in households (Hendersons, Millers, Pendeltons, Priya & Raj Patel, and Callum & Fiona MacLeod). For each household, show their special requirements, the 3rd-party price vs our Hays Vista price, how much the customer saves, and the extra branch commission we earn. Sum up the total extra commission unlocked today and list which held options expire in the next 48 hours.
```

**What Gemini Notebook will highlight (with citations across all 4 Sources):**
* **5-Household Comparison Table:**
  1. **David & Sarah Henderson (Canary Islands Cruise & Stay):** TUI £6,290 vs. Vista **£6,140** (**Saves £150** | **+£678.07 extra commission**) — Mid-Ship Deck 12 & Coeliac dining.
  2. **Emma & Tom Miller (Torremolinos Family Beach):** Jet2 £3,390 vs. Vista **£3,240** (**Saves £150** | **+£341.40 extra commission**) — Flat soft sand & 12-min private taxi transfer.
  3. **Margaret & Arthur Pendelton (Norwegian Fjords Accessible Cruise):** Direct £2,980 vs. Vista **£2,890** (**Saves £90** | **+£235.75 extra commission**) — 72cm cabin doorway (`E1108`) + free CPS port valet parking.
  4. **Priya & Raj Patel (Mauritius 10N Honeymoon — `LUX* Le Morne`):** Kuoni £7,790 vs. Vista **£7,490** (**Saves £300** | **+£753.45 extra commission**) — Sheltered west coast (avoids trade winds) + Jain/Hindu vegetarian kitchen.
  5. **Callum & Fiona MacLeod (NYC & Boston 6N Rail & Stay):** BA Holidays £4,180 vs. Vista **£3,990** (**Saves £190** | **+£399.95 extra commission**) — Amtrak Acela Business Class + daytime return flight from Boston.
* **Total Single-Day Branch Impact:** Customers save **£880.00 combined**, while Maidenhead branch unlocks **+£2,408.62 in extra commission** in a single day!
* **Urgent 48-Hour Expiry Alerts:** Flags **Emma & Tom Miller’s** held option (Free Child Place expires in 48 hours) and **Margaret & Arthur Pendelton’s** held accessible cabin on P&O *Iona*.

---

## 3. Copy-Pasteable Source Documents (If Pasting Directly into Gemini Notebook)

### Source 1: `01_Maidenhead_Branch_WalkIn_Customer_Profiles_and_iSell_Notes.md`

````markdown
# Hays Travel Maidenhead Branch (MAID-042) — Walk-In Customer Profiles & Legacy iSell Notes

**Document Reference:** `HT-MAID-CRM-2026-Q4`
**Branch:** Maidenhead High Street (`MAID-042`)

## Household 1: David & Sarah Henderson (Unified ID: `CUST-101`)
* **Walk-In Reason:** Celebrating **30th Wedding Anniversary** in November 2026; looking for a **14-Night Canary Islands Winter-Sun Cruise & Stay** (budget up to £6,500 total).
* **Legacy Duplicate `iSell` Profiles Found (4 Fragmented Records):**
  1. `ISELL-88210` — *"D. Henderson, SL6 1QJ"* (Created 2019 — P&O Britannia Norwegian Fjords, £5,890). Consultant note: *"David gets motion sickness if booked forward or aft; MUST have a Mid-Ship Balcony cabin."*
  2. `ISELL-88214` — *"David & Sarah Henderson, SL6 8AA"* (Created 2021 — Jet2 Indulgent Escapes Tenerife, £6,420). Consultant note: *"Loved Costa Adeje promenade. Found standard buffet noisy; prefers adult-focused or quiet dining."*
  3. `ISELL-90102` — *"Mrs Sarah Henderson, Maidenhead"* (Created 2023 — P&O Iona Mediterranean Fly-Cruise, £8,950). **CRITICAL MEDICAL/DIETARY ALERT:** *"Sarah was diagnosed with Coeliac Disease in 2023 — requires strict Gluten-Free dining pre-logged with both the cruise line and hotel at least 14 days prior to departure."*
  4. `ISELL-94311` — *"Mr D Henderson (Email Enquiry)"* (Created 2024 — TUI Rhodes 5* Boutique, £7,190). Consultant note: *"Always books Gatwick Meet & Greet parking and No1 Lounge when flying from LGW."*
* **Total Verified Lifetime Spend Across All 4 Profiles:** **£28,450** (Gold Loyalty Tier)
* **Hays `Sunny Spend` Travel Money Card:** Active Card `#SS-9941-EUR` with **£410.00 (approx. €480)** unspent balance remaining from their 2024 Rhodes trip.

## Household 2: Emma & Tom Miller + 2 Children, Leo [9] & Maya [6] (Unified ID: `CUST-102`)
* **Walk-In Reason:** Looking for a **7-Night August School Holiday Family Beach Package in Spain** under **£3,500 total** for 2 adults + 2 children.
* **Legacy Duplicate `iSell` Profiles Found (3 Fragmented Records):**
  1. `ISELL-71044` — *"Emma Miller, SL6 2PL"* (Created 2022 — Majorca Alcudia 4*, £3,120). Consultant note: *"Kids loved the shallow sandy bay and onsite splash park. Wants short airport transfer (under 30 mins) because Maya gets travel sick on winding coach journeys."*
  2. `ISELL-71049` — *"Tom & Emma Miller"* (Created 2023 — Algarve Albufeira, £3,480). Consultant note: *"Disliked steep steps down to the beach; wants flat promenade access straight from the hotel pool gate."*
  3. `ISELL-79812` — *"Mrs E Miller (Web Lead)"* (Created 2025 — Quote enquiry for Costa del Sol). Consultant note: *"Customer asked about Marbella because a friend went there, but she specifically wants soft, flat sand and shallow water for the kids."*
* **Total Verified Lifetime Spend Across All 3 Profiles:** **£6,600** (Family Club Tier)
* **Hays `Sunny Spend` Travel Money Card:** Active Card `#SS-4412-EUR` with **£85.00** balance.

## Household 3: Margaret & Arthur Pendelton (Unified ID: `CUST-103`)
* **Walk-In Reason:** Looking for a **7-Night No-Fly Cruise from Southampton** (Norwegian Fjords) where Arthur can bring his **folding Pride Mobility Scooter (width: 62cm)**.
* **Legacy Duplicate `iSell` Profiles Found (3 Fragmented Records):**
  1. `ISELL-62011` — *"Arthur Pendelton, Henley-on-Thames"* (Created 2020 — Coach Tour Scottish Highlands, £2,190).
  2. `ISELL-65890` — *"Mr & Mrs A. Pendelton"* (Created 2022 — Fred. Olsen Bolette, £4,890). **CRITICAL ACCESSIBILITY ALERT:** *"Standard cruise cabin doorways (54cm–58cm) are TOO NARROW for Arthur's mobility scooter. Cabin doorway MUST be at least 68cm wide with zero threshold lip and a roll-in wet room."*
  3. `ISELL-69104` — *"Margaret Pendelton"* (Created 2024 — Southampton Port Valet Cruise, £5,370). Consultant note: *"Requires CPS (Cruise & Passenger Services) valet disability parking right outside Southampton Mayflower or Horizon Terminal."*
* **Total Verified Lifetime Spend Across All 3 Profiles:** **£12,450** (Silver Loyalty Tier)
````

---

### Source 2: `02_Hays_Vista_vs_3rdParty_Holiday_and_Cruise_Handbook_2026.md`

````markdown
# Hays Travel Retail Branch Product & Margin Guide — 3rd-Party vs. Hays Vista Exclusives (2026)

**Document Reference:** `HT-COMMERCIAL-VISTA-2026`

## Package 1: `B629C` — P&O Arvia 14-Night Canary Islands Fly-Cruise & Riu Palace Tenerife Stay
* **Target Customer Fit:** Couples / Anniversary Luxury Winter Sun (Ideal for **David & Sarah Henderson — `CUST-101`**).
* **Flights:** London Gatwick (`LGW`) to Tenerife South (`TFS`) via `TOM4122` / `TOM4123` (23kg luggage + private transfers).
* **Itinerary:** 10 Nights aboard **P&O *Arvia*** + 4 Nights 5* **Hotel Riu Palace Tenerife** (Costa Adeje Oceanfront).
* **Commercial & Commission Comparison:**
  * **3rd-Party Operator (TUI / P&O Standard):** **£6,290.00** total | **10.5% commission (£660.45)**
  * **Hays Travel Vista Exclusive (`B629C`):** **£6,140.00** total (**Saves customer £150.00!**) | **21.8% commission (£1,338.52)** | **+£678.07 Extra Branch Commission**
  * **Vista Free Perks:** €150 On-Board Spend (OBS) + Priority Anniversary Dining Voucher at *The Olive Grove* + Private Port-to-Hotel Transfer.
  * **Cabin Rule:** Allocate **Deck 12 Mid-Ship Superior Balcony (`Cabin C1204`)** — DO NOT allocate Deck 8.

## Package 2: `FAM-TOR-402` — Sol Principe Torremolinos 4* Family Splash Resort (Costa del Sol, Spain)
* **Target Customer Fit:** Family of 4 seeking flat soft-sand beach & splash park under £3,500 (Ideal for **Emma & Tom Miller — `CUST-102`**).
* **Flights & Transfer:** `LGW` to Malaga (`AGP`) — **12-minute private taxi transfer** (8 km flat road, zero winding mountain roads).
* **Commercial & Commission Comparison:**
  * **3rd-Party Operator (Jet2holidays Standard):** **£3,390.00** total | **10.0% commission (£339.00)**
  * **Hays Travel Vista Exclusive (`FAM-TOR-402`):** **£3,240.00** total (**Saves family £150.00!**) | **21.0% commission (£680.40)** | **+£341.40 Extra Branch Commission**
  * **Vista Free Perks:** Free Child Place + Private 12-min taxi transfer + Free Katmandu Splash Park Pass.

## Package 3: `CRU-IONA-510` — P&O Iona 7-Night Norwegian Fjords No-Fly Accessible Cruise
* **Target Customer Fit:** Accessible No-Fly Cruise from Southampton (Ideal for **Margaret & Arthur Pendelton — `CUST-103`**).
* **Verified Accessibility (`Cabin E1108` — Deck 11 Mid-Ship Accessible Balcony):** **72 cm clear doorway opening** (fits 62 cm Pride scooter easily), zero-step threshold, 170 cm turning circle, full roll-in wet room.
* **Commercial & Commission Comparison:**
  * **Standard Direct Rate:** **£2,980.00** (11.0% comm = **£327.80**)
  * **Hays Vista Cruise Plus (`CRU-IONA-510`):** **£2,890.00** (**Saves £90.00** | 19.5% comm = **£563.55** | **+£235.75 Extra Branch Commission**) + **Free CPS Southampton Mayflower Terminal Valet Disability Parking (worth £135)**.
````

---

### Source 3: `03_Veteran_Consultant_Tribal_Knowledge_and_Destination_Secrets.md`

````markdown
# Hays Travel SMILE Knowledge Base — Veteran Consultant Destination & Ship Secrets

**Document Reference:** `HT-SMILE-TRIBAL-2026`

## 1. P&O *Arvia* & *Iona* — The Deck 8 Lifeboat Overhang Trap
* Newer consultants frequently book **Deck 8 Balcony Cabins** because they are £80 cheaper.
* **Veteran Warning:** On *Arvia* and *Iona*, the yellow lifeboats and steel davits hang directly below Deck 8, completely blocking the downward view of the sea, and Promenade deck walkers can look into Deck 8 balconies.
* **Veteran Fix:** Always book **Deck 12 Mid-Ship (`Cabin C1204` on package `B629C`)** for an unobstructed vertical ocean view and minimal mid-ship motion. For Coeliac passengers (like Sarah Henderson), pre-log `GF-MED-COELIAC` 14 days prior and book **The Olive Grove** specialty restaurant.

## 2. Costa del Sol Family Beaches — Soft-Sand Torremolinos vs. Stony Marbella
* Parents often ask for **Marbella** assuming it has soft sand, but central Marbella beaches have **coarse stony shingle**, a **steep 3-metre drop-off shelf**, and a **50-minute coach transfer**.
* **Veteran Fix:** Switch young families (like **Emma & Tom Miller — `CUST-102`**) to **Playamar Beach in Torremolinos (`FAM-TOR-402` — Sol Principe)**: wide, flat golden sand, shallow paddling water, and only **12 minutes from Malaga Airport**.

## 3. The "Rule of Two" High-Margin Branch Add-Ons
1. **`Holiday Extras` Gatwick Meet & Greet + No1 Lounge (`HX-LGW-MGL`):** **£209.00** (Saves customer 18%; earns **24% branch commission = £50.16**).
2. **Hays `Sunny Spend` Prepaid Travel Money Card:** Check unspent balances (Hendersons already have **£410** on `#SS-9941-EUR`) and top up £500+ at the branch FX desk for preferential Euro rates and zero overseas ATM fees.
````

---

### Source 4: `04_Supplier_Booking_Confirmations_and_48Hr_Branch_FollowUp_SOP.md`

````markdown
# Hays Travel Maidenhead Branch — Supplier Booking Confirmations & 48-Hour Follow-Up SOP

**Document Reference:** `HT-OPS-BOOKINGS-2026`

## Confirmation `DOC-BOOK-901` (Matches Quote `QT-MAID-901` — David & Sarah Henderson)
* **Passengers:** Mr David Henderson & Mrs Sarah Henderson (`CUST-101`)
* **Branch Quote Ref:** `QT-MAID-901` (Maidenhead Branch `MAID-042` — Chloe Evans)
* **Vista Package ID:** `B629C` — 14N Canary Islands Cruise & Riu Palace Tenerife Stay
* **Supplier PNR Ref:** `ARV-99412-PO / VISTA-HT-88412` (ATOL `5534`)
* **Outbound Flight:** `14 NOV 2026` | `TUI Airways TOM4122` | `LGW (08:15) -> TFS (12:40)` (2x 23kg bags)
* **Inbound Flight:** `28 NOV 2026` | `TUI Airways TOM4123` | `TFS (14:10) -> LGW (18:30)`
* **Cruise Segment (14–24 Nov 2026, 10N):** Vessel `P&O Arvia` | Cabin `C1204` (Deck 12 Mid-Ship Superior Balcony) | Dining: *The Olive Grove* pre-booked 14 Nov 19:30 | SSR `GF-MED-COELIAC` logged for Mrs Sarah Henderson | Perks: `€150 On-Board Spend (OBS)`
* **Hotel Segment (24–28 Nov 2026, 4N):** `Hotel Riu Palace Tenerife` (5* Costa Adeje, Ocean View Junior Suite, Half Board Plus, Coeliac protocol confirmed, Private Port/Airport Transfers included)
* **Commercial Summary for `iSell`:** Gross Package Price **£6,140.00** (Deposit Paid: £614.00 | Balance Due: £5,526.00) | Vista Branch Commission (21.8%): **£1,338.52** (+£678.07 extra vs. 3rd-Party TUI £660.45).
* **Mandatory 48-Hr Courtesy Task (`TSK-BR-101`):** Send 48-hour confirmation message from Chloe at Maidenhead Branch confirming Sarah's Coeliac code `GF-MED-COELIAC`, attaching `Holiday Extras` Gatwick Meet & Greet + No1 Lounge (`£209.00`), and reminding David of the **£410.00** Euro balance on `Sunny Spend` card `#SS-9941-EUR`.
````
