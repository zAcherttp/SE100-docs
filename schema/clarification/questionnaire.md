# Database Schema Refinement Questionnaire

## Checklist Overview

- Validate schema coverage for all warehouse management features (receiving, picking, inventory tracking)
- Identify missing tables/fields for intelligent suggestion systems (order recommendations, storage optimization)
- Clarify data structures for 2D warehouse layouts and route optimization
- Review permissions and role-based access control adequacy
- Examine reporting and analytics data requirements
- Assess batch/lot tracking and expiry management completeness

---

## Section 1: Purchase Order Management & Smart Ordering

### Question 1.1: Smart Order Suggestion System

**Question:** The features mention an "Intelligent Order Suggestion System" based on sales history and safety stock. What specific data points should be tracked to enable this? (e.g., average daily sales, lead time from suppliers, seasonality factors, minimum order quantities)

**Related Feature:** Hệ thống Gợi ý Đặt hàng Thông minh (dựa trên lịch sử bán hàng và tồn kho an toàn)

**Question Type:** Open-ended

**Expected Answer Guidance:** Describe the historical data needed (sales transactions, demand patterns), supplier lead times, safety stock levels, and any business rules for reorder point calculations.

---

### Question 1.2: Sales History Tracking

**Question:** Currently, the schema does not include sales/order history tables. Should we add tables to track outbound orders, sales transactions, or customer orders to support the intelligent ordering system?

**Related Feature:** Hệ thống Gợi ý Đặt hàng Thông minh (dựa trên lịch sử bán hàng và tồn kho an toàn)

**Question Type:** Yes/No

**Options:**

- Yes - Add sales/order tables
- No - Sales data will come from external system

**Expected Answer Guidance:** If yes, specify what fields are needed (order date, SKU, quantity, customer info, etc.). If no, clarify how the suggestion system will access external sales data.

---

### Question 1.3: Supplier Performance Tracking

**Question:** To optimize purchasing decisions, should we track supplier performance metrics such as on-time delivery rate, quality issues, or price history?

**Related Feature:** Quản lý Đơn hàng Mua (tạo và theo dõi đơn hàng nhà cung cấp)

**Question Type:** Multiple-choice

**Options:**

- Track detailed supplier performance (delivery times, quality ratings, price changes)
- Track only basic supplier information (current schema)
- Track supplier performance in a separate analytics system

**Expected Answer Guidance:** Consider what metrics would influence future purchasing decisions and whether this data should be in the operational database or a separate analytics database.

---

## Section 2: Receiving & Barcode Operations

### Question 2.1: Barcode/QR Code Data Structure

**Question:** The `product_variants` table has a single `barcode` field. Do you need to support multiple barcodes per SKU (e.g., manufacturer barcode, internal barcode, case barcode, pallet barcode)?

**Related Feature:** Nghiệp vụ Nhận hàng (sử dụng mã vạch/QR, tự động điền thông tin)

**Question Type:** Yes/No

**Options:**

- Yes - Need multiple barcode types per SKU
- No - Single barcode per SKU is sufficient

**Expected Answer Guidance:** If yes, we should create a separate `product_barcodes` table with fields for barcode type and value. If no, confirm the single barcode field is adequate.

---

### Question 2.2: Receiving Workflow Status

**Question:** The features describe receiving goods with status changes ("Đã xác nhận"). Should `purchase_orders` track multiple detailed statuses beyond what's in `purchase_order_status_type_id`? (e.g., Draft, Submitted, Confirmed, Partially Received, Fully Received, Closed)

**Related Feature:** Nghiệp vụ Nhận hàng - Sau khi xác nhận, phiếu nhập kho sẽ chuyển trạng thái thành "Đã xác nhận"

**Question Type:** Open-ended

**Expected Answer Guidance:** List all the status transitions a purchase order goes through in your workflow, from creation to completion.

---

### Question 2.3: Receiving Documentation

**Question:** Do you need to store receiving documents/images (e.g., delivery notes, damage photos, quality inspection reports) as part of the receiving process?

**Related Feature:** Nghiệp vụ Nhận hàng

**Question Type:** Yes/No

**Options:**

- Yes - Store document metadata/paths in database
- No - Not required

