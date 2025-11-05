# Follow-up Questions for Database Schema Refinement

Based on your answers, I need clarification on several points to ensure the schema and features are correctly designed.

---

## Critical Clarifications Needed

### 1. Outbound Order Structure (Answer 1.2, 4.2)

**Question 1.1:** You mentioned needing an outbound orders table similar to `transfer_order_details` but not internal. Can you clarify the complete outbound workflow?

- Who creates outbound orders? (Sales team, customers via portal, integrated e-commerce system?)
- What triggers an outbound order? (Customer order, internal requisition, sales order?)
- Should outbound orders link to customer records, or are they anonymous?
- Do you need to track: shipping address, delivery instructions, priority levels?

**Follow-up 1.2:** When you say the application "should only handle until an outbound document is verified" - does this mean:

- No tracking of actual shipment/delivery status?
- No carrier/tracking number storage?
- The outbound document verification is the final state in your system?

---

### 2. Work Sessions & Document Verification (Answers 4.1, 5.3, 5.4)

**Question 2.1:** You mentioned a unified "work_session" table for various document types (inbound check, outbound, cycle count, etc.). Can you describe:

- What specific session types do you need? (Receiving sessions, picking sessions, packing sessions, cycle count sessions, return processing sessions?)
- What common fields should all sessions have? (session_id, user_id, start_time, end_time, status, branch_id?)
- What session-specific data needs to be tracked? (items scanned, discrepancies found, time metrics?)

**Question 2.2:** For the document verification workflow:

- Who can verify documents? (Only managers, or role-based?)
- Can documents be rejected and require rework?
- Do you need multi-level approval (worker completes → supervisor reviews → manager verifies)?
- What happens to rejected/failed verifications?

**Question 2.3:** You mentioned session documents should result in "WARN: discrepancies found" - should the system:

- Automatically calculate discrepancies in real-time during scanning?
- Flag sessions with any discrepancy for review?
- Block verification if discrepancies exceed a threshold?
- Allow forced verification with manager override?

---

### 3. Status Types & Lookup Table Design (Answer 2.2)

**Question 3.1:** For your multilingual lookup approach (PO_DRAFT | en | vi), do you want:

**Option A - Separate Translation Table:**

```
system_lookups:
  id, lookup_type, lookup_code, sort_order

lookup_translations:
  lookup_id, language_code, translated_value, description
```

**Option B - JSONB for Translations:**

```
system_lookups:
  id, lookup_type, lookup_code, translations (JSONB: {en: "Draft", vi: "Bản nháp"}), sort_order
```

**Option C - Current approach with compound key:**

```
system_lookups:
  lookup_type, lookup_code, language_code (composite key), lookup_value
```

Which approach do you prefer? Option A is most normalized and flexible. Option B is faster for queries but harder to manage translations. Option C is simplest but may have query complexity.

**Question 3.2:** Should UI element translations be in the same table or separate? (e.g., button labels, menu items, field labels)

---

### 4. Inventory Adjustment Workflow (Answer 5.4)

**Question 4.1:** For inventory adjustment requests spawned from cycle count discrepancies:

- Should adjustments require approval before being applied to inventory?
- Who can approve adjustments? (Manager only, or configurable by adjustment amount?)
- Can adjustments be batched (multiple SKUs in one adjustment request)?
- What are the "template reasons" you mentioned? (Cycle count variance, damage, theft, data entry error, expiry, other?)

**Question 4.2:** Should the adjustment request track:

- Expected quantity vs. actual quantity?
- Value impact (cost of variance)?
- Photos/evidence of damage or issues?
- Resolution notes from approver?

---

### 5. Batch vs. Serial Tracking Implementation (Answer 7.4)

**Question 5.1:** You mentioned both serialized and batch tracking are crucial. How should these coexist?

- Can a single SKU support both serial and batch tracking, or is it one or the other?
- For serialized items: Should each serial number be a unique record with its own location, status, and history?
- For batched items: Current design uses `inventory_batches` - is this adequate?
- Should there be a `product_variants.tracking_method` field? (NONE, BATCH, SERIAL)

**Question 5.2:** For serial number tracking, what data is needed per serial number?

- Serial number (unique identifier)
- SKU reference
- Current location/zone
- Status (in-stock, sold, returned, defective, etc.)
- Warranty expiration date
- Purchase order received from
- Sales order sold to (if applicable)
- History of movements?

---

### 6. Document Attachments (Answer 2.3)

**Question 6.1:** For document image storage, should there be a generic attachments table that can link to various entities?

```
attachments:
  attachment_id, entity_type (purchase_order, work_session, adjustment_request, etc.),
  entity_id, file_url, file_type, file_size, uploaded_by, uploaded_at, notes
```

