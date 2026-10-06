# Demo 3: Hays Branch Gemini Notebook — Short Presenter Script & Prompts

## 1. Before the Call (1-Minute Setup)
Open **NotebookLM / Gemini Notebook** and add the **4 files** from Section 4 below (either upload the `.md` files from [Cloud Storage](https://console.cloud.google.com/storage/browser/merdogdu-sandbox-398713-haysbranch-7412-docs/notebook-demo?project=merdogdu-sandbox-398713) or copy-paste them from Section 4 as *"Copied Text"*):
1. `01` — Customer notes from `iSell`
2. `02` — Hays Vista vs. 3rd-party holiday catalog
3. `03` — Veteran staff tips (ship decks & beaches)
4. `04` — Supplier booking confirmations

---

## 2. Live Demo Talk-Track & Short Prompts (3 Minutes Total)

### 🎤 Opening (20 Seconds)
**Say to the customer:**
> *"In this demo, I will show you how a store agent can use **Gemini Notebook** with **zero coding and zero IT setup**.*
> *We uploaded four simple files: customer notes from `iSell`, your Hays Vista price guide, insider tips from your best veteran agents, and booking confirmations.*
> *Now, even a brand-new starter can talk to all of this knowledge in plain English."*

---

### Step 1: Walk-In Customer Briefing + Best Holiday (Prompt 1)
**Say to the customer:**
> *"David and Sarah Henderson just walked into the Maidenhead store for their 30th anniversary. Let's ask Gemini to pull their history and recommend the best package."*

**Copy & Paste (Short Prompt 1):**
```text
David and Sarah Henderson just walked in for their 30th anniversary. Merge their duplicate iSell notes, check their Sunny Spend card, and compare the 3rd-party vs Hays Vista Canary Islands cruise package—including extra branch commission and veteran cabin tips.
```

**Point to the screen and say:**
* *"It merged **4 duplicate `iSell` profiles** (£28,450 spend), spotted that **Sarah is Coeliac (gluten-free)**, and found **£410** on their `Sunny Spend` card."*
* *"It switches them from TUI (£6,290) to **Hays Vista (£6,140)**—saving the customer **£150** while earning the store **+£678 in extra commission**."*
* *"And it warns the agent: **do not book Deck 8 on P&O Arvia** because lifeboats block the view—book **Deck 12 Mid-Ship** instead."*

---

### Step 2: Family Beach + Mobility Scooter Check (Prompt 2)
**Say to the customer:**
> *"Now let's check two more walk-ins at the same time: the **Miller family** looking for a soft-sand beach in Spain, and **Margaret & Arthur Pendelton** who need a cruise cabin wide enough for a mobility scooter."*

**Copy & Paste (Short Prompt 2):**
```text
Recommend the best Vista package for: (1) Emma & Tom Miller (Spain family beach under £3,500 with soft sand and short transfer), and (2) Margaret & Arthur Pendelton (no-fly Fjords cruise from Southampton for a mobility scooter). Show prices, extra Vista commission, and veteran tips.
```

**Point to the screen and say:**
* **For the Miller Family:** *"Veteran tip warns **not to book Marbella** (stony beach, 50-minute coach) and switches them to **Torremolinos** (flat golden sand, **12-minute taxi transfer** for their travel-sick child)—saving £150 and adding **+£341 extra commission**."*
* **For the Pendeltons:** *"Standard cruise doors (56 cm) are too narrow for Arthur's 62 cm scooter. Gemini finds **P&O Iona Cabin E1108** with a verified **72 cm doorway** plus **free port valet parking**."*

---

### Step 3: Auto-Fill `iSell` + End-of-Day Manager Summary (Prompt 3)
**Say to the customer:**
> *"Finally, let's auto-fill `iSell` from the Hendersons' booking confirmation and show the Branch Manager the total extra commission unlocked across all 5 walk-in families today."*

**Copy & Paste (Short Prompt 3):**
```text
Extract the iSell auto-fill table and 48-hour courtesy message from David & Sarah Henderson's booking confirmation, and create an End-of-Day Branch Summary table across all 5 walk-in households showing customer savings, extra Vista commission, and quotes expiring in 48 hours.
```

**Point to the screen and say:**
* *"First, it extracts every flight, cabin, and PNR detail ready to paste into `iSell`—saving **10 minutes of manual typing**—plus a ready-to-send 48-hour courtesy message."*
* *"Second, look at the End-of-Day table across all 5 families: customers saved **£880**, and this single store unlocked **£2,408 in extra Vista commission** today."*

---

### 🎯 Closing Line (10 Seconds)
**Say to the customer:**
> *"In under 3 minutes, Gemini turned messy store notes and brochures into faster service, zero mistakes, and **double the commission**—using plain English that any agent can use on day one."*

---

## 3. Quick Copy Cheat-Sheet (All 3 Short Prompts Together)

1. `David and Sarah Henderson just walked in for their 30th anniversary. Merge their duplicate iSell notes, check their Sunny Spend card, and compare the 3rd-party vs Hays Vista Canary Islands cruise package—including extra branch commission and veteran cabin tips.`
2. `Recommend the best Vista package for: (1) Emma & Tom Miller (Spain family beach under £3,500 with soft sand and short transfer), and (2) Margaret & Arthur Pendelton (no-fly Fjords cruise from Southampton for a mobility scooter). Show prices, extra Vista commission, and veteran tips.`
3. `Extract the iSell auto-fill table and 48-hour courtesy message from David & Sarah Henderson's booking confirmation, and create an End-of-Day Branch Summary table across all 5 walk-in households showing customer savings, extra Vista commission, and quotes expiring in 48 hours.`

---

## 4. The 4 Synthetic Source Documents (If Pasting into Gemini Notebook)

### Source 1: `01_Maidenhead_Branch_WalkIn_Customer_Profiles_and_iSell_Notes.md`
````markdown
# Hays Travel Maidenhead Branch (MAID-042) — Walk-In Customer Profiles & Legacy iSell Notes

## Household 1: David & Sarah Henderson (Unified ID: `CUST-101`)
* **Walk-In Reason:** Celebrating **30th Wedding Anniversary** in November 2026; looking for a **14-Night Canary Islands Winter-Sun Cruise & Stay** (budget up to £6,500 total).
* **Legacy Duplicate `iSell` Profiles Found (4 Fragmented Records):**
  1. `ISELL-88210` — *"D. Henderson, SL6 1QJ"* (2019 — P&O Britannia Norwegian Fjords, £5,890). Note: *"David gets motion sickness forward/aft; MUST have a Mid-Ship Balcony cabin."*
  2. `ISELL-88214` — *"David & Sarah Henderson, SL6 8AA"* (2021 — Jet2 Tenerife, £6,420). Note: *"Loved Costa Adeje promenade. Prefers quiet dining."*
  3. `ISELL-90102` — *"Mrs Sarah Henderson, Maidenhead"* (2023 — P&O Iona Med Cruise, £8,950). **CRITICAL DIETARY ALERT:** *"Sarah has Coeliac Disease — requires strict Gluten-Free dining (`GF-MED-COELIAC`) pre-logged 14+ days before sailing."*
  4. `ISELL-94311` — *"Mr D Henderson"* (2024 — TUI Rhodes 5*, £7,190). Note: *"Always books Gatwick Meet & Greet parking and No1 Lounge."*
* **Total Verified Lifetime Spend Across All 4 Profiles:** **£28,450** (Gold Loyalty Tier)
* **Hays `Sunny Spend` Card:** Active Card `#SS-9941-EUR` with **£410.00 (approx. €480)** unspent balance remaining.

## Household 2: Emma & Tom Miller + 2 Children, Leo [9] & Maya [6] (Unified ID: `CUST-102`)
* **Walk-In Reason:** **7-Night August Family Beach Package in Spain** under **£3,500 total** for 2 adults + 2 children.
* **Legacy Duplicate `iSell` Profiles Found (3 Records):** `ISELL-71044`, `ISELL-71049`, `ISELL-79812` (**£6,600** lifetime spend).
* **Key Notes:** Maya (6) gets travel sick on winding coach transfers — needs **short airport transfer (under 30 mins)**. Customer asked about Marbella, but specifically wants **flat, soft sand and shallow paddling water** plus a splash park.
* **Hays `Sunny Spend` Card:** `#SS-4412-EUR` with **£85.00** balance.

## Household 3: Margaret & Arthur Pendelton (Unified ID: `CUST-103`)
* **Walk-In Reason:** **7-Night No-Fly Norwegian Fjords Cruise from Southampton** where Arthur can bring his **folding Pride Mobility Scooter (width: 62cm)**.
* **Legacy Duplicate `iSell` Profiles Found (3 Records):** `ISELL-62011`, `ISELL-65890`, `ISELL-69104` (**£12,450** lifetime spend).
* **CRITICAL ACCESSIBILITY ALERT:** Standard cruise cabin doorways (54cm–58cm) are TOO NARROW for Arthur's 62cm scooter, and maritime fire rules prohibit leaving scooters in corridors. Cabin doorway **MUST be at least 68cm wide** with zero threshold and a roll-in wet room. Requires CPS valet disability parking at Southampton terminal.

## Household 4: Priya & Raj Patel (Unified ID: `CUST-104`)
* **Walk-In Reason:** 10-Night Luxury Mauritius Honeymoon (Budget: £7,800). 2 `iSell` records (`ISELL-91004`, `ISELL-91882`, £14,200 spend).
* **Key Notes:** Strict Jain/Hindu vegetarian dining required; prefers sheltered west-coast Mauritius (Le Morne) to avoid east-coast winter trade winds. `Sunny Spend` balance: **£195.00**.

## Household 5: Callum & Fiona MacLeod (Unified ID: `CUST-105`)
* **Walk-In Reason:** 6-Night New York & Boston Autumn Rail & Stay (Budget: £4,200). 3 `iSell` records (`ISELL-55102`, `ISELL-55918`, `ISELL-60119`, £19,300 spend).
* **Key Notes:** Wants Midtown NYC hotel near Bryant Park, Amtrak train to Boston, and daytime return flight from Boston to Heathrow. `Sunny Spend` balance: **$310 (£245.00)**.
````

### Source 2: `02_Hays_Vista_vs_3rdParty_Holiday_and_Cruise_Handbook_2026.md`
````markdown
# Hays Travel Retail Branch Product & Margin Guide — 3rd-Party vs. Hays Vista Exclusives (2026)

1. **`B629C` — P&O Arvia 14-Night Canary Islands Fly-Cruise & 5* Riu Palace Tenerife Stay** (Fits **David & Sarah Henderson**):
   * **3rd-Party (TUI):** **£6,290.00** total | **10.5% commission (£660.45)**
   * **Hays Vista Exclusive (`B629C`):** **£6,140.00** (**Saves customer £150.00**) | **21.8% commission (£1,338.52)** | **+£678.07 Extra Branch Commission**
   * **Perks & Cabin:** Includes €150 On-Board Spend + *The Olive Grove* dining voucher + private transfers. Allocate **Deck 12 Mid-Ship (`Cabin C1204`)**, NOT Deck 8.
2. **`FAM-TOR-402` — 4* Sol Principe Torremolinos Family Splash, Costa del Sol** (Fits **Emma & Tom Miller**):
   * **3rd-Party (Jet2holidays):** **£3,390.00** total | **10.0% commission (£339.00)**
   * **Hays Vista Exclusive (`FAM-TOR-402`):** **£3,240.00** (**Saves family £150.00**) | **21.0% commission (£680.40)** | **+£341.40 Extra Branch Commission**
   * **Perks:** Free Child Place + **Private 12-minute taxi transfer from Malaga Airport** + Katmandu Splash Park Pass.
3. **`CRU-IONA-510` — P&O Iona 7-Night Norwegian Fjords Accessible Cruise from Southampton** (Fits **Margaret & Arthur Pendelton**):
   * **Standard Direct Rate:** **£2,980.00** (11.0% comm = **£327.80**)
   * **Hays Vista Cruise Plus (`CRU-IONA-510`):** **£2,890.00** (**Saves £90.00**) | **19.5% commission (£563.55)** | **+£235.75 Extra Branch Commission**
   * **Verified Accessibility (`Cabin E1108` Deck 11 Mid-Ship):** **72 cm clear doorway** (fits 62 cm Pride scooter), roll-in wet room, 170 cm turning circle + **Free CPS Southampton Port Valet Disability Parking (worth £135)**.
4. **`LUX-MRU-701` — LUX* Le Morne Mauritius 10-Night Honeymoon** (Fits **Priya & Raj Patel**):
   * **3rd-Party (Kuoni):** **£7,790.00** (11.0% comm = £856.90) vs. **Hays Vista:** **£7,490.00** (**Saves £300.00** | 21.5% comm = **£1,610.35** | **+£753.45 Extra Branch Commission**). Sheltered west coast + certified Jain/Hindu vegetarian kitchen.
5. **`NYC-BOS-808` — New York Bryant Park & Boston Back Bay 6-Night Rail & Stay** (Fits **Callum & Fiona MacLeod**):
   * **3rd-Party (BA Holidays):** **£4,180.00** (10.0% comm = £418.00) vs. **Hays Vista:** **£3,990.00** (**Saves £190.00** | 20.5% comm = **£817.95** | **+£399.95 Extra Branch Commission**). Includes Amtrak Acela Business Class + daytime BA return flight from Boston.
````

### Source 3: `03_Veteran_Consultant_Tribal_Knowledge_and_Destination_Secrets.md`
````markdown
# Hays Travel SMILE Knowledge Base — Veteran Consultant Destination & Ship Secrets

1. **P&O *Arvia* & *Iona* — Avoid the Deck 8 Lifeboat Overhang Trap:**
   * Deck 8 Balcony cabins sit directly above the yellow lifeboats and steel davits, blocking the downward sea view, and Promenade walkers can look inside. Always book **Deck 12 Mid-Ship (`Cabin C1204`)**. For Coeliac guests (Sarah Henderson), pre-log `GF-MED-COELIAC` 14 days prior and book **The Olive Grove**.
2. **Costa del Sol Family Beaches — Soft-Sand Torremolinos vs. Stony Marbella:**
   * Central Marbella beaches have coarse stony pebbles, a steep 3m drop-off shelf, and a 50-minute coach transfer. Always switch young families (Miller family) to **Playamar Beach in Torremolinos (`FAM-TOR-402` — Sol Principe)** for flat golden sand, shallow water, and a **12-minute Malaga Airport transfer**.
3. **The "Rule of Two" High-Margin Branch Add-Ons:**
   * Always attach **(1) `Holiday Extras` Gatwick Meet & Greet + No1 Lounge (`HX-LGW-MGL` at £209.00, earning £50.16 commission)** and **(2) Hays `Sunny Spend` Travel Money Card top-up (£500+ unlocks preferential Euro rate + zero overseas ATM fees)**.
````

### Source 4: `04_Supplier_Booking_Confirmations_and_48Hr_Branch_FollowUp_SOP.md`
````markdown
# Hays Travel Maidenhead Branch — Supplier Booking Confirmations & 48-Hour Follow-Up SOP

* **Confirmed Booking `DOC-BOOK-901` (David & Sarah Henderson — Quote `QT-MAID-901`):**
  * **Vista Package:** `B629C` (14N P&O Arvia Canary Islands + 5* Riu Palace Tenerife) | **PNR:** `ARV-99412-PO / VISTA-HT-88412` (ATOL 5534)
  * **Flights:** `14 NOV 2026 TOM4122 LGW (08:15)->TFS (12:40)` | `28 NOV 2026 TOM4123 TFS (14:10)->LGW (18:30)` (2x 23kg bags)
  * **Cruise & Hotel:** P&O *Arvia* Cabin `C1204` (Deck 12 Mid-Ship Balcony, €150 On-Board Spend, *The Olive Grove* booked 14 Nov 19:30, SSR `GF-MED-COELIAC`) + 4N *Hotel Riu Palace Tenerife* Ocean View Junior Suite + Private Transfers.
  * **Commercials for `iSell`:** Gross **£6,140.00** (Deposit £614.00 | Balance £5,526.00) | Vista Commission: **£1,338.52 (21.8% — +£678.07 extra)**.
  * **48-Hr Courtesy Task (`TSK-BR-101`):** Chloe at Maidenhead to send 48-hr confirmation message confirming Coeliac code `GF-MED-COELIAC`, attaching `Holiday Extras` Gatwick Meet & Greet + Lounge (`£209.00`), and reminding David of the **£410.00** on `Sunny Spend` card `#SS-9941-EUR`.
* **Held Options Expiring in 48 Hours (Urgent Branch Follow-Up Required):**
  1. **`DOC-BOOK-902` / `QT-MAID-902` (Emma & Tom Miller Family):** `FAM-TOR-402` Sol Principe Torremolinos (£3,240 Gross | £680.40 Comm) — **Free Child Place option expires in 48 hours!**
  2. **`DOC-BOOK-903` / `QT-MAID-903` (Margaret & Arthur Pendelton):** `CRU-IONA-510` P&O *Iona* Accessible Cabin `E1108` (72cm doorway, £2,890 Gross | £563.55 Comm) — **Accessible cabin hold expires in 48 hours!**
````
