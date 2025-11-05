# Warehouse Management System - Use Case Diagrams

## Use Case Hierarchy

### UC01 - Authentication & User Management

- **UC01-01** Register Account
- **UC01-02** Login with Credentials
- **UC01-03** Login with Passkey (WebAuthn)
- **UC01-04** Login with GitHub OAuth
- **UC01-05** Forgot Password
- **UC01-06** Reset Password
- **UC01-07** Join Workspace
- **UC01-08** Manage User Preferences
- **UC01-09** Create Organization/Workspace
- **UC01-10** Generate Workspace Invitation Code
- **UC01-11** Approve/Reject Join Requests
- **UC01-12** Manage Users
- **UC01-13** Manage Roles
- **UC01-14** Assign Roles to Users

### UC02 - Master Data Management

- **UC02-01** Create Category
- **UC02-02** Edit Category
- **UC02-03** Configure Category Settings
- **UC02-04** Delete Category
- **UC02-05** Create Brand
- **UC02-06** Edit Brand
- **UC02-07** Delete Brand
- **UC02-08** Create Product
- **UC02-09** Edit Product
- **UC02-10** Define Custom Product Fields
- **UC02-11** Delete Product
- **UC02-12** Create SKU
- **UC02-13** Manage Barcodes
- **UC02-14** Edit SKU
- **UC02-15** Set Custom Field Values
- **UC02-16** Delete SKU
- **UC02-17** Create Supplier
- **UC02-18** Edit Supplier
- **UC02-19** View Supplier Performance
- **UC02-20** Delete Supplier

### UC03 - Warehouse Layout Configuration

- **UC03-01** Create 2D Warehouse Layout
- **UC03-02** Create Storage Zone
- **UC03-03** Edit Storage Zone
- **UC03-04** Delete Storage Zone
- **UC03-05** View Zone Hierarchy
- **UC03-06** Visualize 2D Layout

### UC04 - Purchase Order Management

- **UC04-01** Create Purchase Order
- **UC04-02** Edit Purchase Order
- **UC04-03** Submit Purchase Order
- **UC04-04** Cancel Purchase Order
- **UC04-05** View Purchase Order
- **UC04-06** Calculate Reorder Points (System)
- **UC04-07** Generate Low Stock Alerts (System)
- **UC04-08** Auto-Calculate ROP (System)

### UC05 - Receiving Operations

- **UC05-01** Create Receiving Session
- **UC05-02** Scan Barcodes
- **UC05-03** Scan Serial Numbers
- **UC05-04** Assign Storage Location
- **UC05-05** Handle Discrepancies
- **UC05-06** Attach Documents
- **UC05-07** Complete Receiving Session
- **UC05-08** Verify Receiving Session
- **UC05-09** Reject Receiving Session
- **UC05-10** Suggest Storage Location (System)

### UC06 - Outbound Operations

- **UC06-01** Create Outbound Order
- **UC06-02** Create Picking Session
- **UC06-03** Execute Picking
- **UC06-04** Complete Picking Session
- **UC06-05** Verify Picking Session
- **UC06-06** Create Packing Session
- **UC06-07** Complete Packing Session
- **UC06-08** Verify Packing Session
- **UC06-09** Calculate Optimal Picking Route (System)

### UC07 - Inventory Management & Cycle Counting

- **UC07-01** Create Cycle Count Session
- **UC07-02** Perform Physical Count
- **UC07-03** Complete Cycle Count Session
- **UC07-04** View Real-Time Inventory
- **UC07-05** Verify Cycle Count Session
- **UC07-06** Create Adjustment Request
- **UC07-07** Submit Adjustment for Approval
- **UC07-08** Approve Adjustment Request
- **UC07-09** Reject Adjustment Request
- **UC07-10** Check Expiry Dates (System)
- **UC07-11** Generate Low Stock Alerts (System)

### UC08 - Supplier Returns Management

- **UC08-01** Create Return Request
- **UC08-02** Submit Return Request
- **UC08-03** View Return Request Status
- **UC08-04** Review Return Request
- **UC08-05** Verify Return Request

### UC09 - Internal Transfer Management

- **UC09-01** Create Transfer Order
- **UC09-02** Execute Picking at Source
- **UC09-03** Mark Transfer as Shipped
- **UC09-04** Update Transfer to In Transit
- **UC09-05** Receive Transfer
- **UC09-06** Verify Transfer Order Quantities
- **UC09-07** Verify Transfer Order

### UC10 - Reporting & Analytics

- **UC10-01** View Inventory Reports
- **UC10-02** View Operational Reports
- **UC10-03** View Supplier Performance Reports
- **UC10-04** Create Custom Report Template
- **UC10-05** Execute Report Template
- **UC10-06** Export Report
- **UC10-07** Analyze Historical Data (System)
- **UC10-08** Generate Forecast Records (System)
- **UC10-09** View Audit Logs

### UC11 - Notifications & Alerts

