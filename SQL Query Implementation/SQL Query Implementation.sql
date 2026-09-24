USE inventory_db;

-- TASK 1: PERFORM BASIC SQL QUERIES
-- 1. Display all customer details
SELECT *
FROM customers;

-- 2. Display all available products
SELECT *
FROM products
WHERE stock_quantity > 0;

-- 3. Retrieve product names and prices only
SELECT product_name, price
FROM products;

-- 4. Display all orders placed by customers
SELECT *
FROM orders;

-- 5. Retrieve payment details
SELECT *
FROM payment;


-- TASK 2: APPLY FILTERING CONDITIONS USING WHERE
-- 1. Find products with price greater than ₹5000
SELECT product_name, price
FROM products
WHERE price > 5000;

-- 2. Display products available in stock
SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity > 0;

-- 3. Find customers from Chennai
SELECT *
FROM customers
WHERE City = 'Chennai';

-- 4. Display completed orders
SELECT *
FROM orders
WHERE Order_Status = 'Delivered';

-- 5. Find products with rating above 4
SELECT
    p.product_name,
    r.rating
FROM products p
JOIN review r
ON p.product_id = r.product_id
WHERE r.rating > 4;


-- TASK 3: SORT DATA USING ORDER BY
-- 1. Display products from lowest to highest price
SELECT *
FROM products
ORDER BY price ASC;

-- 2. Display customers alphabetically
SELECT *
FROM customers
ORDER BY Customer_Name ASC;

-- 3. Find top expensive products
SELECT
    product_name,
    price
FROM products
ORDER BY price DESC;

-- 4. Display latest orders first
SELECT *
FROM orders
ORDER BY Order_Date DESC;


-- TASK 4: RETRIEVE UNIQUE VALUES USING DISTINCT
-- 1. Display unique product categories
SELECT DISTINCT category_id
FROM products;

-- 2. Find different payment methods used by customers
SELECT DISTINCT Payment_Mode
FROM payment;

-- 3. Display unique customer locations
SELECT DISTINCT City
FROM customers;


-- TASK 5: SEARCH PRODUCTS BASED ON CONDITIONS
-- PRODUCT SEARCH REPORT
-- 1. Find products between ₹1000 and ₹5000
SELECT
    product_name,
    price
FROM products
WHERE price BETWEEN 1000 AND 5000;

-- 2. Display products belonging to Electronics category
SELECT
    product_name,
    category_id
FROM products
WHERE category_id = 1;

-- 3. Find products currently available in inventory
SELECT
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity > 0;

-- 4. Search products using product name
-- Searches for products containing "Wireless"
SELECT *
FROM products
WHERE product_name LIKE '%Wireless%';

-- 5. Find low-stock products
SELECT
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity < 30;


-- TASK 6: RETRIEVE CUSTOMER AND PRODUCT INFORMATION
-- CUSTOMER INFORMATION REPORT
-- 1. Display customer details with their orders
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Email,
    o.Order_ID,
    o.Order_Date,
    o.Total_Amount,
    o.Order_Status
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID;

-- 2. Display product details with category information
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock_quantity
FROM products p
JOIN categories c
ON p.category_id = c.category_id;

-- 3. Find customers who purchased a specific product
SELECT DISTINCT
    c.Customer_ID,
    c.Customer_Name,
    p.product_name
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID
JOIN order_details od
ON o.Order_ID = od.Order_ID
JOIN products p
ON od.Product_ID = p.product_id
WHERE p.product_name = 'Wireless Mouse';

-- 4. Display products purchased by each customer
SELECT
    c.Customer_Name,
    p.product_name,
    od.Quantity,
    od.Price
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID
JOIN order_details od
ON o.Order_ID = od.Order_ID
JOIN products p
ON od.Product_ID = p.product_id
ORDER BY c.Customer_Name;


-- TASK 7: APPLY MULTIPLE FILTERING CONDITIONS
-- 1. Find electronics products costing more than ₹10000
SELECT
    p.product_name,
    c.category_name,
    p.price
FROM products p
JOIN categories c
ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics'
AND p.price > 10000;

-- 2. Find customers from Chennai or Bangalore
SELECT *
FROM customers
WHERE city IN ('Chennai', 'Bangalore');

-- 3. Search products containing the word "Mobile"
SELECT *
FROM products
WHERE product_name LIKE '%Mobile%';

-- 4. Find orders placed within a specific date range
SELECT *
FROM orders
WHERE Order_Date BETWEEN '2026-08-20'
AND '2026-08-23 23:59:59';


-- TASK 8: GENERATE BASIC BUSINESS REPORTS

-- REPORT 1: PRODUCT AVAILABILITY REPORT
SELECT
    product_name,
    price,
    stock_quantity,
    CASE
        WHEN stock_quantity > 0 THEN 'Available'
        ELSE 'Out of Stock'
    END AS Availability_Status
FROM products;


-- REPORT 2: CUSTOMER REPORT
SELECT
    Customer_ID,
    Customer_Name,
    City,
    Email,
    (SELECT COUNT(*) FROM customers) AS Total_Customers
FROM customers
ORDER BY City, Customer_Name;


-- REPORT 3: ORDER REPORT
SELECT
    COUNT(*) AS Total_Orders,
    SUM(CASE
        WHEN Order_Status = 'Delivered'
        THEN 1 ELSE 0
    END) AS Completed_Orders,
    SUM(CASE
        WHEN Order_Status = 'Pending'
        THEN 1 ELSE 0
    END) AS Pending_Orders,
    SUM(CASE
        WHEN Order_Status = 'Cancelled'
        THEN 1 ELSE 0
    END) AS Cancelled_Orders
FROM orders;


-- REPORT 4: PRODUCT PERFORMANCE REPORT
SELECT
    p.product_name,
    p.price,
    COUNT(r.review_id) AS Number_of_Reviews,
    p.stock_quantity,
    CASE
        WHEN p.stock_quantity > 0
        THEN 'Available'
        ELSE 'Out of Stock'
    END AS Availability_Status
FROM products p
LEFT JOIN review r
ON p.product_id = r.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.price,
    p.stock_quantity
ORDER BY
    p.price DESC,
    Number_of_Reviews DESC;