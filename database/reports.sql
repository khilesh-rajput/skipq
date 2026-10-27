USE skipq;
-- Sales by canteen and day
SELECT c.name,DATE(o.created_at) order_day,COUNT(*) orders,SUM(o.total_amount) gross FROM orders o JOIN canteens c USING(canteen_id) WHERE o.order_status NOT IN('CANCELLED','REJECTED') GROUP BY c.canteen_id,DATE(o.created_at) ORDER BY order_day DESC;
-- Order history for one student
SELECT o.order_number,c.name,o.pickup_at,o.total_amount,o.order_status,o.payment_status FROM orders o JOIN canteens c USING(canteen_id) WHERE o.customer_id=? ORDER BY o.created_at DESC;
-- Popular items
SELECT oi.item_name,SUM(oi.quantity) quantity_sold FROM order_items oi JOIN orders o USING(order_id) WHERE o.order_status='COLLECTED' GROUP BY oi.item_id,oi.item_name ORDER BY quantity_sold DESC LIMIT 10;
-- Daily paid revenue
SELECT DATE(created_at) day,SUM(total_amount) revenue FROM orders WHERE payment_status='PAID' GROUP BY DATE(created_at) ORDER BY day DESC;
-- Canteen-wise order counts
SELECT c.name,COUNT(o.order_id) order_count FROM canteens c LEFT JOIN orders o USING(canteen_id) GROUP BY c.canteen_id,c.name;
