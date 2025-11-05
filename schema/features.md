# Warehouse Management System - Software Requirements Specification

## 1. System Overview

### 1.1 Purpose

A comprehensive warehouse management system (WMS) designed for small to medium-sized operations, supporting multi-branch organizations with intelligent inventory tracking, work session management, and advanced reporting capabilities.

### 1.2 Scale & Performance

- Target: 100s of concurrent operations
- Multi-organization support with tenant isolation
- Real-time inventory updates upon document verification
- Responsive web interface with mobile barcode scanning support

### 1.3 Core Capabilities

- Serial and batch-level inventory tracking
- Intelligent reorder point calculations
- 2D warehouse layout visualization with route optimization
- Work session-based operational workflows
- Comprehensive audit logging
- Flexible permission system with bitwise implementation
- Multi-level expiry warnings
- Demand forecasting and analytics

---

## 2. Master Data Management

### 2.1 Product Management

#### 2.1.1 Product Hierarchy

- **Products**: Master product records with category and brand association
- **Product Variants (SKUs)**: Individual sellable units with unique identification
- **Categories**: Hierarchical categorization using ltree for efficient queries (e.g., Electronics > Computers > Laptops)
- **Brands**: Brand master data

#### 2.1.2 Product Attributes

**Required Fields:**

- Product name, description
- Category and brand assignment
- Storage requirements (dry, refrigerated, frozen, hazmat, etc.)
- Tracking method: SERIAL, BATCH, or NONE
- Shelf life (in days) for perishable items
- Reorder point (ROP) - auto-calculated or manual override
- Active status flag

**SKU-Specific Fields:**

- Unique SKU code and multiple barcode support
- Cost price and selling price (with audit trail for changes)
- Unit of measure (UOM)
- Physical dimensions: weight (kg), volume (m³)
- Packing constraints: temperature sensitivity, stacking limits

#### 2.1.3 Custom Product Fields

- Organizations can define custom product attributes via product type templates
- Custom fields are typed (text, number, date, dropdown)
- Field definitions stored per organization
- Field values stored in JSONB for flexibility
- Examples: color, size, warranty period, SKU-specific specs

#### 2.1.4 Barcode Management

- Multiple barcodes per SKU support (manufacturer, internal, case, pallet)
- Separate `product_barcodes` table with barcode type and value
- QR code support for mobile scanning workflows

#### 2.1.5 Serial Number Tracking

For items with tracking_method = SERIAL:

- Each serial number is a unique trackable entity
- Tracks: serial number, SKU reference, current zone location
- Status tracking: IN_STOCK, SOLD, RETURNED, DEFECTIVE, etc.
- Warranty expiration dates
- Links to source purchase order
- Complete movement history via inventory transactions

**Note:** Batch tracking is used to group items from the same supplier shipment for easy batch-level returns, while individual quantities are still tracked per batch.

### 2.2 Supplier Management

#### 2.2.1 Supplier Master Data

- Supplier name, contact person, email, phone
- Active status flag
- Soft delete support for historical integrity

#### 2.2.2 Supplier Performance Tracking

Track detailed metrics in operational database:

- **Delivery Performance**: On-time delivery rate, average lead time
- **Quality Metrics**: Rejection rate, return frequency, quality ratings
- **Price History**: Historical pricing with timestamps for trend analysis
- **Order Statistics**: Total orders, average order value, order frequency

---

## 3. Organization & Workspace Management

### 3.1 Multi-Tenant Architecture

#### 3.1.1 Organizations (Workspaces)

- Workspace represents a single business entity/tenant
- Contains: name, address, contact info, active status
- Shared schema approach with organization_id filtering
- Organization-level settings stored in JSONB key-value pairs

#### 3.1.2 Branches

- Multiple branches per organization
- Each branch can have multiple warehouses/storage zones
- Branch-specific settings support
- Soft delete for historical data integrity

#### 3.1.3 Workspace Invitation System

**Invitation Flow:**

1. Admin generates invitation code (12 characters, format: XXXX-XXXX-XXXX)
2. Code stored in `workspace_invitations` table
3. Admin configurable: validity duration, regenerate code, delete invitation
4. Employee scans QR code (generated client-side from text code) or enters manually
5. Invitation creates pending user request
6. Admin approves and assigns role/permissions
7. User gains access to workspace

**Technical Details:**

- Invitation codes stored with expiry timestamp
- Track invitation status: PENDING, APPROVED, REJECTED, EXPIRED
- One active invitation per workspace at a time (or multiple with different codes)

---

## 4. User Management & Permissions

### 4.1 User Accounts

#### 4.1.1 User Profile

- Username, password hash, full name, email
- Organization association
- Active status flag
- User preferences stored in JSONB
- Soft delete to maintain audit trail integrity

#### 4.1.2 Multi-Branch Assignment

- Users can be assigned to multiple branches
- Track assignment status (ACTIVE, INACTIVE)
- Assignment timestamp tracking

### 4.2 Role-Based Access Control (RBAC)

#### 4.2.1 Role Structure

- **Predefined Roles**: System provides default role templates
  - Warehouse Manager
  - Stock Clerk
  - Receiving Specialist
  - Shipping Specialist
  - Inventory Auditor
  - Accountant
  - Report Viewer
