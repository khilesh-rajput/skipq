# Database design and DBMS viva notes

## Relationships

`users 1?N orders`; `users M?N canteens` through `staff_canteens`; `canteens 1?N menu_items`, `pickup_slots`, and `orders`; `categories 1?N menu_items`; `orders 1?N order_items`; `menu_items 1?N order_items`; `orders 1?0..1 payments`; `users/orders/menu_items 1?N reviews` under a unique user-order-item rule. Audit and webhook tables record operational events.

`order_items` is associative because an order contains many menu items and a menu item appears in many orders. It also carries quantity and price at purchase. `unit_price` is a historical snapshot: changing today's menu price must not rewrite old receipts.

## Keys, dependencies, normalization

Primary keys are surrogate integer ids. Candidate keys include user email, canteen name, order number, `(canteen_id,slot_at)`, `(order_id,item_id)`, and `(customer_id,order_id,item_id)` for reviews. Foreign keys preserve references. Typical dependencies: `user_id ? full_name,email,phone,password_hash,role`; `item_id ? canteen_id,category_id,name,price,...`; `order_id ? order_number,customer_id,canteen_id,pickup_at,...`. Separate users, menu, categories, orders, lines, payments, and assignments avoid repeating facts, and attributes depend on their whole key, satisfying the practical 3NF design. Order item name/price are deliberate immutable historical snapshots.

Indexes target unique login/order lookups, staff assignments, menu filtering by canteen/availability/category, order history by owner/date, staff queue by canteen/status/time, and slot lookups. Money uses DECIMAL. Checks and foreign keys guard basic invariants; services enforce cross-row business rules.

## Transactions and ACID

Order booking uses InnoDB transaction locks on the exact slot and stock rows. Atomic validation-plus-reservation prevents concurrent overselling/capacity overbooking. Rollback restores every write on error. Payment state is separate and linked by a unique order id. Webhook event id primary key prevents duplicate event processing.

## Viva questions

- Why MySQL? Mature relational constraints, transactions, joins and broad tooling suit structured order workflows.
- Why snapshot price? To preserve receipt history when menu prices later change.
- Why transaction? Inventory, capacity, order and lines must succeed or fail together.
- How prevent overbooking? Lock slot/stock rows with `FOR UPDATE`, check remaining capacity, reserve before commit.
- What is 3NF? Non-key attributes depend on the key, the whole key, and nothing but the key.
- What is an associative entity? A relation resolving many-to-many with its own attributes; `order_items` stores quantity and purchase price.
- Why indexes? Reduce scans on frequent joins/filters, at the cost of storage and write work.
- Why prepared statements? Values are bound separately from SQL syntax, reducing injection risk.