- **UC11-01** View Notifications
- **UC11-02** Mark Notification as Read
- **UC11-03** Dismiss Notification
- **UC11-04** Navigate to Related Entity
- **UC11-05** Create Expiry Warnings (System)
- **UC11-06** Create Low Stock Alerts (System)
- **UC11-07** Create Pending Approval Notifications (System)
- **UC11-08** Create Session Complete Notifications (System)
- **UC11-09** Create System Error Notifications (System)

---

## Summary Statistics

- **Total Use Case Groups:** 11
- **Total Singular Use Cases:** 113
  - UC01 (Authentication): 14 use cases
  - UC02 (Master Data): 20 use cases
  - UC03 (Warehouse Layout): 6 use cases
  - UC04 (Purchase Orders): 8 use cases
  - UC05 (Receiving): 10 use cases
  - UC06 (Outbound): 9 use cases
  - UC07 (Inventory/Cycle Count): 11 use cases
  - UC08 (Returns): 5 use cases
  - UC09 (Transfers): 7 use cases
  - UC10 (Reporting): 9 use cases
  - UC11 (Notifications): 9 use cases
- **Extended Authentication Flows:** 5 detailed scenarios
- **System Automated Processes:** 14 use cases

---

## Actors

### Primary Actors

1. **System Administrator**

   - Highest level of access
   - Manages organization/workspace setup
   - Configures system-wide settings
   - Creates and manages roles and permissions
   - Manages branches and warehouses

2. **Warehouse Manager**

   - Oversees warehouse operations
   - Verifies work sessions
   - Approves adjustment requests
   - Reviews operational reports
   - Manages warehouse layout configuration

3. **Inventory Administrator**

   - Manages inventory adjustments
   - Approves cycle count adjustments
   - Monitors stock levels and alerts
   - Configures ROP and forecasting parameters

4. **Receiving Specialist**

   - Performs receiving operations
   - Creates and executes receiving sessions
   - Scans barcodes for incoming goods
   - Records batch information

5. **Shipping Specialist**

   - Creates outbound orders
   - Performs picking operations
   - Executes packing sessions
   - Verifies outbound shipments

6. **Stock Clerk**

   - Performs cycle counts
   - Creates basic inventory transactions
   - Scans items during operations
   - Reports discrepancies

7. **Purchasing Agent**

   - Creates purchase orders
   - Manages supplier relationships
   - Reviews supplier performance
   - Monitors reorder alerts

8. **Accountant**

   - Views inventory valuation reports
   - Reviews cost and pricing changes
   - Exports financial data
   - Audits transaction history

9. **Report Viewer**

   - Views standard reports
   - Exports report data
   - No modification permissions

10. **Employee (Unassigned)**
    - Newly registered user
    - Pending workspace approval
    - Limited to profile management

### Secondary Actors

1. **System (Scheduled Jobs)**

   - Automated background processes
   - ROP calculations
   - Expiry alert generation
   - Demand forecasting
   - Report scheduling

2. **External Integration System** (Future)
   - ERP systems
   - E-commerce platforms
   - Accounting software

---

## Use Case Diagram 1: Authentication & User Management

```txt
┌─────────────────────────────────────────────────────────────────┐
│                  Authentication & User Management               │
└─────────────────────────────────────────────────────────────────┘

Actor: Employee (Unassigned)
  │
  ├──> Register Account
  │     └──> «include» Validate Email Format
  │
  ├──> Login with Credentials
  │     ├──> «include» Verify Password
  │     └──> «include» Generate JWT Token
  │
  ├──> Login with Passkey (WebAuthn)
  │     ├──> «include» Verify Passkey
  │     └──> «include» Generate JWT Token
  │
  ├──> Login with GitHub OAuth
  │     ├──> «include» OAuth Flow (better-auth)
  │     └──> «include» Generate JWT Token
  │
  ├──> Forgot Password
  │     ├──> Request Password Reset
  │     ├──> Receive Reset Email
  │     └──> Reset Password with Token
  │
  ├──> Join Workspace
  │     ├──> Scan QR Code
  │     │     └──> «include» Decode Invitation Code
  │     ├──> Enter Invitation Code Manually
  │     └──> Submit Join Request
  │           └──> «extend» Request Pending Approval
  │
  └──> Manage User Preferences
        └──> Update Settings (JSONB)

Actor: System Administrator
  │
  ├──> Create Organization/Workspace
  │     ├──> Configure Organization Settings
  │     └──> Create Initial Branch
  │
  ├──> Generate Workspace Invitation Code
  │     ├──> Set Validity Duration
  │     ├──> Generate QR Code
  │     └──> «extend» Regenerate Code
  │
  ├──> Approve/Reject Join Requests
  │     ├──> Review Pending Requests
  │     └──> Assign Initial Role
  │
  ├──> Manage Users
  │     ├──> View All Users
  │     ├──> Deactivate User
  │     ├──> Assign to Branches
  │     └──> «extend» Soft Delete User
  │
  ├──> Manage Roles
  │     ├──> Create Custom Role
  │     ├──> Configure Bitwise Permissions
  │     ├──> Set Permission Scope (Global/Branch)
  │     └──> Delete Role
  │
  └──> Assign Roles to Users
        ├──> Assign Organization-Wide Role
        └──> Assign Branch-Specific Role

Better-Auth Integration:
  - Manages password hashing (bcrypt/Argon2)
  - Handles passkey registration/verification (WebAuthn)
  - OAuth provider integration (GitHub)
  - Session management
  - Password reset token generation
```