**Expected Answer Guidance:** If yes, specify what types of documents and whether you'll store file paths, URLs, or metadata only.

---

## Section 3: Storage Optimization & 2D Warehouse Layout

### Question 3.1: 2D Warehouse Layout Data Model

**Question:** The features describe a detailed 2D warehouse layout system with shelves, dimensions, zones, and entry/exit points. What specific attributes need to be stored for each element? (e.g., shelf coordinates, dimensions, capacity, temperature zone, accessibility constraints)

**Related Feature:** Luồng thiết lập sơ đồ kho - tạo một sơ đồ kho 2D bao gồm kích thước không gian kho, kích thước kệ (dài x rộng)

**Question Type:** Open-ended

**Expected Answer Guidance:** Provide a detailed list of attributes for: warehouse floor (overall dimensions), zones (coordinates, type), shelves/racks (location, size, capacity), hierarchy levels (shelf > tier > bin), and special zones (receiving, packing areas).

---

### Question 3.2: Storage Location Hierarchy

**Question:** The current `storage_zones` table uses `ltree` for hierarchy. Does this structure adequately represent your needs for Kệ → Tầng/Hộc hierarchy, or do you need additional tables for shelves, bins, and tiers?

**Related Feature:** Luồng thiết lập sơ đồ kho - Kệ -> dropdown list [tầng/hộc, ...]

**Question Type:** Multiple-choice

**Options:**

- Current ltree path in storage_zones is sufficient
- Need separate tables: warehouses, aisles, racks, shelves, bins
- Need hybrid approach with ltree + additional attributes table

**Expected Answer Guidance:** Consider how complex your warehouse hierarchy is and whether you need to query/filter by specific levels frequently.

---

### Question 3.3: Optimal Storage Location Algorithm

**Question:** For the "Optimal Storage Location Suggestion" feature based on sales frequency, what data points should be considered? (e.g., pick frequency, product dimensions, zone temperature requirements, proximity to packing area)

**Related Feature:** Hệ thống Gợi ý Vị trí Lưu trữ Tối ưu (dựa trên tần suất bán ra)

**Question Type:** Open-ended

**Expected Answer Guidance:** List all factors that influence where a product should be stored, including product characteristics, historical pick frequency, and warehouse layout constraints.

---

### Question 3.4: Zone Attributes and Constraints

**Question:** What specific attributes do storage zones need beyond zone_type? (e.g., temperature range, humidity control, hazmat certification, maximum weight capacity, restricted access)

**Related Feature:** Luồng thiết lập sơ đồ kho - điều chỉnh thuộc tính cần thiết (là kho lạnh, là kho khô, ...)

**Question Type:** Open-ended

**Expected Answer Guidance:** Enumerate all zone characteristics that affect which products can be stored where and any compliance/regulatory requirements.

---

### Question 3.5: Warehouse Layout Geometry

**Question:** For route optimization, do you need to store physical layout geometry (coordinates, pathways, obstacles) in the database, or will this be handled by a separate mapping/visualization layer?

**Related Feature:** Tối ưu hóa lộ trình di chuyển (chỉ dẫn nhân viên theo lộ trình ngắn nhất)

**Question Type:** Multiple-choice

**Options:**

- Store detailed coordinates and pathways in database
- Store only zone/shelf positions; calculate routes in application layer
- Use external mapping service/library

**Expected Answer Guidance:** Consider performance implications of storing vs. calculating routes, and whether layout data needs to be version-controlled.

---

## Section 4: Picking & Outbound Operations

### Question 4.1: Picking List/Wave Management

**Question:** The features mention "picking lists" for outbound operations. Should we add tables to manage pick waves, pick tasks, and picker assignments?

**Related Feature:** Nghiệp vụ Soạn và Xuất hàng (tạo danh sách lấy hàng thông minh)

**Question Type:** Yes/No

**Options:**

- Yes - Add dedicated picking/wave management tables
- No - Generate picking lists dynamically without persistence

**Expected Answer Guidance:** If yes, describe the picking workflow (wave creation, task assignment, pick confirmation, packing). If no, explain how picking progress will be tracked.

---

### Question 4.2: Outbound Order Structure

