# Questionaire Answers

## 1

### 1.1

A: use normal ROP calculations: (Average daily sales x Lead time in days) + Safety stock

### 1.2

A: Yes - I do need a table to track outbound orders, should be similar to transfer_order_details table but is not internal.

### 1.3

A: Track detailed supplier performance (delivery times, quality ratings, price changes). Analytics tables should just be in the operational database.

## 2

### 2.1

A: Yes, expand support for multiple SKUs

### 2.2

A: It shouldn't as it is sufficent, type ids should be like PO_DRAFT, and PO_DRAFT can be used in a global lookup table key - PO_DRAFT | en | vi etc... Recommend db designs choices here as I am not sure whether this is a good approach.

### 2.3

A: Yes, I will be storing slightly compressed versions of images in blob, then store the url in db. It should have notes and single|multiple image support.

## 3

### 3.1

A: each Storage map will contain: warehouse floor (overall dimensions), zones (coordinates, type), shelves/racks (location, size, capacity), hierarchy levels (shelf > tier > bin), and special zones (receiving, packing areas).

### 3.2

A: Current ltree path in storage_zones is sufficient

### 3.3

A: Pick Frequency, product dimensions, zone temperature requirements, proximity to packing area will do for now.

### 3.4

A: temperature, humidity, maximum weight, weight distribution will do for now.

### 3.5

A: Store only zone/shelf positions; calculate routes in application layer. storage zone maps should be editable for now.

## 4

### 4.1

A: Most operations will need a document whether it is outbound, inbound, end of day/month/ etc.. checking list. so a unified table for these document is preferred as the 'Manager' role attribute can view finished documents and mark it as verified.

### 4.2

A: my application should only handle until an outbound document is verified, no need to manage after that stage.

### 4.3

A: temperature sensitivity, stacking limits should do for now.

### 4.4

A: do need to track picking sessions( time per pick and products picked is enough for now).

## 5

### 5.1

A: Batch tracking granularity is for (i think) batch return if the batch is faulty, expired, etc.., i still need to track invididual items amount, batches allows for batch retrieval so i think it is nice to keep (feel free to recommend anything here).

### 5.2

A: this should be configurable per product category, default should be 2 months. we do need a notification table, notification should have 2 types (global for whole workspace, and personally for only the recipient)

### 5.3

A: yes, but it should be grouped into a work_session type table handling inbound check session, outbound, etc..., the sessions should all be created self by users.

### 5.4

A: as per the above answer about this matter, the count session document should result in WARN: discrepancies found or something like that. Then an inventory adjustment request is spawned with template reasons or a custom reason.

## 6

### 6.1

A: return reason, condition, credit expected, the return workflow is finished after return request is verified, no need after that. should of course update inventory levels accordingly

### 6.2

A: It should just be removed immediately after return request is confirmed (by internal workers) for now.

## 7

### 7.1

A: Store user-defined report templates and parameters

### 7.2

A: yes

### 7.3

A: this feature can skipped for now

### 7.4

A: Core features to prioritize
Serialized and batch tracking: This is crucial for tracking products with different expiration dates, warranty periods, or quality control needs.
Serial numbers: For individual high-value items (e.g., electronics, large equipment).
Batch or lot numbers: For perishable goods, pharmaceuticals, or items that arrive in specific production lots.
Customizable product fields and tagging: An effective system must allow you to create your own fields to capture unique information for any product type, such as size, color, weight, or expiration date.
Unit-of-Measure (UOM) conversion: The software should be able to convert units to handle products sold in different formats. For example, converting a received batch of raw materials into individual items for sale.
Multi-location and multi-warehouse support: If you store different product types in different locations (e.g., cold storage for perishables, a standard warehouse for dry goods), the software must be able to manage them all from a single dashboard.
Advanced reporting and analytics: a system that can generate detailed reports on inventory performance, turnover, and cost, which is essential for managing diverse inventory.
Barcode and RFID scanning: Modern, versatile systems use barcodes or QR codes for fast, accurate tracking. For higher-value, harder-to-scan items, some systems also support radio-frequency identification (RFID).
Demand forecasting: A good system will use historical data to help you forecast demand across different product lines, which is especially challenging with varied inventory.

## 8

### 8.1

A: the text part of the code is generated on the backend by the Workspace admin, or a shortened 12 character separated by dashes every 4 chars. stored on the same table - maybe like workspace_invititations. Admin can refresh code, pick code validity duration, or delete it. QR code is generated by the text part on the frontend.

### 8.2

A: Yes, and implement it bitwise too. permissions should be easy to add and remove in code in development.

### 8.3

A: Hybrid - some permissions global, others branch-specific

### 8.4

A: there should be a set of predefined roles for demonstrating sake, admins can also use it or base on those to create new specialized roles.

## 9

### 9.1

A: for this matter, enlighten me what is the recommended way.

### 9.2

A: Can freely use jsonb in places that would introduce flexibility and extensible

### 9.3

A: Shared schema with organization_id filtering (current approach).

### 9.4

A: on this matter, use your recommendations.

## 10

### 10.1

A: no need, mobile scanning is just the web interface on mobile that need camera usage on a pop up.

### 10.2

A: yes as notification table is mentioned in above answers. For now in-app delivery is sufficent.

### 10.3

A: Generic workflow engine with states and transitions.

### 10.4

A: it would be best to design in a integratable way, but not for now handle the tables of this matter

### 10.5

A: UI elements do need localization, but the data stored does not.

### 10.6

A: we do need price change history, or product edits history. all should just be a comprehensive audit log table with old_value and new_value.

## 11

### 11.1

A: this is mostly for a university course project, so scale of operations of 100s is fine.

## 11.2

A: notice that the real-time part only means the ui is updated as soon as a workflow is marked as verified (the final state of documents), there should be an live auditlog table to view (pending) workflows that live update to verified.

### 11.3

A: Archive data older than X months to archive tables.