- **Custom Roles**: Admins can create custom roles with any name
- `is_system_default` flag distinguishes predefined vs. custom roles

#### 4.2.2 Bitwise Permission System

Permissions organized by categories with bitwise flags for performance:

**Permission Categories:**

1. **Inventory Management** (permission_bits as bigint)

   - VIEW_INVENTORY (1 << 0)
   - ADJUST_INVENTORY (1 << 1)
   - TRANSFER_INVENTORY (1 << 2)
   - VIEW_BATCH_DETAILS (1 << 3)
   - VIEW_SERIAL_NUMBERS (1 << 4)

2. **Purchase Orders**

   - CREATE_PO (1 << 0)
   - EDIT_PO (1 << 1)
   - APPROVE_PO (1 << 2)
   - DELETE_PO (1 << 3)
   - RECEIVE_GOODS (1 << 4)
   - VIEW_PO (1 << 5)

3. **Outbound Orders**

   - CREATE_OUTBOUND (1 << 0)
   - EDIT_OUTBOUND (1 << 1)
   - DELETE_OUTBOUND (1 << 2)
   - PICK_ITEMS (1 << 3)
   - PACK_ITEMS (1 << 4)
   - VERIFY_SHIPMENT (1 << 5)

4. **Work Sessions**

   - START_SESSION (1 << 0)
   - COMPLETE_SESSION (1 << 1)
   - VERIFY_SESSION (1 << 2)
   - VIEW_SESSION_HISTORY (1 << 3)
   - DELETE_SESSION (1 << 4)

5. **Inventory Adjustments**

   - CREATE_ADJUSTMENT (1 << 0)
   - APPROVE_ADJUSTMENT (1 << 1)
   - APPROVE_ALL_ADJUSTMENTS (1 << 2)
   - VIEW_ADJUSTMENTS (1 << 3)

6. **User Management**

   - INVITE_USERS (1 << 0)
   - APPROVE_USERS (1 << 1)
   - ASSIGN_ROLES (1 << 2)
   - MANAGE_BRANCHES (1 << 3)
   - VIEW_USERS (1 << 4)

7. **Reporting**

   - VIEW_REPORTS (1 << 0)
   - EXPORT_DATA (1 << 1)
   - CREATE_CUSTOM_REPORTS (1 << 2)
   - SCHEDULE_REPORTS (1 << 3)

8. **System Administration**
   - MANAGE_SETTINGS (1 << 0)
   - CONFIGURE_WAREHOUSE (1 << 1)
   - MANAGE_CATEGORIES (1 << 2)
   - MANAGE_SUPPLIERS (1 << 3)
   - VIEW_AUDIT_LOGS (1 << 4)

#### 4.2.3 Permission Scope (Hybrid Model)

- **Global Permissions**: Apply organization-wide (e.g., VIEW_REPORTS)
- **Branch-Specific Permissions**: Scoped to specific branches (e.g., MANAGE_INVENTORY in Branch A only)

**Implementation:**

```txt
role_permissions:
  role_id, permission_category, permission_bits, scope (GLOBAL/BRANCH)

user_role_assignments:
  user_id, role_id, branch_id (nullable - null = org-wide)
```

**Permission Check Logic:**

- Check if user has role assignment for current branch OR org-wide assignment
- Verify permission bit is set for the action
- Branch-scoped permissions require matching branch_id
- Global permissions apply regardless of branch context

---

## 5. Warehouse Layout & Storage Management

### 5.1 2D Warehouse Layout System

#### 5.1.1 Warehouse Floor Plan

- Overall dimensions (length × width in meters)
- Entry and exit points (coordinates)
- Pathway/aisle definitions for route calculation

#### 5.1.2 Storage Zone Hierarchy

Uses PostgreSQL ltree for efficient hierarchical queries with customizable hierarchy per storage block:

**Flexible Structure:**

- Warehouse > Zone > [Custom Storage Block Hierarchy]

**Examples of Custom Hierarchies:**

- Freezer units: `Warehouse > Zone > Freezer > Shelf > Rack`
- Dry storage: `Warehouse > Zone > Aisle > Rack > Tier`
- Ground storage: `Warehouse > Zone > Ground_Section > Quad`
- Pallet storage: `Warehouse > Zone > Bay > Level > Position`

**Storage Zones Table:**

- `zone_id`: Primary key
- `branch_id`: Branch association
- `name`: Zone identifier
- `path`: ltree path (e.g., 'WAREHOUSE_A.ZONE_A.FREEZER_01.SHELF_02' or 'WAREHOUSE_A.ZONE_B.GROUND_SECT_01.QUAD_A3')
- `zone_type_id`: Lookup reference (RECEIVING, STORAGE, PACKING, SHIPPING, QUARANTINE, RETURNS)
- `storage_block_type`: Indicates hierarchy template (FREEZER_UNIT, DRY_RACK, GROUND_ZONE, PALLET_BAY, CUSTOM)

**Implementation Notes:**

- Each zone can define its own hierarchical structure based on physical storage requirements
- The ltree path adapts to the specific storage block type
- UI allows administrators to select hierarchy template when creating zones
- Custom hierarchy levels can be defined per organization for specialized storage needs

