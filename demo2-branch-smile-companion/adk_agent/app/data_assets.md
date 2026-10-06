### `branch_customers` - Unified Walk-In Customer 360 cards for Hays Travel retail branch consultants, combining duplicate legacy iSell records into one instant household profile with past holidays, room/cabin preferences, and Sunny Spend FX / Holiday Extras prompts.
Rows: 50. Coverage: no date column
  - `customer_id` STRING - Primary Key: Unified Branch Customer Household ID (e.g., CUST-101 for David & Sarah Henderson, CUST-102 for Emma & Tom Miller).
  - `branch_name` STRING - Home Hays Travel retail branch (e.g., Maidenhead). | values: Bournemouth, Leeds, Maidenhead, Newcastle, Sunderland
  - `customer_name` STRING - Customer / couple display name.
  - `postcode` STRING - UK postcode used for quick walk-in lookup.
  - `party_summary` STRING - Household composition and children's ages.
  - `isell_duplicates_merged` INTEGER - Number of duplicate legacy iSell profiles automatically combined into this single Customer Card.
  - `lifetime_spend_gbp` FLOAT - Total household holiday spend with Hays Travel in GBP (£).
  - `past_holidays_summary` STRING - Concise summary of recent holidays booked with Hays Travel.
  - `room_and_cabin_preferences` STRING - Important cabin, room, beach, accessibility, and dietary preferences learned from past trips.
  - `sunny_spend_fx_status` STRING - Hays Travel Sunny Spend travel money card status and FX upsell prompt.
  - `holiday_extras_notes` STRING - Preferred airport parking, lounge, and transfer add-ons.
  - `open_quote_status` STRING - Current walk-in inquiry or active quote status.

### `branch_quotes_and_tasks` - Active retail branch quotes, supplier screenshot-to-iSell auto-fill status, ancillary attachments (Holiday Extras & Sunny Spend FX), and 48-hour follow-up reminders.
Rows: 55. Coverage: no date column
  - `quote_ref` STRING - Primary Key: Branch Quote or Booking Reference (e.g., QT-MAID-901 for Hendersons, QT-MAID-902 for Millers).
  - `customer_id` STRING - Foreign Key to branch_customers.customer_id.
  - `package_code` STRING - Foreign Key to holiday_cruise_catalog.package_code.
  - `branch_name` STRING - Retail branch name (Maidenhead). | values: Maidenhead, Sunderland
  - `consultant_name` STRING - Branch consultant handling the customer (Rachel, Chloe, Sam). | values: Chloe (Apprentice Consultant), Rachel (Branch Manager), Sam (Senior Consultant)
  - `supplier_booking_ref` STRING - External supplier booking reference from Jet2, P&O CCS, easyJet, or Vista.
  - `rekey_status` STRING - Status of iSell entry: Pending_Screenshot_AutoFill, Auto_Filled_In_iSell, Quote_Sent_48Hr_FollowUp_Due. | values: Auto_Filled_In_iSell, Pending_Accessible_Cabin_Check, Pending_Screenshot_AutoFill, Quote_Sent_48Hr_FollowUp_Due
  - `flight_and_hotel_summary` STRING - Summary of flights, cabin/room grade, and hotel name.
  - `total_price_gbp` FLOAT - Total holiday package price in GBP (£).
  - `branch_commission_gbp` FLOAT - Commission earned by the branch in GBP (£).
  - `ancillaries_attached` STRING - Holiday Extras (parking/lounge) and Sunny Spend FX card status.
  - `next_branch_action` STRING - Recommended next step for the branch consultant.

### `holiday_cruise_catalog` - Hays Travel Retail Branch Holiday & Cruise Finder catalog containing cabin/room attributes, veteran consultant tribal tips, and side-by-side price/commission comparisons between 3rd-party suppliers and in-house Vista packages.
Rows: 50. Coverage: no date column
  - `package_code` STRING - Primary Key: Cruise Voyage Code or Holiday Package Code (e.g., B629C, FAM-TOR-402, CRU-IONA-510).
  - `holiday_type` STRING - Category: Cruise & Stay, Family Beach, Accessible Cruise, Family Luxury Beach, Adult Winter Sun. | values: Accessible Cruise, Adult Winter Sun, Cruise & Stay, Family Beach, Family Luxury Beach
  - `destination` STRING - Destination country, island, or resort town.
  - `ship_or_resort_name` STRING - Clean canonical cruise ship and/or hotel resort name.
  - `departure_airport_or_port` STRING - UK departure airport or cruise port. | values: London Gatwick / Heathrow, London Gatwick / Luton, London Gatwick / Manchester, London Heathrow / Gatwick, Southampton (No-Fly), Southampton / London Gatwick
  - `duration_nights` INTEGER - Holiday duration in nights.
  - `room_or_cabin_highlights` STRING - Detailed room/cabin attributes (interconnecting doors, soft sand, splash park, cabin deck, lift proximity, doorway width).
  - `veteran_tribal_tip` STRING - 20-year veteran consultant insider tip (e.g., stony vs soft-sand beaches in Marbella vs Torremolinos, lifeboat obstructions on Arvia Deck 8).
  - `standard_supplier_name` STRING - Standard 3rd-party tour operator (TUI, Jet2holidays, easyJet Holidays, P&O Direct). | values: Jet2holidays, P&O Direct, TUI, easyJet Holidays
  - `standard_supplier_price_gbp` FLOAT - 3rd-party supplier total package price in GBP (£).
  - `standard_commission_gbp` FLOAT - Branch commission earned on the 3rd-party supplier package (~10.5%) in GBP (£).
  - `vista_inhouse_price_gbp` FLOAT - Hays Travel in-house Vista package price in GBP (£) — typically £130-£150 cheaper for the customer.
  - `vista_branch_commission_gbp` FLOAT - Branch commission earned on the in-house Vista package (~21.5%) in GBP (£).
  - `extra_branch_commission_gbp` FLOAT - Extra commission in GBP (£) earned by the branch when choosing Vista over the 3rd-party supplier (+£678.07 on B629C).
  - `recommended_add_ons` STRING - Recommended Holiday Extras (airport parking, lounge) and Sunny Spend FX card load.