---

## Use Case Diagram 2: Master Data Management

```txt
┌─────────────────────────────────────────────────────────────────┐
│                    Master Data Management                        │
└─────────────────────────────────────────────────────────────────┘

Actor: System Administrator / Inventory Administrator
  │
  ├──> Manage Categories
  │     ├──> Create Category (Hierarchical)
  │     │     └──> «include» Use ltree for Hierarchy
  │     ├──> Edit Category
  │     ├──> Configure Category Settings
  │     │     ├──> Set Expiry Warning Thresholds
  │     │     └──> Set Default Storage Requirements
  │     └──> Delete Category (Soft Delete)
  │
  ├──> Manage Brands
  │     ├──> Create Brand
  │     ├──> Edit Brand
  │     └──> Delete Brand (Soft Delete)
  │
  ├──> Manage Products
  │     ├──> Create Product
  │     │     ├──> Assign Category
  │     │     ├──> Assign Brand
  │     │     ├──> Set Storage Requirements
  │     │     └──> Set Tracking Method (SERIAL/BATCH/NONE)
  │     ├──> Edit Product
  │     │     └──> «include» Audit Log Change
  │     ├──> Define Custom Product Fields
  │     │     ├──> Create Product Type Template
  │     │     └──> Define Field Types (text/number/date/dropdown)
  │     └──> Delete Product (Soft Delete)
  │
  ├──> Manage Product Variants (SKUs)
  │     ├──> Create SKU
  │     │     ├──> Generate/Assign SKU Code
  │     │     ├──> Set Cost/Selling Price
  │     │     ├──> Define Dimensions (weight/volume)
  │     │     └──> Set Packing Constraints
  │     ├──> Manage Barcodes
  │     │     ├──> Add Multiple Barcodes
  │     │     ├──> Specify Barcode Type
  │     │     └──> Generate QR Code
  │     ├──> Edit SKU
  │     │     └──> «include» Audit Price Changes
  │     ├──> Set Custom Field Values (JSONB)
  │     └──> Delete SKU (Soft Delete)
  │
  └──> Manage Suppliers
        ├──> Create Supplier
        │     └──> Set Default Lead Time
        ├──> Edit Supplier
        ├──> View Supplier Performance
        │     ├──> On-Time Delivery Rate
        │     ├──> Quality Metrics
        │     ├──> Price History
        │     └──> Order Statistics
        └──> Delete Supplier (Soft Delete)
```

---

## Use Case Diagram 3: Warehouse Layout Configuration

```txt
┌─────────────────────────────────────────────────────────────────┐
│                 Warehouse Layout Configuration                  │
└─────────────────────────────────────────────────────────────────┘

Actor: System Administrator / Warehouse Manager
  │
  ├──> Create 2D Warehouse Layout
  │     ├──> Define Floor Plan Dimensions
  │     ├──> Set Entry/Exit Points
  │     └──> Define Pathways for Route Calculation
  │
  ├──> Manage Storage Zones
  │     ├──> Create Zone
  │     │     ├──> Select Storage Block Type
  │     │     │     ├──> Freezer Unit Hierarchy
  │     │     │     ├──> Dry Rack Hierarchy
  │     │     │     ├──> Ground Zone Hierarchy
  │     │     │     ├──> Pallet Bay Hierarchy
  │     │     │     └──> Custom Hierarchy
  │     │     ├──> Set ltree Path
  │     │     ├──> Assign Zone Type
  │     │     │     ├──> RECEIVING
  │     │     │     ├──> STORAGE
  │     │     │     ├──> PACKING
  │     │     │     ├──> SHIPPING
  │     │     │     ├──> QUARANTINE
  │     │     │     └──> RETURNS
  │     │     └──> Set Zone Attributes (JSONB)
  │     │           ├──> Position Coordinates (x, y)
  │     │           ├──> Dimensions (L × W × H)
  │     │           ├──> Capacity Limits
  │     │           ├──> Temperature Range
  │     │           ├──> Humidity Control
  │     │           └──> Weight Constraints
  │     │
  │     ├──> Edit Zone
  │     │     ├──> Resize Zone
  │     │     ├──> Move Zone Position
  │     │     ├──> Rotate Zone (UI)
  │     │     ├──> Update Attributes
  │     │     └──> Change Hierarchy Template
  │     │
  │     ├──> Delete Zone
  │     │     ├──> Check Inventory Exists
  │     │     ├──> «extend» Block if Not Empty
  │     │     └──> Soft Delete if Empty
  │     │
  │     └──> View Zone Hierarchy
  │           └──> Query ltree Ancestors/Descendants
  │
  └──> Visualize 2D Layout
        ├──> View Interactive Map
        ├──> Highlight Zone Types
        └──> Display Capacity Utilization
```

---

