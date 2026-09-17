USE inventory_db;

SELECT *
FROM customers;

SELECT *
FROM products;

SELECT product_name, price
FROM products;

SELECT *
FROM orders;

SELECT *
FROM payment;

SELECT *
FROM review;

SELECT
    product_name,
    price,
    stock_quantity,
    CASE
        WHEN stock_quantity > 0 THEN 'Available'
        ELSE 'Out of Stock'
    END AS availability_status
FROM products
ORDER BY product_name;
SELECT COUNT(*) AS total_customers
FROM customers;
SELECT
    product_name,
    price,
    stock_quantity,
    CASE
        WHEN stock_quantity > 0 THEN 'Available'
        ELSE 'Out of Stock'
    END AS availability_status
FROM products
ORDER BY product_name;

SELECT
    COUNT(*) AS total_orders
FROM orders;

SELECT
    p.product_id,
    p.product_name,
    p.price,
    p.stock_quantity,
    COUNT(od.order_detail_id) AS times_ordered,
    COALESCE(SUM(od.quantity), 0) AS total_quantity_sold
FROM products p
LEFT JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.price,
    p.stock_quantity
ORDER BY total_quantity_sold DESC;