#### 5.1.3 Zone Attributes

Stored as JSONB for flexibility:

- **Physical Attributes:**

  - Position coordinates (x, y for 2D layout)
  - Dimensions (length, width, height)
  - Capacity (volume or weight limit)

- **Environmental Controls:**

  - Temperature range (min/max °C)
  - Humidity control requirements
  - Refrigeration type (DRY, CHILLED, FROZEN)

- **Storage Constraints:**

  - Maximum weight capacity
  - Weight distribution requirements
  - Restricted access flag
  - Hazmat certification level

#### 5.1.4 Special Zones

- **Receiving Zone**: Temporary holding for incoming shipments
- **Packing Zone**: Order preparation and packing area
- **Quarantine Zone**: Hold defective or pending inspection items
- **Returns Zone**: Items pending return to supplier

#### 5.1.5 Layout Editing Capabilities

Authorized users can:

- Add/remove/move zones (blocked if inventory exists)
- Resize zones dynamically
- Change storage rack attributes (drag, rotate in UI)
- Reorganize shelf positions
- Update zone environmental settings
- Version history tracking NOT required (future enhancement)

**Business Rule:** Zone deletion blocked if inventory exists in that zone.

### 5.2 Optimal Storage Location Suggestion

#### 5.2.1 Algorithm Inputs

- **Pick Frequency**: Historical pick count per SKU over last 3 months
- **Product Dimensions**: Volume and weight from SKU master data
- **Zone Temperature Requirements**: Match product storage requirements with zone capabilities
- **Proximity to Packing Area**: Distance calculation from zone to packing zone

#### 5.2.2 Suggestion Logic

1. Filter zones compatible with product storage requirements
2. Calculate available capacity in each compatible zone
3. Rank zones by:

   - High-velocity items → closer to packing area
   - Low-velocity items → farther locations
   - Product size match to zone capacity

4. Return top 3 suggested locations

---

## 6. Purchase Order Management

### 6.1 Purchase Order Workflow

#### 6.1.1 Purchase Order Creation

- **Created by**: Users with CREATE_PO permission
- **Required Data**:

  - Unique PO code (auto-generated or manual)
  - Supplier selection
  - Order date, expected delivery date
  - Line items: SKU, quantity ordered, unit cost
  - Attachments support (optional): delivery specifications, contracts

#### 6.1.2 Purchase Order Status Flow

Status stored in system_lookups with codes:

- **PO_DRAFT**: Initial creation, editable
- **PO_SUBMITTED**: Sent to supplier, awaiting confirmation
- **PO_CONFIRMED**: Supplier confirmed order
- **PO_PARTIALLY_RECEIVED**: Some items received
- **PO_FULLY_RECEIVED**: All items received
- **PO_CLOSED**: Completed and archived
- **PO_CANCELLED**: Order cancelled

#### 6.1.3 Smart Order Suggestion System

**Reorder Point (ROP) Calculation:**

```txt
ROP = (Average Daily Sales × Lead Time in Days) + Safety Stock

Where:
- Average Daily Sales: Calculated from outbound order history (configurable period: last 3 months default)
- Lead Time: Stored per supplier (average from historical POs)
- Safety Stock: Configurable per SKU or category
```

**Auto-Calculation:**

- System calculates ROP weekly (configurable)
- Compares current available inventory vs ROP
- Generates low-stock alerts when inventory ≤ ROP
- Suggests order quantity based on economic order quantity (EOQ) or min order quantity

**Manual Override:**

- Users can manually set ROP per SKU
- Override value takes precedence over auto-calculation
- Track both calculated and override values for reporting

---

## 7. Inbound Operations (Receiving)

### 7.1 Receiving Workflow

#### 7.1.1 Receiving Session

**Session Type:** RECEIVING_SESSION

**Workflow:**

1. **Session Creation**: User with RECEIVE_GOODS permission creates receiving session

   - Links to purchase order
   - Assigns user_id, branch_id
   - Status: SESSION_STARTED

2. **Barcode Scanning**:

   - Mobile web interface with camera for barcode/QR scanning
   - Scan product barcode → auto-populate SKU details
   - Enter/confirm quantity received
   - Record batch details:

     - Supplier batch number
     - Internal batch number (auto-generated)
     - Expiry date (for perishable items)
     - Manufacturing date (optional)

   - Scan serial numbers for serialized items

3. **Storage Location Assignment**:

   - System suggests optimal storage location (see §5.2)
   - User confirms or selects alternative location
   - For serialized items: each serial number assigned to zone

4. **Discrepancy Handling**:

   - System compares scanned quantity vs. PO expected quantity
   - Flags discrepancies (over/under shipment)
   - User adds notes explaining variance
   - Session shows warning indicator

5. **Session Completion**:

   - User marks session as complete
   - Status: SESSION_COMPLETED (pending verification)

6. **Verification**:

   - User with VERIFY_SESSION permission reviews session
   - Can APPROVE or REJECT with reason
   - If REJECTED: Session status = SESSION_REJECTED, user must create new session
   - If APPROVED:

     - Status = SESSION_VERIFIED
     - Inventory transactions created (batch quantities added)
     - Purchase order status updated (PARTIALLY_RECEIVED or FULLY_RECEIVED)