## Use Case Diagram 4: Purchase Order Management

```txt
┌─────────────────────────────────────────────────────────────────┐
│                  Purchase Order Management                      │
└─────────────────────────────────────────────────────────────────┘

Actor: Purchasing Agent
  │
  ├──> Create Purchase Order
  │     ├──> Generate/Assign PO Code
  │     ├──> Select Supplier
  │     ├──> Set Dates (Order/Expected Delivery)
  │     ├──> Add Line Items
  │     │     ├──> Select SKU
  │     │     ├──> Enter Quantity
  │     │     └──> Set Unit Cost
  │     ├──> Attach Documents (Optional)
  │     └──> Set Status: PO_DRAFT
  │
  ├──> Edit Purchase Order
  │     ├──> Modify Line Items
  │     ├──> Update Dates
  │     └──> «include» Audit Log Changes
  │
  ├──> Submit Purchase Order
  │     └──> Change Status: PO_SUBMITTED
  │
  ├──> Cancel Purchase Order
  │     └──> Change Status: PO_CANCELLED
  │
  └──> View Purchase Order
        ├──> View Details
        ├──> View Status History
        └──> View Receiving History

Actor: System (ROP Calculation Job)
  │
  ├──> Calculate Reorder Points
  │     ├──> Analyze Outbound History
  │     ├──> Calculate Average Daily Sales
  │     ├──> Apply Lead Time
  │     ├──> Add Safety Stock
  │     └──> Update ROP per SKU
  │
  ├──> Generate Low Stock Alerts
  │     ├──> Compare Current Stock vs ROP
  │     ├──> Create Notifications
  │     └──> Suggest Order Quantities (EOQ)
  │
  └──> Auto-Calculate ROP (Weekly)
        └──> «extend» Allow Manual Override

Actor: Receiving Specialist
  │
  └──> Receive Purchase Order
        └──> (See Use Case Diagram 5: Receiving Operations)
```

---

## Use Case Diagram 5: Receiving Operations

```txt
┌─────────────────────────────────────────────────────────────────┐
│                     Receiving Operations                        │
└─────────────────────────────────────────────────────────────────┘

Actor: Receiving Specialist
  │
  ├──> Create Receiving Session
  │     ├──> Link to Purchase Order
  │     ├──> Set Status: SESSION_STARTED
  │     └──> Assign Session to Self
  │
  ├──> Scan Barcodes (Mobile Interface)
  │     ├──> Scan Product Barcode/QR
  │     ├──> Auto-Populate SKU Details
  │     ├──> Confirm/Enter Quantity Received
  │     └──> Record Batch Information
  │           ├──> Supplier Batch Number
  │           ├──> Generate Internal Batch Number
  │           ├──> Enter Expiry Date (if applicable)
  │           └──> Enter Manufacturing Date (optional)
  │
  ├──> Scan Serial Numbers (for Serialized Items)
  │     ├──> Scan Each Serial Number
  │     └──> Link to SKU & Batch
  │
  ├──> Assign Storage Location
  │     ├──> View Suggested Locations
  │     │     └──> «include» Optimal Storage Algorithm
  │     ├──> Select Suggested or Custom Location
  │     └──> Assign Serial Numbers to Zone
  │
  ├──> Handle Discrepancies
  │     ├──> System Compares Scanned vs Expected
  │     ├──> Flag Over/Under Shipment
  │     ├──> Add Variance Notes
  │     └──> Show Warning Indicator
  │
  ├──> Attach Documents
  │     ├──> Upload Delivery Notes
  │     ├──> Photo Damage Reports
  │     ├──> Quality Inspection Reports
  │     └──> Add Notes per Attachment
  │
  └──> Complete Session
        └──> Set Status: SESSION_COMPLETED

Actor: Warehouse Manager
  │
  └──> Verify Receiving Session
        ├──> Review Session Details
        ├──> Check for Discrepancies
        ├──> Approve Session
        │     ├──> Set Status: SESSION_VERIFIED
        │     ├──> Create Inventory Transactions
        │     ├──> Update Batch Quantities
        │     ├──> Update Serial Number Records
        │     └──> Update PO Status
        │           ├──> PO_PARTIALLY_RECEIVED
        │           └──> PO_FULLY_RECEIVED
        │
        └──> Reject Session
              ├──> Set Status: SESSION_REJECTED
              ├──> Provide Rejection Reason
              └──> Require New Session Creation

Actor: System (Optimal Storage Algorithm)
  │
  └──> Suggest Storage Location
        ├──> Filter Compatible Zones
        │     └──> Match Storage Requirements
        ├──> Calculate Available Capacity
        ├──> Rank by Pick Frequency
        ├──> Consider Proximity to Packing
        └──> Return Top 3 Suggestions
```

---

## Use Case Diagram 6: Outbound Operations