**Question:** Currently missing outbound/sales order tables. What information needs to be captured for outbound shipments? (customer info, shipping address, carrier, tracking number, packing requirements)

**Related Feature:** Nghiệp vụ Soạn và Xuất hàng

**Question Type:** Open-ended

**Expected Answer Guidance:** Detail the complete outbound order lifecycle and what data is needed at each stage (order creation, picking, packing, shipping, delivery confirmation).

---

### Question 4.3: Smart Packing Suggestions

**Question:** For "Smart Packing Suggestions based on product characteristics," what product attributes drive packing decisions? Should we add fields to track product fragility, stacking limits, temperature sensitivity, hazmat flags?

**Related Feature:** Gợi ý Đóng gói Thông minh (dựa trên đặc tính sản phẩm)

**Question Type:** Open-ended

**Expected Answer Guidance:** List all product characteristics that affect how items should be packed together, box selection, packing materials needed, etc.

**Dependency:** Related to Question 3.4 on zone attributes - may need similar constraint tracking at product level.

---

### Question 4.4: Picking Route Optimization Data

**Question:** For optimal picking routes, do you need to track picker performance data (time per pick, accuracy rate) or just rely on warehouse layout geometry?

**Related Feature:** Tối ưu hóa lộ trình di chuyển (chỉ dẫn nhân viên theo lộ trình ngắn nhất)

**Question Type:** Multiple-choice

**Options:**

- Track detailed picker performance metrics
- Optimize based on layout only
- Both - layout plus historical performance

**Expected Answer Guidance:** Consider whether picker skill levels or historical time data should influence route generation.

---

## Section 5: Inventory Tracking & Cycle Counting

### Question 5.1: Real-time Inventory View

**Question:** The current schema tracks inventory in `inventory_batches` by zone. Is this granularity sufficient for "real-time inventory tracking," or do you need a materialized view or separate current stock table for performance?

**Related Feature:** Theo dõi tồn kho thời gian thực

**Question Type:** Multiple-choice

**Options:**

- Current batch-level tracking is sufficient
- Add materialized view aggregating by SKU/zone
- Add separate current_inventory table with triggers

**Expected Answer Guidance:** Consider query performance for inventory lookups across many batches and whether eventual consistency is acceptable.

---

### Question 5.2: Expiry Date Alerting

**Question:** For automated expiry warnings, what lead times are needed? (e.g., alert 30 days before expiry, 7 days before expiry) Should these be configurable per product category?

**Related Feature:** Quản lý hạn sử dụng (cảnh báo tự động khi sắp hết hạn)

**Question Type:** Open-ended

**Expected Answer Guidance:** Specify warning thresholds and whether they vary by product type. Consider if we need an alerts/notifications table.

---

### Question 5.3: Cycle Count Process

**Question:** The features describe mobile barcode scanning for cycle counts. Should we add tables to track count sessions, assigned count areas, discrepancy resolution workflow, and count history?

**Related Feature:** Nghiệp vụ Kiểm kê kho (sử dụng thiết bị di động để quét mã vạch)

**Question Type:** Yes/No

**Options:**

- Yes - Add cycle count management tables
- No - Track counts through inventory_transactions only

**Expected Answer Guidance:** If yes, describe the complete cycle count workflow (session creation, zone assignment, count entry, review, approval, adjustment). If no, explain how count history will be auditable.

---

### Question 5.4: Variance/Adjustment Approval

**Question:** For discrepancies found during cycle counts, do you need an approval workflow before adjustments are applied? Should we track who counted, who reviewed, and who approved?

**Related Feature:** Xử lý chênh lệch (tự động so sánh và tạo phiếu điều chỉnh)

**Question Type:** Yes/No

**Options:**

- Yes - Multi-step approval workflow required
- No - Adjustments can be applied immediately by authorized users

**Expected Answer Guidance:** If yes, define approval levels and thresholds (e.g., variances over X% require manager approval). If no, confirm all counters have adjustment authority.

---

## Section 6: Returns Management

### Question 6.1: Supplier Return Tracking

**Question:** For "Return to Supplier Management (by batch)," what information needs to be captured beyond linking to the original batch? (return reason, condition, credit expected, return shipping details)

**Related Feature:** Quản lý Trả hàng Nhà cung cấp (theo từng lô nhập)