#### 7.1.2 Attachments

Receiving sessions support attachments:

- Delivery notes (scanned/photos)
- Damage reports with photos
- Quality inspection reports
- Multiple images per session
- Notes field for each attachment

---

## 8. Outbound Operations

### 8.1 Outbound Order Management

#### 8.1.1 Outbound Order Structure

**Purpose**: Track orders leaving the warehouse (sales orders, transfers to external parties, etc.)

**Key Fields:**

- Unique order code
- Order date, requested ship date
- Basic delivery status tracking (PREPARING, READY_TO_SHIP, SHIPPED)
- Tracking number (optional)
- Created by user with CREATE_OUTBOUND permission
- Line items: SKU, quantity requested, quantity picked, quantity packed

**Note:** System tracks only until outbound document is verified. Post-shipment delivery tracking is out of scope.

#### 8.1.2 Status Flow

- **OUTBOUND_DRAFT**: Initial creation
- **OUTBOUND_PICKING**: Picking session in progress
- **OUTBOUND_PICKED**: All items picked, ready for packing
- **OUTBOUND_PACKING**: Packing session in progress
- **OUTBOUND_PACKED**: Packed, ready for shipment
- **OUTBOUND_VERIFIED**: Final verification complete (terminal state)
- **OUTBOUND_CANCELLED**: Order cancelled

### 8.2 Picking Operations

#### 8.2.1 Picking Session Workflow

**Session Type:** PICKING_SESSION

**Workflow:**

1. **Session Creation**:

   - Links to outbound order
   - System generates picking list with line items
   - Each line item includes: SKU, quantity needed, suggested zone location

2. **Route Optimization**:

   - If warehouse has 2D layout configured:

     - Calculate shortest path through required zones
     - Order picking list by optimal route sequence
     - Display route on 2D map

   - If no layout: sort by zone/aisle alphabetically

3. **Picking Execution**:

   - User follows picking list
   - For each line item:

     - Navigate to zone
     - Scan barcode to confirm correct SKU
     - Enter/confirm quantity picked
     - For serialized items: scan individual serial numbers
     - System validates serial numbers exist in inventory

   - Track timestamp per line item scanned

4. **Batch Selection Logic** (for batched items):

   - FIFO (First In, First Out): Pick oldest batches first
   - FEFO (First Expired, First Out): Pick batches closest to expiry first
   - System suggests batches based on configurable strategy

5. **Session Completion & Verification**:

   - User completes session
   - Verifier reviews for discrepancies
   - Upon verification:

     - Inventory transactions created (quantities deducted)
     - Outbound order status updated
     - Serial numbers marked as PICKED

#### 8.2.2 Performance Tracking

**Stored Metrics (per session):**

- Total time (started_at to completed_at)
- Total items picked
- Accuracy rate (actual vs expected quantity)

**Calculated On-Demand:**

- Items per hour
- Average pick time per line item

### 8.3 Packing Operations

#### 8.3.1 Packing Session Workflow

**Session Type:** PACKING_SESSION

**Workflow:**

1. Links to outbound order (status = OUTBOUND_PICKED)
2. User scans picked items to confirm
3. Smart packing suggestions based on:

   - Temperature sensitivity (group refrigerated items)
   - Stacking limits (heavy items on bottom)
   - Product fragility
   - Box size recommendations

4. User confirms packing completion
5. Verification step marks order as OUTBOUND_PACKED

---

## 9. Internal Transfer Management

### 9.1 Transfer Order Workflow

#### 9.1.1 Transfer Order Structure

- Unique transfer code
- Source branch and destination branch
- Created by user_id
- Expected delivery date, actual delivery date
- Status: TRANSFER_DRAFT, TRANSFER_SHIPPED, TRANSFER_IN_TRANSIT, TRANSFER_RECEIVED, TRANSFER_VERIFIED

#### 9.1.2 Transfer Process

1. **Creation**: User at source branch creates transfer order
2. **Picking**: Similar to outbound picking session
3. **Shipment**: Mark as shipped with tracking number
4. **Receipt**: Destination branch performs receiving session (similar to PO receiving)
5. **Verification**: Verify received quantities match shipped quantities
6. **Inventory Update**: Deduct from source, add to destination upon verification

---

## 10. Inventory Tracking & Management

### 10.1 Real-Time Inventory

#### 10.1.1 Inventory Granularity

**Batch-Level Tracking:**

- Each batch represents items from same supplier shipment
- Tracks: SKU, zone location, quantity, supplier batch #, internal batch #, received date, expiry date
- Batch status: AVAILABLE, QUARANTINE, EXPIRED, RETURNED, DAMAGED

**Serial-Level Tracking:**

- Individual serial numbers for high-value items
- Each serial is a unique inventory entity
- Tracks: serial number, SKU, zone, status, warranty expiry, source PO

#### 10.1.2 Real-Time Updates

- "Real-time" means UI updates when work session is verified (terminal state)
- Inventory transactions created only upon verification
- Live audit log shows pending (unverified) sessions for visibility