```txt
┌─────────────────────────────────────────────────────────────────┐
│                     Outbound Operations                         │
└─────────────────────────────────────────────────────────────────┘

Actor: Shipping Specialist
  │
  ├──> Create Outbound Order
  │     ├──> Generate Order Code
  │     ├──> Set Ship Date
  │     ├──> Add Line Items
  │     │     ├──> Select SKU
  │     │     └──> Enter Quantity Requested
  │     ├──> Set Status: OUTBOUND_DRAFT
  │     └──> «extend» Add Tracking Number
  │
  ├──> Create Picking Session
  │     ├──> Link to Outbound Order
  │     ├──> Generate Picking List
  │     │     ├──> List SKUs with Quantities
  │     │     └──> Suggest Zone Locations
  │     ├──> Calculate Optimal Route
  │     │     ├──> «include» 2D Layout if Available
  │     │     ├──> Order by Shortest Path
  │     │     └──> Display Route Map
  │     └──> Set Status: OUTBOUND_PICKING
  │
  ├──> Execute Picking
  │     ├──> Follow Picking List/Route
  │     ├──> Navigate to Each Zone
  │     ├──> Scan Barcode to Confirm SKU
  │     ├──> Enter/Confirm Quantity Picked
  │     ├──> Scan Serial Numbers (if applicable)
  │     │     └──> Validate Serial Exists in Inventory
  │     ├──> Select Batch (FIFO/FEFO Strategy)
  │     │     ├──> Pick Oldest Batches (FIFO)
  │     │     └──> Pick Near-Expiry Batches (FEFO)
  │     └──> Track Timestamp per Line Item
  │
  ├──> Complete Picking Session
  │     └──> Set Status: SESSION_COMPLETED
  │
  ├──> Verify Picking Session
  │     ├──> Review for Discrepancies
  │     └──> Approve Session
  │           ├──> Set Status: SESSION_VERIFIED
  │           ├──> Create Inventory Transactions (Deduct)
  │           ├──> Update Batch Quantities
  │           ├──> Mark Serial Numbers as PICKED
  │           └──> Update Order: OUTBOUND_PICKED
  │
  ├──> Create Packing Session
  │     ├──> Link to Outbound Order
  │     ├──> Set Status: OUTBOUND_PACKING
  │     ├──> Scan Picked Items to Confirm
  │     └──> View Smart Packing Suggestions
  │           ├──> Group by Temperature Sensitivity
  │           ├──> Heavy Items on Bottom
  │           ├──> Consider Fragility
  │           └──> Recommend Box Sizes
  │
  ├──> Complete Packing Session
  │     └──> Set Status: SESSION_COMPLETED
  │
  └──> Verify Packing Session
        ├──> Approve Packing
        │     ├──> Set Status: SESSION_VERIFIED
        │     └──> Update Order: OUTBOUND_PACKED
        │
        └──> Final Verification
              ├──> Mark as Ready to Ship
              └──> Set Status: OUTBOUND_VERIFIED (Terminal)

Actor: System (Route Optimizer)
  │
  └──> Calculate Optimal Picking Route
        ├──> Load 2D Warehouse Layout
        ├──> Get Required Zone Locations
        ├──> Calculate Shortest Path
        └──> Generate Route Sequence
```

---

## Use Case Diagram 7: Inventory Management & Cycle Counting

```txt
┌─────────────────────────────────────────────────────────────────┐
│              Inventory Management & Cycle Counting              │
└─────────────────────────────────────────────────────────────────┘

Actor: Stock Clerk
  │
  ├──> Create Cycle Count Session
  │     ├──> Select Zone(s) to Count
  │     ├──> Generate Expected Inventory List
  │     └──> Set Status: SESSION_STARTED
  │
  ├──> Perform Physical Count (Mobile)
  │     ├──> Scan Barcode for Each SKU
  │     ├──> Enter Physical Count
  │     ├──> Confirm Batch Numbers
  │     ├──> Scan Serial Numbers (if applicable)
  │     └──> Track Timestamp per Item
  │
  ├──> Complete Cycle Count Session
  │     ├──> Submit Counts
  │     └──> Set Status: SESSION_COMPLETED
  │
  └──> View Real-Time Inventory
        ├──> By SKU
        ├──> By Zone
        ├──> By Batch
        └──> By Serial Number

Actor: Warehouse Manager / Inventory Administrator
  │
  ├──> Verify Cycle Count Session
  │     ├──> Review Count Details
  │     ├──> Compare Expected vs Actual
  │     ├──> Identify Discrepancies
  │     │     └──> System Flags Variances
  │     ├──> Approve or Reject Session
  │     └──> If Discrepancies Exist:
  │           └──> Prompt to Create Adjustment Request
  │
  ├──> Create Adjustment Request
  │     ├──> Pre-Populate from Cycle Count
  │     ├──> Add Multiple SKUs/Batches
  │     ├──> For Each Line Item:
  │     │     ├──> Show Expected Quantity
  │     │     ├──> Show Actual Quantity
  │     │     ├──> Calculate Variance
  │     │     └──> Calculate Cost Impact
  │     ├──> Select Reason Type
  │     │     ├──> CYCLE_COUNT_VARIANCE
  │     │     ├──> DAMAGE
  │     │     ├──> THEFT
  │     │     ├──> DATA_ENTRY_ERROR
  │     │     ├──> EXPIRY
  │     │     └──> OTHER (requires custom notes)
  │     ├──> Attach Evidence (photos)
  │     └──> Set Status: ADJ_DRAFT
  │
  ├──> Submit Adjustment for Approval
  │     └──> Set Status: ADJ_PENDING_APPROVAL
  │
  └──> Approve Adjustment Request
        ├──> Review Details & Evidence
        ├──> Add Resolution Notes
        ├──> Approve
        │     ├──> Set Status: ADJ_APPROVED
        │     ├──> Create Inventory Transactions
        │     ├──> Update Batch Quantities
        │     └──> Update Serial Number Statuses
        │
        └──> Reject Adjustment
              ├──> Set Status: ADJ_REJECTED
              └──> Provide Rejection Reason

Actor: System (Expiry Alert Job)
  │
  ├──> Check Expiry Dates (Daily)
  │     ├──> Query Batches with expires_at
  │     ├──> Compare Against Warning Thresholds
  │     │     ├──> 60 Days (LOW)
  │     │     ├──> 30 Days (MEDIUM)
  │     │     ├──> 7 Days (HIGH)
  │     │     └──> Expired (CRITICAL)
  │     └──> Create Notifications
  │           ├──> Global for Warehouse Managers
  │           └──> Personal for Inventory Admins
  │
  └──> Generate Low Stock Alerts
        ├──> Compare Current Stock vs ROP
        └──> Create Notifications
```

