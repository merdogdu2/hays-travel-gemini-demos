### `gold_customer_scv` - One row per unified household in the Azure Databricks Gold 4-Table Single Customer View (>450-point probabilistic identity resolution across iSell duplicates), enriched with Experian Mosaic UK and cancellation risk scores.
Rows: 55. Coverage: no date column
  - `scv_household_id` STRING - Primary Key. Unified Databricks Gold Household ID resolving 3-5 duplicate Traveltek iSell profiles (e.g. SCV-HH-84920).
  - `primary_customer_name` STRING - Resolved lead passenger household name.
  - `isell_duplicate_count` INTEGER - Count of fragmented Traveltek iSell customer profiles merged into this household record.
  - `experian_mosaic_tier` STRING - Experian Mosaic UK demographic classification (90% household match across Hays Travel). | values: A02 Uptown Elite, A03 Prestige Positions, A04 Suburban Stability, B05 Thriving Empty Nesters, B06 Boomerang Boarders, B07 Senior Security, G29 Domestic Success, H33 Family Basics
  - `home_branch_code` STRING - Primary retail branch or Contact Centre unit code (e.g. MAID-042 for Maidenhead, PTCLS-01, CRUI-CC1). | values: BIRM-031, CRUI-CC1, LEED-022, MAID-042, MANC-019, NEWC-014, PTCLS-01, SUND-001
  - `lifetime_value_gbp` FLOAT - 10-year cumulative household Total Transaction Value (TTV) in GBP.
  - `cancellation_risk_score` FLOAT - Databricks ML Cancellation Propensity score (0.00 to 1.00) targeting the 5.92% (£59M GBV) cancellation pool.
  - `direct_debit_status` STRING - Azure SQL Direct Debit status (Active, Paid_Full, Retry_Pending, Default_Risk). Covers 28% of bookings. | values: Active, Default_Risk, Paid_Full, Retry_Pending
  - `zero_deposit_segment` STRING - 5-year Causal Inference study classification (Net_Incremental, Standard, High_Default_Risk). | values: High_Default_Risk, Net_Incremental, Standard

### `isell_bookings_inquiries` - One row per Traveltek iSell / iBOS booking or open customer inquiry across Retail Branches, Contact Centre (PTC LS / Cruise CC), Vista Packaging Desk, and Finance iBOS settlement.
Rows: 65. Coverage: `booking_created_date` 2026-06-10 -> 2026-09-28; `departure_date` 2026-10-11 -> 2027-11-12
  - `booking_ref` STRING - Primary Key. Traveltek iSell / iBOS booking or inquiry reference (e.g. HT-884120).
  - `scv_household_id` STRING - Foreign Key to gold_customer_scv.scv_household_id.
  - `canonical_product_id` STRING - Foreign Key to supplier_product_mdm.canonical_product_id.
  - `raw_entered_hotel_text` STRING - Raw free-text hotel/resort string typed manually into iSell by the consultant from supplier extranet.
  - `owning_department` STRING - Department currently owning the record: Branch_Sales, Vista_Desk, Contact_Centre, or Finance_iBOS. | values: Branch_Sales, Contact_Centre, Finance_iBOS, Vista_Desk
  - `booking_status` STRING - Operational state: Quote_Open, Confirmed_DD, At_Risk_Cancellation, Deferred_Audit_Flag, Vista_Ticketing. | values: At_Risk_Cancellation, Confirmed_DD, Deferred_Audit_Flag, Quote_Open, Vista_Ticketing
  - `booking_created_date` DATE - Date the inquiry or booking was logged in Traveltek iSell (YYYY-MM-DD).
  - `departure_date` DATE - Scheduled passenger departure date (YYYY-MM-DD).
  - `deferral_months_shifted` INTEGER - Number of months departure date was pushed out (12 indicates Audit Genie flag for artificial bonus protection).
  - `total_package_gbp` FLOAT - Total booking transaction value (TTV) in GBP.
  - `expected_margin_gbp` FLOAT - Expected gross margin or commission in GBP recorded in iSell.
  - `fx_sunny_spend_attached` BOOLEAN - Whether Hays Travel's in-house TPF Sunny Spend FX card is attached to the booking.

### `supplier_product_mdm` - One row per canonical resort, cruise voyage (Traveltek Cruise JSON API), or Vista dynamic package, mapping the 292,000 duplicate iSell free-text hotel strings to a verified Google Places ID and Board margin target.
Rows: 50. Coverage: no date column
  - `canonical_product_id` STRING - Primary Key. Master product, resort, or cruise voyage identifier (e.g. PRD-B629C).
  - `google_place_id` STRING - Canonical Google Places API place_id used to deduplicate the 292,000 raw hotel strings in Databricks Silver.
  - `raw_isell_string_variants` INTEGER - Number of unmapped free-text hotel string variations in Traveltek iSell resolved to this canonical entity.
  - `canonical_name` STRING - Verified canonical resort or cruise ship + voyage name.
  - `supplier_channel` STRING - Supplier channel: Vista_InHouse (15-25% margin), PO_Cruises, Jet2holidays, easyJet, or TUI. | values: Jet2holidays, PO_Cruises, TUI, Vista_InHouse, easyJet
  - `product_category` STRING - Package category: Cruise_And_Stay, Ocean_Cruise, Short_Haul_Beach, or Long_Haul_MultiCentre. | values: Cruise_And_Stay, Long_Haul_MultiCentre, Ocean_Cruise, Short_Haul_Beach
  - `gross_margin_pct` FLOAT - Gross margin or agency commission percentage (e.g. 21.8% for Vista vs 10.5% for 3rd-party suppliers).
  - `min_margin_threshold_pct` INTEGER - Board '1/3 Mix' Mandate minimum target margin percentage for this product category.
  - `verified_attributes` STRING - Pipe-delimited verified property/cabin attributes from Oak Intranet & Traveltek Cruise JSON API (e.g. Scooter_90cm_Door, Soft_Sand_Beach).