Or separate attachment tables per entity type?

**Question 6.2:** What entity types need attachment support?

- Purchase orders (delivery notes, quality inspection photos)
- Work sessions (damage photos, discrepancy evidence)
- Adjustment requests (evidence photos)
- Return requests (condition photos)
- Products (product images, spec sheets)
- Others?

---

### 7. Notification Details (Answer 5.2, 10.2)

**Question 7.1:** For the notification system:

**Notification Types:**

- Should notifications have categories? (Alerts, Warnings, Info, System announcements)
- What triggers notifications? (Expiry warnings, low stock, pending approvals, session completion, errors)

**Notification Table Structure:**

```
notifications:
  notification_id, notification_type (global/personal),
  recipient_user_id (null for global), title, message,
  created_at, read_at, dismissed_at, priority, action_url?,
  related_entity_type?, related_entity_id?
```

Does this structure work?

**Question 7.2:** For expiry warnings configurable per category:

- Should the warning threshold (default 2 months) be stored in `category` table or a separate `category_settings` table?
- Do you need multiple warning levels? (e.g., warn at 60 days, alert at 30 days, critical at 7 days)

---

### 8. Permission System Implementation (Answer 8.2, 8.3)

**Question 8.1:** For bitwise permissions with hybrid scope (global/branch-specific):

Should the structure be:

```
roles:
  role_id, role_name, is_system_default

role_permissions:
  role_id, permission_category, permission_bits (bigint), scope (global/branch)

user_role_assignments:
  user_id, role_id, branch_id (nullable - null means org-wide)
```

**Question 8.2:** What permission categories do you need? For example:

- **Inventory Management:** (view_inventory, adjust_inventory, transfer_inventory, etc.)
- **Purchase Orders:** (create_po, approve_po, receive_goods, etc.)
- **Outbound Orders:** (create_outbound, pick_items, verify_shipment, etc.)
- **Work Sessions:** (start_session, complete_session, verify_session, etc.)
- **User Management:** (invite_users, assign_roles, manage_branches, etc.)
- **Reporting:** (view_reports, export_data, etc.)
- **System Admin:** (manage_settings, configure_warehouse, etc.)

Please list the key permission categories and critical permissions within each.

---

### 9. Product Customization & UOM Conversion (Answer 7.4)

**Question 9.1:** For "customizable product fields and tagging":

- Should custom fields be defined per organization/workspace?
- Should they be typed (text, number, date, dropdown) or free-form?
- Where should custom field definitions be stored?
- Where should custom field values be stored? (JSONB in products table or separate table?)

**Question 9.2:** For Unit of Measure (UOM) conversion:

- Do you need a UOM conversion table? (e.g., 1 case = 12 units, 1 pallet = 40 cases)
- Should conversion factors be stored per SKU or globally per UOM pair?
- Example: If you receive 10 cases but sell in units, should inventory track both levels?

---

### 10. Historical Data & Audit Logs (Answer 10.6)

**Question 10.1:** For comprehensive audit logs with old_value/new_value:

Should the structure be:

```
audit_logs:
  log_id, user_id, action_type (created, updated, deleted, verified, etc.),
  entity_type (product, purchase_order, inventory_batch, etc.),
  entity_id, field_name, old_value, new_value,
  ip_address, created_at, notes
```

**Question 10.2:** Which entities/fields specifically need audit trail?

- Product master data changes (name, price, specs)
- Inventory quantity changes (already in inventory_transactions)
- Purchase order status changes
- User permission changes
- Settings changes
- All of the above?

**Question 10.3:** Should audit logs be queryable by:

- Entity (show me all changes to product X)
- User (show me all changes by user Y)
- Time range (show me all changes last week)
- Field (show me all price changes)
- All of the above?

---

### 11. Demand Forecasting Data (Answer 7.4)

**Question 11.1:** You mentioned demand forecasting is important. To implement this, we need:

- Should the system store forecast data, or just compute on-demand?
- What historical period should be analyzed? (last 3 months, 6 months, 1 year?)
- Should forecasts be recalculated automatically (daily, weekly) or manually triggered?
- Do you need seasonal adjustments or just simple moving averages?

**Question 11.2:** For ROP calculations (Answer 1.1), should the system:

- Auto-calculate ROP based on sales history?
- Allow manual ROP override per SKU?
- Store both calculated and override values?
- Alert when current stock reaches ROP?

---

### 12. Return Management Details (Answer 6.1, 6.2)

**Question 12.1:** For supplier return workflow:

What table structure do you envision?

```
return_requests:
  return_request_id, batch_id, quantity_to_return,
  reason_type_id, custom_reason, condition_type_id,
  expected_credit, requested_by_user_id, requested_at,
  verified_by_user_id, verified_at, status_type_id
```