---

## Use Case Diagram 8: Supplier Returns Management

```txt
┌─────────────────────────────────────────────────────────────────┐
│                  Supplier Returns Management                    │
└─────────────────────────────────────────────────────────────────┘

Actor: Inventory Administrator / Stock Clerk
  │
  ├──> Create Return Request
  │     ├──> Generate Return Request Code
  │     ├──> Select Supplier
  │     ├──> Add Return Line Items (Multi-Batch)
  │     │     ├──> Select Batch or SKU
  │     │     ├──> Enter Quantity to Return
  │     │     ├──> Select Reason Type
  │     │     │     ├──> DEFECTIVE
  │     │     │     ├──> EXPIRED
  │     │     │     ├──> DAMAGED
  │     │     │     ├──> WRONG_ITEM
  │     │     │     ├──> EXCESS_STOCK
  │     │     │     └──> OTHER
  │     │     ├──> Enter Custom Reason Notes
  │     │     └──> Enter Expected Credit Amount
  │     ├──> Attach Evidence Photos
  │     └──> Set Status: RETURN_DRAFT
  │
  ├──> Submit Return Request
  │     └──> Set Status: RETURN_SUBMITTED
  │
  └──> View Return Request Status

Actor: Warehouse Manager
  │
  ├──> Review Return Request
  │     ├──> View Details & Attachments
  │     └──> Approve or Reject
  │           ├──> If Approved: RETURN_APPROVED
  │           └──> If Rejected: Provide Reason
  │
  └──> Verify Return Request
        ├──> Confirm Items Ready to Return
        ├──> Set Status: RETURN_VERIFIED
        ├──> Create Inventory Transactions (Negative)
        ├──> Reduce Batch Quantities Immediately
        └──> Update Batch Status if Fully Returned
```

---

## Use Case Diagram 9: Internal Transfer Management

```txt
┌─────────────────────────────────────────────────────────────────┐
│                 Internal Transfer Management                    │
└─────────────────────────────────────────────────────────────────┘

Actor: Inventory Administrator / Warehouse Manager
  │
  ├──> Create Transfer Order
  │     ├──> Generate Transfer Code
  │     ├──> Select Source Branch
  │     ├──> Select Destination Branch
  │     ├──> Add Line Items (SKU, Quantity)
  │     ├──> Set Expected Delivery Date
  │     └──> Set Status: TRANSFER_DRAFT
  │
  ├──> Execute Picking at Source
  │     └──> (Same as Outbound Picking Session)
  │
  ├──> Mark as Shipped
  │     ├──> Add Tracking Number (optional)
  │     └──> Set Status: TRANSFER_SHIPPED
  │
  └──> Update to In Transit
        └──> Set Status: TRANSFER_IN_TRANSIT

Actor: Receiving Specialist (at Destination Branch)
  │
  ├──> Receive Transfer
  │     └──> (Same as Receiving Session for PO)
  │
  └──> Verify Received Quantities
        ├──> Compare Shipped vs Received
        └──> Set Status: TRANSFER_RECEIVED

Actor: Warehouse Manager (at Destination)
  │
  └──> Verify Transfer Order
        ├──> Approve Verification
        ├──> Set Status: TRANSFER_VERIFIED
        ├──> Deduct Inventory from Source Branch
        └──> Add Inventory to Destination Branch
```

---

## Use Case Diagram 10: Reporting & Analytics