#### 10.1.3 Inventory Transactions

**Purpose**: Immutable audit trail of all inventory movements

**Transaction Structure:**

- `batch_id` or `serial_number_id`: What moved
- `quantity_before`, `quantity_change`, `quantity_after`: State tracking
- `transaction_type_id`: RECEIVE, PICK, TRANSFER_OUT, TRANSFER_IN, ADJUSTMENT, RETURN
- `created_at`, `user_id`: Who and when
- `source_entity_type`, `source_entity_id`: Link to source document (PO, outbound order, adjustment, etc.)

**Polymorphic Relationship Handling:**
Uses nullable foreign keys with CHECK constraint:

- `purchase_order_detail_id` (nullable)
- `transfer_order_detail_id` (nullable)
- `work_session_id` (nullable)
- `adjustment_request_id` (nullable)
- CHECK constraint ensures exactly one is populated

### 10.2 Cycle Counting & Physical Inventory

#### 10.2.1 Cycle Count Session

**Session Type:** CYCLE_COUNT_SESSION

**Workflow:**

1. **Session Creation**:

   - User with appropriate permission creates cycle count session
   - Assigns zone(s) to count
   - Generates expected inventory list for assigned zones

2. **Counting**:

   - Mobile scanning interface
   - For each SKU in zone:

     - Scan barcode
     - Enter physical count
     - For batches: confirm batch number, count quantity
     - For serialized items: scan each serial number

   - System tracks timestamp per item counted

3. **Discrepancy Detection**:

   - After submission, system compares:

     - Expected quantity (from inventory_batches)
     - Actual quantity (counted)

   - Flags any variances
   - Session shows WARN status if discrepancies exist

4. **Completion & Review**:

   - User marks session complete
   - Verifier reviews discrepancies
   - Can APPROVE or REJECT session

5. **Adjustment Request Creation**:

   - If discrepancies found and session approved:
   - System prompts: "Discrepancies detected. Create adjustment request?"
   - User clicks to create adjustment request
   - Pre-populated with expected vs actual quantities
   - User selects reason (template or custom)

### 10.3 Inventory Adjustments

#### 10.3.1 Adjustment Request Workflow

**Triggers:**

- Cycle count discrepancies
- Damage/breakage
- Theft/loss
- Data entry corrections
- Expired goods write-off

**Adjustment Request Structure:**

- Can include multiple SKUs/batches in one request
- For each line item:

  - SKU/batch reference
  - Expected quantity
  - Actual quantity (or new quantity)
  - Quantity variance
  - Cost impact (calculated)

**Required Fields:**

- Reason type: CYCLE_COUNT_VARIANCE, DAMAGE, THEFT, DATA_ENTRY_ERROR, EXPIRY, OTHER
- Custom reason notes (required for OTHER, optional otherwise)
- Attachments support (photos of damage, evidence)
- Resolution notes from approver

**Status Flow:**

- **ADJ_DRAFT**: Initial creation
- **ADJ_PENDING_APPROVAL**: Submitted for approval
- **ADJ_APPROVED**: Approved, inventory updated
- **ADJ_REJECTED**: Rejected with reason, no inventory change

#### 10.3.2 Approval Workflow

- Configurable approval authority based on role permissions
- Examples:

  - Inventory Administrator: Can approve all adjustments
  - Warehouse Manager: Can approve adjustments in their branch
  - Stock Clerk: Can create but not approve

- Upon approval:

  - Inventory transactions created for each line item
  - Batch quantities updated
  - Serial number statuses updated if applicable
  - Adjustment request status = ADJ_APPROVED

### 10.4 Expiry Management

#### 10.4.1 Expiry Warning Levels

Configurable per product category, stored in `category_settings`:

**Default Thresholds:**

- **Warning Level 1**: 60 days before expiry (LOW priority)
- **Warning Level 2**: 30 days before expiry (MEDIUM priority)
- **Warning Level 3**: 7 days before expiry (HIGH priority)
- **Expired**: Past expiry date (CRITICAL priority)

#### 10.4.2 Notification System

**Notification Categories:**

- EXPIRY_WARNING: Products approaching expiry
- LOW_STOCK: Inventory below ROP
- PENDING_APPROVAL: Sessions/adjustments awaiting approval
- SESSION_COMPLETE: Session completed and needs verification
- SYSTEM_ERROR: System errors or anomalies

**Notification Structure:**

- `notification_id`, `notification_category`
- `notification_type`: GLOBAL (all workspace users) or PERSONAL (specific recipient)
- `recipient_user_id`: Null for global, user_id for personal
- `title`, `message`: Notification content
- `priority`: LOW, MEDIUM, HIGH, CRITICAL
- `action_url`: Deep link to relevant entity (optional)
- `related_entity_type`, `related_entity_id`: Link to source
- `created_at`, `read_at`, `dismissed_at`: Tracking states

**Delivery:**

- In-app delivery only (email/SMS out of scope for now)
- Users see notification bell icon with unread count
- Notifications auto-created by scheduled jobs checking expiry dates

#### 10.4.3 Expiry Alert Job