**Question Type:** Open-ended

**Expected Answer Guidance:** Detail the complete return workflow and what data is needed to track return authorization, shipping, credit/refund processing, and final resolution.

---

### Question 6.2: Return Inventory Disposition

**Question:** When goods are returned to supplier, should the inventory be immediately removed from stock, or held in a quarantine/return status until actually shipped?

**Related Feature:** Quản lý Trả hàng Nhà cung cấp

**Question Type:** Multiple-choice

**Options:**

- Remove from available inventory immediately upon return authorization
- Move to quarantine/return zone until shipped
- Keep in stock until supplier confirms receipt

**Expected Answer Guidance:** Consider how this affects inventory accuracy and whether you need a separate status in `batch_status_type_id`.

---

## Section 7: Reporting & Analytics

### Question 7.1: Report Builder Requirements

**Question:** For the "modular, composable report builder" feature, what level of flexibility is needed? Should we store custom report definitions, user-created report templates, or scheduled reports in the database?

**Related Feature:** Các mục báo cáo đa dạng, mục tiêu làm báo cáo theo thiên hướng modular, có thể chọn thuộc tính và khoảng thời gian báo cáo

**Question Type:** Multiple-choice

**Options:**

- Store user-defined report templates and parameters
- Generate reports on-demand only; no storage
- Store both templates and report execution history

**Expected Answer Guidance:** Consider whether users need to save/share custom reports and if audit trail of report runs is needed.

---

### Question 7.2: Performance Metrics Tables

**Question:** The features mention "operational performance reports (e.g., order processing time)." Should we add tables to track key performance metrics like pick time, pack time, receive time per order?

**Related Feature:** Báo cáo hiệu suất vận hành (ví dụ: thời gian xử lý đơn hàng)

**Question Type:** Yes/No

**Options:**

- Yes - Add performance tracking tables
- No - Calculate from audit_logs and transaction timestamps

**Expected Answer Guidance:** If yes, specify which metrics to track. If no, confirm that timestamp analysis from existing tables provides sufficient data.

---

### Question 7.3: AI-Generated Natural Language Reports

**Question:** For the AI integration to generate reports from natural language, what data structures or metadata are needed to support this? (report schema definitions, field descriptions, relationships metadata)

**Related Feature:** Dự kiến có thể làm một mẫu báo cáo composable, tích hợp API AI để có thể tạo báo cáo bằng natural language

**Question Type:** Open-ended

**Expected Answer Guidance:** Describe how the AI will understand your schema (metadata tables, semantic layer, data dictionary) and what constraints/validations should apply.

---

### Question 7.4: Inventory Valuation Methods

**Question:** For inventory value reports, which costing method should be supported: FIFO, LIFO, weighted average, or specific identification? Does this need to be configurable?

**Related Feature:** Báo cáo phân tích thông minh (Nhập-Xuất-Tồn, giá trị tồn kho)

**Question Type:** Multiple-choice

**Options:**

- FIFO only
- Weighted average only
- Multiple methods - configurable per organization
- Specific identification by batch

**Expected Answer Guidance:** Consider regulatory requirements and whether different branches might use different methods.

---

## Section 8: User Management & Permissions

### Question 8.1: Workspace Invitation Flow

**Question:** For the employee invitation workflow (QR code/manual code entry), what tables/fields are needed to track pending invitations, approval status, and invitation expiry?

**Related Feature:** Nhân viên tạo tài khoản và chọn Gia nhập workspace có sẵn -> Quét mã QR hoặc nhập mã Workspace thủ công

**Question Type:** Open-ended

**Expected Answer Guidance:** Describe the complete invitation process: generation of invite code, QR code data, pending requests table, approval workflow, and code expiration logic.

---

### Question 8.2: Granular Permission Model

**Question:** The features describe Discord-like attribute-based permissions. Should we replace the current simple role-permissions model with a more flexible attribute/capability system?

**Related Feature:** Nhóm quyền được Quản trị viên tạo và đặt tên, sau đó có thể bật tắt các quyền nhỏ lẻ (attributes) tương tự như hệ thống phân quyền của Discord

**Question Type:** Multiple-choice

**Options:**