```txt
┌─────────────────────────────────────────────────────────────────┐
│                    Reporting & Analytics                        │
└─────────────────────────────────────────────────────────────────┘

Actor: Warehouse Manager / Accountant / Report Viewer
  │
  ├──> View Standard Reports
  │     ├──> Inventory Reports
  │     │     ├──> Stock on Hand
  │     │     ├──> Inventory Valuation
  │     │     ├──> Stock Movement
  │     │     ├──> Slow-Moving Inventory
  │     │     ├──> Fast-Moving Inventory
  │     │     └──> Expiry Report
  │     │
  │     ├──> Operational Reports
  │     │     ├──> Purchase Order Summary
  │     │     ├──> Receiving Performance
  │     │     ├──> Picking Performance
  │     │     ├──> Cycle Count Results
  │     │     └──> Session Metrics
  │     │
  │     └──> Supplier Performance Reports
  │           ├──> On-Time Delivery %
  │           ├──> Quality Issue Rate
  │           ├──> Price Trend Analysis
  │           └──> Lead Time Analysis
  │
  ├──> Create Custom Report Template
  │     ├──> Select Data Sources
  │     ├──> Choose Columns/Attributes
  │     ├──> Define Filters (date, branch, category, status)
  │     ├──> Set Grouping & Aggregation
  │     ├──> Choose Visualization (table/chart)
  │     ├──> Save Template (JSONB Config)
  │     └──> Set Sharing Permissions
  │           ├──> Private
  │           ├──> Shared with Role
  │           └──> Shared with Organization
  │
  ├──> Execute Report Template
  │     ├──> Configure Parameters
  │     ├──> Generate Report
  │     └──> «extend» Store Execution History
  │
  └──> Export Report
        ├──> PDF (A4 Layout)
        ├──> Excel
        └──> CSV

Actor: System (Demand Forecasting Job)
  │
  ├──> Analyze Historical Data
  │     ├──> Query Outbound Order History
  │     ├──> Calculate Demand Patterns
  │     └──> Apply Forecasting Method
  │           ├──> Simple Moving Average
  │           ├──> Weighted Moving Average
  │           ├──> Seasonal Adjustment
  │           └──> Linear Regression
  │
  ├──> Generate Forecast Records
  │     ├──> Store per SKU
  │     ├──> Include Confidence Interval
  │     └──> Store Calculation Method
  │
  └──> Schedule Recalculation (Weekly)
        └──> Configurable Frequency

Actor: Accountant
  │
  └──> View Audit Logs
        ├──> Filter by Entity Type
        ├──> Filter by User
        ├──> Filter by Time Range
        ├──> Filter by Field Name
        ├──> Filter by Action Type
        └──> View Before/After Values
```

---

## Use Case Diagram 11: Notifications & Alerts

```txt
┌─────────────────────────────────────────────────────────────────┐
│                    Notifications & Alerts                       │
└─────────────────────────────────────────────────────────────────┘

Actor: All Authenticated Users
  │
  ├──> View Notifications
  │     ├──> View Notification Bell Icon
  │     ├──> See Unread Count
  │     ├──> View Notification List
  │     │     ├──> Global Notifications
  │     │     └──> Personal Notifications
  │     └──> Filter by Category
  │           ├──> EXPIRY_WARNING
  │           ├──> LOW_STOCK
  │           ├──> PENDING_APPROVAL
  │           ├──> SESSION_COMPLETE
  │           └──> SYSTEM_ERROR
  │
  ├──> Mark Notification as Read
  │     └──> Update read_at Timestamp
  │
  ├──> Dismiss Notification
  │     └──> Update dismissed_at Timestamp
  │
  └──> Navigate to Related Entity
        └──> Click action_url Deep Link

Actor: System (Notification Generator)
  │
  ├──> Create Expiry Warnings
  │     ├──> Triggered by Expiry Alert Job
  │     ├──> Set Priority (LOW/MEDIUM/HIGH/CRITICAL)
  │     └──> Send to Warehouse Managers & Inventory Admins
  │
  ├──> Create Low Stock Alerts
  │     ├──> Triggered by ROP Calculation
  │     └──> Send to Purchasing Agents
  │
  ├──> Create Pending Approval Notifications
  │     ├──> For Sessions Awaiting Verification
  │     ├──> For Adjustments Awaiting Approval
  │     └──> Send to Approvers
  │
  ├──> Create Session Complete Notifications
  │     ├──> When Session Status = COMPLETED
  │     └──> Send to Verifiers
  │
  └──> Create System Error Notifications
        └──> Send to System Administrators
```

---

## Actor-Permission Matrix