**Question 12.2:** Should returns be able to include multiple batches/SKUs in one request, or one request per batch?

**Question 12.3:** For "condition" - what condition types do you need? (Defective, Expired, Damaged, Wrong Item, Excess Stock, Other?)

---

### 13. Archive Strategy (Answer 11.3)

**Question 13.1:** For archiving data older than X months:

- What should X be? (12 months, 24 months?)
- Should it be configurable per organization?
- Which tables need archiving? (inventory_transactions, audit_logs, completed work_sessions, old batches?)
- Should archived data be in separate archive tables in same DB or moved to different DB?
- Do users need to query archived data, or is it just for compliance/backup?

---

### 14. Zone Map Editing (Answer 3.5)

**Question 14.1:** You mentioned storage zone maps should be editable. What level of editability?

- Add/remove/move zones?
- Resize zones?
- Change zone attributes (temperature, type)?
- Reorganize shelf positions?
- Version history of map changes?

**Question 14.2:** When a zone is edited/removed, what happens to inventory currently in that zone?

- Block deletion if inventory exists?
- Force move inventory to another zone?
- Allow with warning?

---

### 15. Performance Metrics & Picking Sessions (Answer 4.4, 7.2)

**Question 15.1:** For tracking picking sessions:

Should the structure be:

```
work_sessions:
  session_id, session_type_id, user_id, branch_id,
  started_at, completed_at, status_type_id

session_line_items:
  line_item_id, session_id, sku_id,
  expected_quantity, actual_quantity,
  zone_id, scanned_at, notes

session_metrics:
  session_id, total_items_picked, total_time_seconds,
  items_per_hour, accuracy_rate, distance_traveled_meters?
```

**Question 15.2:** What metrics should be calculated and stored vs. calculated on-demand?

- Store: Total time, items picked, accuracy
- Calculate on-demand: Items per hour, average pick time
- Both?

---

## Recommendations Needed From You

### R1. Polymorphic Relationships (Answer 9.1)

You asked for recommendations. Here are three approaches:

**Approach A: Nullable Foreign Keys (Current Schema)**

```sql
inventory_transactions:
  purchase_order_detail_id (nullable)
  transfer_order_detail_id (nullable)
  work_session_id (nullable)
  adjustment_request_id (nullable)
  CHECK (exactly one FK is not null)
```

✅ Pros: Simple, maintains referential integrity
❌ Cons: Need to add nullable FK for each new source type

**Approach B: Generic Reference (Anti-pattern but flexible)**

```sql
inventory_transactions:
  source_entity_type (enum: 'purchase_order', 'transfer_order', etc.)
  source_entity_id (int)
```

✅ Pros: Extremely flexible, easy to add new types
❌ Cons: No referential integrity, error-prone

**Approach C: Separate Transaction Tables**

```sql
receiving_transactions (links to purchase_orders)
transfer_transactions (links to transfer_orders)
adjustment_transactions (links to adjustment_requests)
```

✅ Pros: Clean separation, strong typing
❌ Cons: More complex queries for full transaction history

**My Recommendation:** Stick with Approach A (current schema with nullable FKs). For a university project with manageable complexity, this provides the best balance of flexibility and data integrity. You can add new source types as needed without major refactoring.

Do you agree, or prefer a different approach?

---

### R2. Soft Delete Strategy (Answer 9.4)

**My Recommendations:**

**Always Soft Delete (add is_deleted + deleted_at):**

- `products`, `product_variants` (SKUs) - need historical reference in orders
- `suppliers` - need historical reference in purchase orders
- `purchase_orders`, `outbound_orders` - audit trail requirements
- `inventory_batches` - historical tracking
- `users` - maintain data integrity for created_by/modified_by fields
- `branches`, `storage_zones` - structural data that affects history

**Can Hard Delete:**

- `work_sessions` (after archival period)
- `notifications` (after read/dismissed)
- `attachments` (if entity is deleted)
- `audit_logs` (after retention period, or archive instead)

**Never Delete (Archive Only):**

- `inventory_transactions` - financial/audit trail
- `audit_logs` - compliance

Does this align with your needs?

---

## Next Steps

Please review and answer these follow-up questions. Once I have your responses, I will:

1. ✅ Update `features.md` with comprehensive, detailed requirements
2. ✅ Create a revised `eraserio.txt` schema with all necessary tables and relationships
3. ✅ Provide a migration guide showing what changed and why
4. ✅ Create a data dictionary documenting all tables, fields, and relationships
5. ✅ Suggest appropriate indexes for performance

Please answer the questions by section number (e.g., "1.1: ...", "1.2: ...", etc.) for easy reference.