- Runs daily (configurable schedule)
- Queries batches with `expires_at` within threshold windows
- Creates notifications for:

  - Warehouse managers (global notification)
  - Inventory administrators (personal notification)
  - Users assigned to affected branch

---

## 11. Supplier Returns Management

### 11.1 Return Request Workflow

#### 11.1.1 Return Request Structure

**Multi-Batch Support:** One return request can include multiple batches/SKUs

**Request Fields:**

- Unique return request code
- Supplier reference
- Return line items:

  - Batch ID or SKU ID
  - Quantity to return
  - Reason type: DEFECTIVE, EXPIRED, DAMAGED, WRONG_ITEM, EXCESS_STOCK, OTHER
  - Custom reason notes (required for most reasons)
  - Condition type: same as reason or separate field
  - Expected credit amount

- Attachments: Photos of condition, defect evidence
- Requested by user, requested date
- Status: RETURN_DRAFT, RETURN_SUBMITTED, RETURN_APPROVED, RETURN_VERIFIED, RETURN_CANCELLED

#### 11.1.2 Return Workflow

1. **Creation**: User identifies defective/returnable batches, creates return request
2. **Approval** (optional, role-based): Manager approves return request
3. **Inventory Adjustment**: Upon verification (RETURN_VERIFIED):

   - Inventory transaction created with negative quantity
   - Batch quantity reduced immediately
   - Batch status updated if fully returned

4. **Completion**: Return request marked verified; no post-shipment tracking needed

**Business Rule**: Inventory removed immediately upon internal verification (not waiting for supplier confirmation).

---

## 12. Reporting & Analytics

### 12.1 Standard Reports

#### 12.1.1 Inventory Reports

- **Stock on Hand**: Current inventory by SKU, category, branch, zone
- **Inventory Valuation**: Total value using cost price
- **Stock Movement**: Inbound/outbound quantities over time period
- **Slow-Moving Inventory**: Items with low turnover (configurable threshold)
- **Fast-Moving Inventory**: High-velocity items
- **Expiry Report**: Items expiring within X days, grouped by urgency

#### 12.1.2 Operational Reports

- **Purchase Order Summary**: PO status, on-time delivery rate
- **Receiving Performance**: Average receiving time, discrepancy rates
- **Picking Performance**: Items per hour, accuracy rate by user
- **Cycle Count Results**: Accuracy rates, adjustment frequencies
- **Session Metrics**: Time per session type, completion rates

#### 12.1.3 Supplier Performance Reports

- On-time delivery percentage
- Quality issue rate (returns vs total receipts)
- Price trend analysis
- Lead time analysis

### 12.2 Custom Report Builder

#### 12.2.1 Report Templates

**Functionality:**

- Users can create custom report templates
- Select data sources (tables/views)
- Choose columns/attributes to include
- Define filters (date range, branch, category, status, etc.)
- Set grouping and aggregation
- Choose visualization type (table, bar chart, line chart, pie chart)

**Storage:**

- Report template definitions stored in database
- Template name, description, owner user_id
- Template configuration in JSONB (columns, filters, chart type)
- Sharing permissions (private, shared with role, shared with organization)

#### 12.2.2 Report Execution

- Templates can be executed on-demand
- Optional: Store report execution history (who ran, when, parameters used)
- Export formats: PDF (A4 layout), Excel, CSV

### 12.3 Demand Forecasting

#### 12.3.1 Forecast Data Storage

**Purpose**: Enable projection overlays on charts

**Forecast Table:**

- `forecast_id`, `sku_id`, `forecast_date`, `forecast_type`
- `predicted_demand`: Forecasted quantity
- `confidence_interval`: Statistical confidence level
- `created_at`: When forecast was generated
- `calculation_method`: MOVING_AVERAGE, SEASONAL, LINEAR_REGRESSION, etc.

#### 12.3.2 Calculation Parameters

**Configurable Settings (stored in organization_settings):**

- Historical period for analysis (default: 3 months)
- Recalculation frequency (default: weekly)
- Seasonal adjustment enabled/disabled
- Forecast horizon (e.g., next 30, 60, 90 days)

#### 12.3.3 Forecast Methods

1. **Simple Moving Average**: Average demand over historical period
2. **Weighted Moving Average**: Recent data weighted higher
3. **Seasonal Adjustment**: Accounts for recurring patterns (e.g., holiday spikes)
4. **Linear Regression**: Trend-based prediction

**Execution:**

- Automated job runs weekly (configurable)
- Analyzes outbound order history
- Generates forecast records
- Used to overlay projections on inventory trend charts

---

## 13. Audit & Compliance

### 13.1 Comprehensive Audit Logging

#### 13.1.1 Audit Log Structure

**Purpose**: Track all changes to critical data with before/after states

**Fields:**

- `log_id`, `user_id`, `ip_address`, `created_at`
- `action_type`: CREATED, UPDATED, DELETED, VERIFIED, APPROVED, REJECTED, etc.
- `entity_type`: PRODUCT, SKU, PURCHASE_ORDER, INVENTORY_BATCH, USER, ROLE, SETTING, etc.
- `entity_id`: ID of affected record
- `field_name`: Specific field changed (for UPDATE actions)
- `old_value`, `new_value`: Before and after states (stored as text or JSONB)
- `notes`: Optional context