- Keep current role-permissions table structure
- Add permission categories/groups with granular attributes
- Implement bitwise permission flags for performance

**Expected Answer Guidance:** Consider the number of permissions, how often they change, and query performance for permission checks.

---

### Question 8.3: Branch-Level Permissions

**Question:** Should permissions be scoped at the branch level (user can manage inventory in Branch A but only view in Branch B), or are organization-wide role permissions sufficient?

**Related Feature:** Quản trị viên gán quyền hạn chi tiết cho từng tài khoản hoặc nhóm

**Question Type:** Multiple-choice

**Options:**

- Organization-wide permissions only
- Branch-specific permissions required
- Hybrid - some permissions global, others branch-specific

**Expected Answer Guidance:** Consider whether multi-branch organizations need different access levels per location and how complex the permission checks would become.

---

### Question 8.4: Custom Role Creation

**Question:** Can administrators create unlimited custom roles with custom names, or should there be predefined role templates (warehouse manager, stock clerk, accountant, etc.)?

**Related Feature:** Nhóm quyền (thủ kho, bán hàng, kế toán) được Quản trị viên tạo và đặt tên

**Question Type:** Multiple-choice

**Options:**

- Fully custom roles - admin defines names and permissions
- Predefined role templates that can be customized
- Fixed roles with no customization

**Expected Answer Guidance:** Balance flexibility with ease of management and permission auditing.

---

## Section 9: System Architecture & Data Types

### Question 9.1: Polymorphic Relationships Handling

**Question:** The schema uses nullable FKs with CHECK constraints to handle polymorphic relationships (e.g., `inventory_transactions` linking to different source types). Is this approach acceptable, or would you prefer separate transaction tables per type?

**Related Feature:** General schema design

**Question Type:** Multiple-choice

**Options:**

- Keep nullable FK approach with CHECK constraints
- Create separate transaction tables per source type
- Use a PostgreSQL inheritance or partitioning strategy

**Expected Answer Guidance:** Consider query complexity, referential integrity enforcement, and future extensibility.

---

### Question 9.2: JSONB Usage for Flexibility

**Question:** Should we use JSONB columns for extensible attributes (e.g., custom product attributes, dynamic form fields, report parameters) or maintain a strictly typed schema?

**Related Feature:** General schema design for flexibility

**Question Type:** Multiple-choice

**Options:**

- Strictly typed schema - add columns as needed
- Use JSONB for extensible attributes
- Hybrid - JSONB for truly dynamic data only

**Expected Answer Guidance:** Consider query performance, validation requirements, and whether business users need to define custom fields.

---

### Question 9.3: Multi-tenancy Isolation

**Question:** How should data be isolated between organizations? Is the current approach (organization_id FK in relevant tables) sufficient, or do you need schema-per-tenant or database-per-tenant isolation?

**Related Feature:** Khởi tạo Workspace (tài khoản tổng cho doanh nghiệp)

**Question Type:** Multiple-choice

**Options:**

- Shared schema with organization_id filtering (current approach)
- Separate schema per organization
- Separate database per organization

**Expected Answer Guidance:** Consider scale (number of organizations), security requirements, backup/restore needs, and cost implications.

---

### Question 9.4: Soft Delete vs Hard Delete

**Question:** Should entities support soft deletes (is_deleted flag) to maintain historical records, or are hard deletes acceptable? Which entities require soft delete capability?

**Related Feature:** General data retention and audit requirements

**Question Type:** Open-ended

**Expected Answer Guidance:** Identify which entities should never be truly deleted (for audit/compliance), which can be hard deleted, and retention policies for soft-deleted records.

---

## Section 10: Missing Features & Clarifications

### Question 10.1: Mobile Device Management

**Question:** The features mention mobile device usage for scanning. Do you need to track which mobile devices are in use, device assignments to users, or device location/status?

**Related Feature:** Nghiệp vụ Nhận hàng (sử dụng mã vạch/QR), Nghiệp vụ Kiểm kê kho (sử dụng thiết bị di động)

**Question Type:** Yes/No

**Options:**

- Yes - Track device inventory and assignments
- No - Device management outside database scope

**Expected Answer Guidance:** If yes, specify what device information is needed (ID, type, assigned user, last sync time, battery status).

---

