# Follow up questions answer

## 1

### 1.1

A:

- member with the corresponding permission attribute can create outbound order.
- outbound order wont be triggered automatically, member need to create them
- no

### 1.2

A:

- we do track delivery status, but only basic for internal transfer and same for external transfer.
- tracking number is ok
- yes

## 2

### 2.1

A:

- these will do: Receiving sessions, picking sessions, packing sessions, cycle count sessions, return processing sessions.
- yes, session_id, user_id, start_time, end_time, status, branch_id
- items scanned, discrepancies found

### 2.2

A:

- yes an attribute will be defined for this matter.
- yes but only on the status, document will be created by member again. (no rework tracking)
- just store them as that state and for rejections (a general reason is needed)

### 2.3

A:

- no only after document reaches the finished state waiting for confirmation, or like after member submit the scanned amount.
- no need
- no need
- no

## 3

### 3.1 & 3.2

A: localization I will handle in the frontend using i18n so no database storing needed, system lookup is still kept for other stuff.

## 4

### 4.1

- yes but not created automatically, user will see a discrepancies warning with "create adjustment request" button. like that
- configurable, inventory administrator for all inventory related permissions etc...
- Cycle count variance, damage, theft, data entry error, expiry. these will do, remember all enum type in database should be a key like format like CCVARIANCE, DAMAGE, the front end will use the keys to find translations for them.

### 4.2

- yes
- no
- yes
- yes

## 5

## 5.1

A: in our own inventory, serialized tracking. the batch tracking is only for tracking in which batch from the provider did the product come in with for easy retrieval.

### 5.2

A:

- yes
- yes
- yes
- yes
- yes
- no
- no
- no

## 6

### 6.1

A: yes an attachments table is nice

### 6.2

A: PO, work sessions, adjustment requests, return requests, products, all are optional but should be required in some critical forms.

## 7

### 7.1

A: yes should have notification categories. Expiry warnings, low stock, pending approvals, session completion, errors will do for now.

the structure works well!

### 7.2

- category setting table
- yes multiple warning levels

## 8

### 8.1

A: the structure is very fine!

### 8.2

A: listed examples works well!

## 9

### 9.1

A:

- yes custom fields is defined per organization/workspace.
- they should be typed.
- a product_type_template or something like that.
- Jsonb in the above product_type_template table.

### 9.2

A: should handle at the lowest unit level, with inbound calculation in notes field. note:" 1 case = A units. 12 case x A = B"

## 10

### 10.1

A: yes

### 10.2

A: All of the above with role based viewing levels

### 10.3

A: All of the above

## 11

### 11.1

A:

- store forecast data so projection chart can be overlayed with multiple projections
- last 3 months, configurable in settings
- weekly, configurable in settings
- seasonal adjustments

### 11.2

- Auto-calculate ROP based on sales history
- Alert when current stock reaches ROP

## 12

### 12.1

A: this will do

### 12.2

A: multiple include support

### 12.3

A: Defective, Expired, Damaged, Wrong Item, Excess Stock, Other will do, most other field will require user to input reason, cant leave blank

## 13

### 13.1

A: ive changed my mind, archiving will be looked into in the future, skip for now

## 14

### 14.1

A:

- Add/remove/move zones
- Resize zones
- Change storage rack attributes
- Reorganize shelf positions, dragging, rotate.
- not needed now

### 14.2

A:

- Block deletion if not empty.

## 15

### 15.1

A: yes these will do

### 15.2

A: this works fine

- Store: Total time, items picked, accuracy
- Calculate on-demand: Items per hour, average pick time

## R1

- Approach A

## R2

- it fits nicely!