#### 13.1.2 Audited Entities

**All of the following require audit logging:**

- Product master data changes (name, description, pricing, specifications)
- Inventory quantity changes (via inventory_transactions table)
- Purchase order status changes
- User permission/role changes
- Organization/branch settings modifications
- Work session lifecycle events
- Adjustment request approvals
- Serial number status changes

#### 13.1.3 Role-Based Audit Log Access

- Audit logs viewable based on VIEW_AUDIT_LOGS permission
- Filter logs by:
  - Entity type and ID (all changes to Product #123)
  - User (all changes by User X)
  - Time range (all changes last week)
  - Field name (all price changes)
  - Action type (all deletions)

### 13.2 Data Retention & Soft Deletes

#### 13.2.1 Soft Delete Implementation

**Always Soft Delete (is_deleted + deleted_at fields):**

- Products and Product Variants (SKUs)
- Suppliers
- Purchase Orders, Outbound Orders
- Inventory Batches
- Users
- Branches, Storage Zones

**Hard Delete Allowed:**

- Notifications (after 90 days or on dismissal)
- Attachments (when parent entity deleted, cascade)
- Work Sessions (after completion, configurable retention)

**Never Delete (Archive Only - Future Enhancement):**

- Inventory Transactions
- Audit Logs

**Note**: Archiving to separate tables deferred to future implementation.

---

## 14. System Administration

### 14.1 Organization Settings

#### 14.1.1 Global Settings (organization_settings)

Key-value pairs stored in JSONB:

- `default_currency`: USD, VND, etc.
- `default_timezone`: UTC offset
- `expiry_warning_enabled`: boolean
- `auto_reorder_enabled`: boolean
- `default_lead_time_days`: integer
- `forecast_period_months`: integer (default 3)
- `forecast_frequency`: DAILY, WEEKLY, MONTHLY

#### 14.1.2 Branch Settings (branch_settings)

- Branch-specific operational hours
- Default receiving/packing zones
- Branch-specific alert recipients

#### 14.1.3 Category Settings (category_settings)

- Expiry warning thresholds per category
- Default storage requirements
- Auto-calculated ROP parameters

### 14.2 System Lookups

#### 14.2.1 Lookup Table Design

**Purpose**: Centralized enum/status code management

**Structure:**

- `id` (PK), `lookup_type`, `lookup_code`, `lookup_value`, `description`, `sort_order`

**Lookup Types:**

- STATUS: All status enums (PO_DRAFT, PO_SUBMITTED, etc.)
- SESSION_TYPE: RECEIVING_SESSION, PICKING_SESSION, PACKING_SESSION, CYCLE_COUNT_SESSION, RETURN_SESSION
- ZONE_TYPE: RECEIVING, STORAGE, PACKING, SHIPPING, QUARANTINE, RETURNS
- TRANSACTION_TYPE: RECEIVE, PICK, TRANSFER_OUT, TRANSFER_IN, ADJUSTMENT, RETURN
- REASON_TYPE: Adjustment/return reasons
- NOTIFICATION_CATEGORY: EXPIRY_WARNING, LOW_STOCK, etc.
- UOM: Unit of measure types

**Code Format**: All lookup codes use UPPERCASE_SNAKE_CASE (e.g., PO_DRAFT, CYCLE_COUNT_VARIANCE)

**Localization**: Handled frontend via i18n using lookup codes as keys; no database storage of translations needed.

---

## 15. Technical Specifications

### 15.1 Database Design Patterns

#### 15.1.1 Hierarchical Data

- Use PostgreSQL ltree extension for categories and storage zones
- Enables efficient ancestor/descendant queries
- Requires GiST index on path column

#### 15.1.2 JSONB Usage

**Appropriate Use Cases:**

- Custom product field values (extensible attributes)
- Organization/branch/category settings (flexible key-value)
- Zone attributes (varying by zone type)
- Notification payloads
- Report template configurations
- Audit log old/new values (for complex objects)

**Indexing**: Create GIN indexes on JSONB columns for query performance.

#### 15.1.3 Polymorphic Relationships

**Approach**: Nullable foreign keys with CHECK constraints

- Example: inventory_transactions links to purchase_order_detail_id OR transfer_order_detail_id OR work_session_id OR adjustment_request_id
- CHECK constraint ensures exactly one FK is populated
- Maintains referential integrity while allowing flexibility

#### 15.1.4 Soft Deletes

- Add `is_deleted` (boolean, default false) and `deleted_at` (timestamp, nullable)
- Filter queries with `WHERE is_deleted = false`
- Use database views for common queries to auto-filter deleted records

### 15.2 Performance Considerations

#### 15.2.1 Indexing Strategy

**Primary Indexes:**

- All foreign keys
- ltree path columns (GiST index)
- JSONB columns with frequent queries (GIN index)
- Status fields frequently used in WHERE clauses
- Date fields used in range queries (created_at, expires_at)
- Barcode fields (unique index for fast lookup)

**Composite Indexes:**

- (organization_id, is_deleted) for multi-tenant queries
- (sku_id, zone_id) for inventory lookups
- (user_id, created_at) for audit log queries

#### 15.2.2 Query Optimization

- Use materialized views for complex inventory aggregations (refresh on schedule)
- Partition large tables (inventory_transactions, audit_logs) by date range if needed
- Connection pooling for concurrent users
- Read replicas for reporting queries (future enhancement)

---

## 16. Integration & Extensibility

### 16.1 API Design Principles

- RESTful API design
- JWT-based authentication
- Organization-scoped API keys for external integrations (future)
- Webhook support for event notifications (future)
- Rate limiting per organization

### 16.2 Future Integration Points

- ERP system sync (bi-directional)
- E-commerce platforms (auto-create outbound orders)
- Accounting software (inventory valuation)
- Shipping carriers (tracking number updates)
- IoT sensors (temperature monitoring in zones)

**Note**: Integration tables/fields deferred to future implementation; ensure schema design doesn't preclude integration.

---

## 17. User Workflows Summary

### 17.1 Initial Setup Workflow

1. **Create Organization**:

   - Admin signs up, creates workspace
   - Configures organization settings
   - Creates initial branch(es)

2. **Invite Team Members**:

   - Admin generates invitation code
   - Employees scan QR or enter code
   - Admin approves and assigns roles

3. **Configure Warehouse Layout** (Optional):

   - Create 2D floor plan with zones
   - Define storage hierarchy
   - Set zone attributes
   - Assign special zones (receiving, packing, etc.)

4. **Setup Master Data**:

   - Create categories (hierarchical)
   - Add brands
   - Add suppliers with lead times
   - Create products and SKUs
   - Define custom product fields if needed

5. **Configure Permissions**:
   - Review predefined roles
   - Create custom roles as needed
   - Assign roles to users (org-wide or branch-specific)

### 17.2 Daily Operations Workflow

#### 17.2.1 Receiving Goods

1. User creates/selects purchase order
2. Start receiving session
3. Scan barcodes, confirm quantities, record batches
4. System suggests storage locations
5. Complete session
6. Manager verifies session
7. Inventory updated, PO status updated

#### 17.2.2 Fulfilling Outbound Order

1. User creates outbound order
2. Start picking session
3. Follow optimized route, scan items
4. Complete picking session
5. Verify picking session
6. Start packing session
7. Scan items, pack according to suggestions
8. Complete packing session
9. Verify packing session
10. Mark order as shipped (terminal state)

#### 17.2.3 Cycle Counting

1. Create cycle count session for zone(s)
2. Scan items, enter physical counts
3. Complete session
4. System shows discrepancies
5. Verify session
6. Create adjustment request for variances
7. Approve adjustment request
8. Inventory corrected

#### 17.2.4 Returning Goods to Supplier

1. Identify defective/expired batches
2. Create return request (multi-batch)
3. Specify reasons, add photos
4. Submit for approval (if required)
5. Verify return request
6. Inventory immediately reduced
7. Return request closed

### 17.3 Reporting Workflow

1. Navigate to reports section
2. Select standard report or custom template
3. Configure parameters (date range, filters)
4. Generate report
5. View on screen or export to PDF/Excel
6. Save as custom template for reuse

---

## 18. Mobile & UI Considerations

### 18.1 Mobile Scanning Interface

- Responsive web interface (no native app required)
- Camera access for barcode/QR scanning via browser
- Large touch targets for warehouse environment
- Offline-capable for session data entry (sync on reconnect)
- Session state preservation (don't lose data on accidental navigation)

### 18.2 Desktop Interface

- Dashboard with KPIs (inventory value, low stock alerts, pending verifications)
- 2D warehouse visualization for layout editing and route display
- Data grid for master data management (products, suppliers, etc.)
- Report builder with drag-drop interface
- Notification center with real-time updates

---

## 19. Security & Compliance

### 19.1 Data Security

- Password hashing with bcrypt or Argon2
- HTTPS required for all API communication
- Session management with secure cookies
- CSRF protection
- SQL injection prevention (parameterized queries)
- XSS prevention (input sanitization, output encoding)

### 19.2 Multi-Tenancy Isolation

- Row-level security via organization_id filtering
- Database views with automatic filtering
- API middleware enforces tenant context
- Prevent cross-organization data leakage

### 19.3 Audit Compliance

- Comprehensive audit logging (see §13.1)
- Immutable inventory transaction history
- User action traceability (who, what, when)
- IP address logging for security events
- Data retention policies (soft delete, archival)

---

## 20. Success Metrics

### 20.1 Operational KPIs

- Inventory accuracy rate (cycle count variance %)
- Receiving efficiency (time per PO line item)
- Picking efficiency (items per hour, accuracy rate)
- Order fulfillment time (order creation to verification)
- Stock-out frequency (SKUs hitting zero stock)
- Expiry waste (quantity of expired inventory)

### 20.2 System Health Metrics

- System uptime
- API response times
- Concurrent user capacity
- Data integrity checks (no orphaned records)

---

This specification provides a complete, production-ready blueprint for implementing a warehouse management system with all the features and technical details needed for development. All design decisions are based on the questionnaire answers provided and follow industry best practices for PostgreSQL database design.