### Question 10.2: Notification System

**Question:** For automated alerts (expiry warnings, low stock, approval requests), should we add a notifications table to track pending/read/dismissed alerts per user?

**Related Feature:** Quản lý hạn sử dụng (cảnh báo tự động khi sắp hết hạn)

**Question Type:** Yes/No

**Options:**

- Yes - Store notifications in database
- No - Handle notifications in application layer only

**Expected Answer Guidance:** If yes, describe notification types, delivery methods (in-app, email, SMS), and retention policy.

**Dependency:** Related to Question 5.2 on expiry alerting.

---

### Question 10.3: Workflow/Approval Engine

**Question:** Multiple features mention approvals (cycle count adjustments, return authorizations, user invitations). Should we implement a generic workflow/approval engine table structure?

**Related Feature:** Multiple approval workflows across features

**Question Type:** Multiple-choice

**Options:**

- Generic workflow engine with states and transitions
- Separate approval fields per entity type
- External workflow management system

**Expected Answer Guidance:** Consider if approval patterns are similar enough to warrant a generic solution vs. custom per entity type.

---

### Question 10.4: Integration Points

**Question:** Will this system integrate with external systems (ERP, accounting, e-commerce platforms)? Should we add integration logging, API keys, or webhook subscription tables?

**Related Feature:** General system architecture

**Question Type:** Open-ended

**Expected Answer Guidance:** List planned integrations, data sync requirements, and whether we need to track sync status, last sync time, or failed sync records.

---

### Question 10.5: Localization/Multi-language

**Question:** Does the system need to support multiple languages for product names, descriptions, or UI elements? Should we add localization tables?

**Related Feature:** General system requirements

**Question Type:** Yes/No

**Options:**

- Yes - Multi-language support needed
- No - Single language only

**Expected Answer Guidance:** If yes, specify which entities need translation (products, categories, system lookups) and which languages must be supported.

---

### Question 10.6: Historical Data & Change Tracking

**Question:** Beyond audit_logs, do you need to track complete change history for entities (e.g., price change history, product attribute changes over time)?

**Related Feature:** Báo cáo & Phân tích - historical analysis

**Question Type:** Multiple-choice

**Options:**

- Current audit_logs table is sufficient
- Add temporal tables (system versioning) for key entities
- Add specific history tables for price/cost tracking

**Expected Answer Guidance:** Identify which entities need queryable history (not just audit logs) and retention requirements.

---

## Section 11: Performance & Scalability

### Question 11.1: Expected Data Volume

**Question:** What is the expected scale of operations? (number of SKUs, daily transactions, number of warehouses, concurrent users)

**Related Feature:** General scalability planning

**Question Type:** Open-ended

**Expected Answer Guidance:** Provide estimates for: SKU count, daily transactions (in/out), batch records per year, number of organizations/branches, concurrent users, and growth projections for 1-3 years.

---

### Question 11.2: Query Performance Priorities

**Question:** Which queries are most critical for performance? (real-time inventory lookups, picking list generation, report generation, barcode scanning validation)

**Related Feature:** Overall system performance

**Question Type:** Open-ended

**Expected Answer Guidance:** Rank query types by importance and acceptable response times. This will guide indexing strategy and potential denormalization decisions.

---

### Question 11.3: Data Archival Strategy

**Question:** Should historical data (old transactions, completed orders, old batches) be archived to separate tables or databases after a certain period?

**Related Feature:** Long-term data management

**Question Type:** Multiple-choice

**Options:**

- Keep all data in operational tables indefinitely
- Archive data older than X months to archive tables
- Move old data to separate analytics database

**Expected Answer Guidance:** Consider regulatory retention requirements, query performance impact, and backup/restore implications.

---

## Completion Checklist

After reviewing and answering these questions, you should have clarity on:

- [ ] All missing tables and relationships needed for feature completeness
- [ ] Specific data types and constraints for optimal data integrity
- [ ] Performance optimization strategies (indexing, partitioning, materialized views)
- [ ] Security and multi-tenancy approach
- [ ] Integration and extensibility requirements
- [ ] Audit and compliance capabilities
- [ ] Scalability and archival strategies

Please provide detailed answers to questions most relevant to your immediate implementation priorities.