| Actor                     | Key Permissions                                                                                  |
| ------------------------- | ------------------------------------------------------------------------------------------------ |
| **System Administrator**  | All permissions (global scope)                                                                   |
| **Warehouse Manager**     | VERIFY_SESSION, APPROVE_ADJUSTMENT, VIEW_REPORTS, CONFIGURE_WAREHOUSE, MANAGE_BRANCHES           |
| **Inventory Admin**       | ADJUST_INVENTORY, APPROVE_ADJUSTMENT, APPROVE_ALL_ADJUSTMENTS, VIEW_INVENTORY, MANAGE_CATEGORIES |
| **Receiving Specialist**  | RECEIVE_GOODS, START_SESSION, COMPLETE_SESSION, VIEW_INVENTORY                                   |
| **Shipping Specialist**   | CREATE_OUTBOUND, PICK_ITEMS, PACK_ITEMS, START_SESSION, COMPLETE_SESSION                         |
| **Stock Clerk**           | START_SESSION, COMPLETE_SESSION, VIEW_INVENTORY, CREATE_ADJUSTMENT                               |
| **Purchasing Agent**      | CREATE_PO, EDIT_PO, APPROVE_PO, VIEW_PO, MANAGE_SUPPLIERS                                        |
| **Accountant**            | VIEW_REPORTS, EXPORT_DATA, VIEW_AUDIT_LOGS                                                       |
| **Report Viewer**         | VIEW_REPORTS, EXPORT_DATA                                                                        |
| **Employee (Unassigned)** | None (pending workspace approval)                                                                |
| **System (Jobs)**         | Internal system operations (no user permissions needed)                                          |

---

## Extended Authentication Flows (better-auth)

### Use Case: Register with Email & Password

```txt
Employee (Unassigned)
  │
  ├──> Navigate to Registration Page
  ├──> Enter Registration Details
  │     ├──> Username
  │     ├──> Email
  │     ├──> Password
  │     └──> Full Name
  │
  └──> Submit Registration
        │
        ├──> better-auth validates input
        ├──> better-auth hashes password (bcrypt/Argon2)
        ├──> Create user record
        ├──> Send verification email (optional)
        └──> Redirect to Join Workspace flow
```

### Use Case: Login with Credentials

```txt
User
  │
  ├──> Navigate to Login Page
  ├──> Enter Email & Password
  └──> Submit Login
        │
        ├──> better-auth verifies credentials
        ├──> better-auth generates JWT token
        ├──> Create session
        └──> Redirect to Dashboard
```

### Use Case: Login with Passkey (WebAuthn)

```txt
User
  │
  ├──> Navigate to Login Page
  ├──> Click "Login with Passkey"
  ├──> Browser prompts for biometric/device authentication
  │     └──> (Fingerprint, Face ID, Security Key, etc.)
  │
  └──> Authenticate
        │
        ├──> better-auth verifies passkey challenge
        ├──> better-auth generates JWT token
        ├──> Create session
        └──> Redirect to Dashboard

Prerequisite: User must have registered a passkey
  ├──> User logs in with password first time
  ├──> Navigate to Security Settings
  ├──> Click "Add Passkey"
  ├──> Browser prompts to create passkey
  └──> better-auth stores public key credential
```

### Use Case: Login with GitHub OAuth

```txt
User
  │
  ├──> Navigate to Login Page
  ├──> Click "Login with GitHub"
  └──> Redirect to GitHub OAuth
        │
        ├──> User authorizes application
        ├──> GitHub redirects back with auth code
        ├──> better-auth exchanges code for access token
        ├──> better-auth fetches user profile
        ├──> Create/Link user account
        ├──> better-auth generates JWT token
        └──> Redirect to Dashboard (or Join Workspace if new)
```

### Use Case: Forgot Password

```txt
User
  │
  ├──> Navigate to Login Page
  ├──> Click "Forgot Password"
  ├──> Enter Email Address
  └──> Request Password Reset
        │
        ├──> better-auth validates email exists
        ├──> better-auth generates reset token
        ├──> Send reset email with link
        └──> Display "Check your email" message

User receives email:
  │
  ├──> Click reset link
  ├──> Navigate to Reset Password Page
  ├──> Enter New Password
  └──> Submit Reset
        │
        ├──> better-auth validates reset token
        ├──> better-auth validates token not expired
        ├──> better-auth hashes new password
        ├──> Update user password
        ├──> Invalidate reset token
        └──> Redirect to Login Page
```

---

## System Integration Points

### better-auth Responsibilities

1. **Authentication**

   - Password hashing (bcrypt/Argon2)
   - JWT token generation & validation
   - Session management
   - OAuth provider integration (GitHub, etc.)
   - WebAuthn/Passkey management

2. **Security**

   - CSRF protection
   - Rate limiting for auth endpoints
   - Secure password reset flows
   - Token refresh mechanisms

3. **User Management**
   - User registration
   - Email verification
   - Password changes
   - Account linking (OAuth)

### Application Responsibilities

1. **Authorization**

   - Role-based access control (RBAC)
   - Bitwise permission checking
   - Branch-scoped permissions
   - Resource ownership validation

2. **Business Logic**
   - Workspace invitation flow
   - Join request approval
   - Role/permission assignment
   - Multi-branch assignment

---

## Notes

- All use cases enforce organization_id filtering for multi-tenancy isolation
- Soft deletes preserve referential integrity for historical data
- Audit logs capture all critical state changes
- Real-time inventory updates occur only upon session verification
- Mobile scanning uses responsive web interface (no native app)
- All status codes use UPPERCASE_SNAKE_CASE format
- Frontend handles localization via i18n using status codes as keys

---

This comprehensive use case specification covers all major workflows in the warehouse management system with enhanced authentication flows managed by better-auth.
