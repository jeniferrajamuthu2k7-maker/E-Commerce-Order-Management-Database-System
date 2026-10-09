USE inventory_db;

-- =========================================================
-- WEEK 10: ADVANCED SQL QUERY SYSTEM
-- SUBQUERIES AND NESTED QUERIES
-- =========================================================

-- =========================================================
-- 1. PRODUCTS COSTING MORE THAN AVERAGE
-- Single-Row Subquery
-- =========================================================

SELECT
Product_Name,
Price
FROM products
WHERE Price > (
SELECT AVG(Price)
FROM products
)
ORDER BY Price DESC;

-- =========================================================
-- 2. CUSTOMERS WITH ORDERS ABOVE ₹5,000
-- Multi-Row Subquery
-- =========================================================

SELECT
Customer_ID,
Customer_Name,
City
FROM customers
WHERE Customer_ID IN (
SELECT Customer_ID
FROM orders
WHERE Total_Amount > 5000
AND Order_Status <> 'Cancelled'
);

-- =========================================================
-- 3. AVERAGE SPENDING PER CUSTOMER
-- Nested Subquery
-- =========================================================

SELECT
ROUND(AVG(Total_Spending), 2) AS Average_Customer_Spending
FROM (
SELECT
Customer_ID,
SUM(Total_Amount) AS Total_Spending
FROM orders
WHERE Order_Status <> 'Cancelled'
GROUP BY Customer_ID
) AS CustomerSummary;

-- =========================================================
-- 4. PRODUCTS ABOVE THEIR CATEGORY AVERAGE
-- Correlated Subquery
-- =========================================================

SELECT
p.Product_Name,
c.Category_Name,
p.Price
FROM products p
JOIN categories c
ON p.Category_ID = c.Category_ID
WHERE p.Price > (
SELECT AVG(p2.Price)
FROM products p2
WHERE p2.Category_ID = p.Category_ID
)
ORDER BY c.Category_Name, p.Price DESC;

-- =========================================================
-- 5. PRODUCTS ABOVE A SELECTED CATEGORY AVERAGE
-- Example: Electronics
-- =========================================================

SELECT
p.Product_Name,
c.Category_Name,
p.Price
FROM products p
JOIN categories c
ON p.Category_ID = c.Category_ID
WHERE c.Category_Name = 'Electronics'
AND p.Price > (
SELECT AVG(p2.Price)
FROM products p2
WHERE p2.Category_ID = p.Category_ID
);

-- =========================================================
-- 6. CUSTOMER WITH THE HIGHEST SPENDING
-- Nested Subquery
-- =========================================================

SELECT
c.Customer_ID,
c.Customer_Name,
SUM(o.Total_Amount) AS Total_Spending
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY c.Customer_ID, c.Customer_Name
HAVING SUM(o.Total_Amount) = (
SELECT MAX(Customer_Spending)
FROM (
SELECT
Customer_ID,
SUM(Total_Amount) AS Customer_Spending
FROM orders
WHERE Order_Status <> 'Cancelled'
GROUP BY Customer_ID
) AS SpendingSummary
);

-- =========================================================
-- 7. CUSTOMERS WITH THE MOST ORDERS
-- =========================================================

SELECT
c.Customer_ID,
c.Customer_Name,
COUNT(o.Order_ID) AS Total_Orders
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY c.Customer_ID, c.Customer_Name
HAVING COUNT(o.Order_ID) = (
SELECT MAX(Order_Count)
FROM (
SELECT
Customer_ID,
COUNT(Order_ID) AS Order_Count
FROM orders
WHERE Order_Status <> 'Cancelled'
GROUP BY Customer_ID
) AS OrderSummary
);

-- =========================================================
-- 8. CUSTOMERS SPENDING ABOVE THE AVERAGE
-- =========================================================

SELECT
c.Customer_Name,
SUM(o.Total_Amount) AS Total_Spending
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY c.Customer_ID, c.Customer_Name
HAVING SUM(o.Total_Amount) > (
SELECT AVG(Customer_Spending)
FROM (
SELECT
Customer_ID,
SUM(Total_Amount) AS Customer_Spending
FROM orders
WHERE Order_Status <> 'Cancelled'
GROUP BY Customer_ID
) AS AverageSummary
)
ORDER BY Total_Spending DESC;

-- =========================================================
-- 9. TOP 5 VALUABLE CUSTOMERS
-- =========================================================

SELECT
c.Customer_ID,
c.Customer_Name,
COUNT(o.Order_ID) AS Total_Orders,
SUM(o.Total_Amount) AS Total_Spending
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Spending DESC
LIMIT 5;

-- =========================================================
-- 10. BEST-SELLING PRODUCT
-- Maximum quantity sold
-- =========================================================

SELECT
p.Product_Name,
SUM(od.Quantity) AS Quantity_Sold,
SUM(od.Quantity * od.Price) AS Total_Revenue
FROM products p
JOIN order_details od
ON p.Product_ID = od.Product_ID
JOIN orders o
ON od.Order_ID = o.Order_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY p.Product_ID, p.Product_Name
HAVING SUM(od.Quantity) = (
SELECT MAX(Product_Quantity)
FROM (
SELECT
od2.Product_ID,
SUM(od2.Quantity) AS Product_Quantity
FROM order_details od2
JOIN orders o2
ON od2.Order_ID = o2.Order_ID
WHERE o2.Order_Status <> 'Cancelled'
GROUP BY od2.Product_ID
) AS ProductSummary
);

-- =========================================================
-- 11. CATEGORY PERFORMANCE ANALYSIS
-- =========================================================

SELECT
c.Category_Name,
SUM(od.Quantity) AS Total_Products_Sold,
SUM(od.Quantity * od.Price) AS Category_Revenue,
AVG(p.Price) AS Average_Product_Price
FROM categories c
JOIN products p
ON c.Category_ID = p.Category_ID
JOIN order_details od
ON p.Product_ID = od.Product_ID
JOIN orders o
ON od.Order_ID = o.Order_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY c.Category_ID, c.Category_Name
ORDER BY Category_Revenue DESC;

-- =========================================================
-- 12. HIGHEST REVENUE-GENERATING CATEGORY
-- =========================================================

SELECT
c.Category_Name,
SUM(od.Quantity * od.Price) AS Total_Revenue
FROM categories c
JOIN products p
ON c.Category_ID = p.Category_ID
JOIN order_details od
ON p.Product_ID = od.Product_ID
JOIN orders o
ON od.Order_ID = o.Order_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY c.Category_ID, c.Category_Name
HAVING SUM(od.Quantity * od.Price) = (
SELECT MAX(Category_Total)
FROM (
SELECT
p2.Category_ID,
SUM(od2.Quantity * od2.Price) AS Category_Total
FROM products p2
JOIN order_details od2
ON p2.Product_ID = od2.Product_ID
JOIN orders o2
ON od2.Order_ID = o2.Order_ID
WHERE o2.Order_Status <> 'Cancelled'
GROUP BY p2.Category_ID
) AS CategorySummary
);

-- =========================================================
-- 13. CUSTOMER PURCHASE HISTORY
-- Includes most purchased product
-- =========================================================

SELECT
c.Customer_Name,
COUNT(DISTINCT o.Order_ID) AS Total_Orders,
SUM(o.Total_Amount) AS Total_Purchase_Amount,
(
SELECT p2.Product_Name
FROM order_details od2
JOIN products p2
ON od2.Product_ID = p2.Product_ID
JOIN orders o2
ON od2.Order_ID = o2.Order_ID
WHERE o2.Customer_ID = c.Customer_ID
AND o2.Order_Status <> 'Cancelled'
GROUP BY p2.Product_ID, p2.Product_Name
ORDER BY SUM(od2.Quantity) DESC
LIMIT 1
) AS Most_Purchased_Product
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Purchase_Amount DESC;

-- =========================================================
-- REPORT 1: PREMIUM PRODUCT REPORT
-- =========================================================

SELECT
p.Product_Name,
c.Category_Name,
p.Price,
p.Stock_Quantity AS Stock_Availability
FROM products p
JOIN categories c
ON p.Category_ID = c.Category_ID
WHERE p.Price > (
SELECT AVG(Price)
FROM products
)
ORDER BY p.Price DESC;

-- =========================================================
-- REPORT 2: CUSTOMER VALUE REPORT
-- =========================================================

SELECT
c.Customer_Name,
COUNT(o.Order_ID) AS Total_Orders,
SUM(o.Total_Amount) AS Total_Spending,
CASE
WHEN SUM(o.Total_Amount) >= 100000
THEN 'Premium'
WHEN SUM(o.Total_Amount) >= 50000
THEN 'High Value'
ELSE 'Regular'
END AS Customer_Category
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Spending DESC;

-- =========================================================
-- REPORT 3: PRODUCT-WISE SALES AND CATEGORY REVENUE
-- =========================================================

SELECT
p.Product_Name,
c.Category_Name,
SUM(od.Quantity) AS Quantity_Sold,
SUM(od.Quantity * od.Price) AS Product_Revenue,
(
SELECT SUM(od2.Quantity * od2.Price)
FROM products p2
JOIN order_details od2
ON p2.Product_ID = od2.Product_ID
JOIN orders o2
ON od2.Order_ID = o2.Order_ID
WHERE p2.Category_ID = p.Category_ID
AND o2.Order_Status <> 'Cancelled'
) AS Category_Revenue
FROM products p
JOIN categories c
ON p.Category_ID = c.Category_ID
JOIN order_details od
ON p.Product_ID = od.Product_ID
JOIN orders o
ON od.Order_ID = o.Order_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY
p.Product_ID,
p.Product_Name,
c.Category_ID,
c.Category_Name
ORDER BY Product_Revenue DESC;

-- =========================================================
-- REPORT 4: BUSINESS DECISION REPORT
-- High and low-performing products
-- =========================================================

SELECT
'High-Performing Product' AS Decision_Type,
p.Product_Name AS Item,
SUM(od.Quantity) AS Quantity_Sold,
SUM(od.Quantity * od.Price) AS Amount
FROM products p
JOIN order_details od
ON p.Product_ID = od.Product_ID
JOIN orders o
ON od.Order_ID = o.Order_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY p.Product_ID, p.Product_Name
HAVING SUM(od.Quantity) > (
SELECT AVG(Product_Quantity)
FROM (
SELECT
SUM(od2.Quantity) AS Product_Quantity
FROM order_details od2
JOIN orders o2
ON od2.Order_ID = o2.Order_ID
WHERE o2.Order_Status <> 'Cancelled'
GROUP BY od2.Product_ID
) AS ProductAverage
)

UNION ALL

SELECT
'Low-Performing Product' AS Decision_Type,
p.Product_Name AS Item,
SUM(od.Quantity) AS Quantity_Sold,
SUM(od.Quantity * od.Price) AS Amount
FROM products p
JOIN order_details od
ON p.Product_ID = od.Product_ID
JOIN orders o
ON od.Order_ID = o.Order_ID
WHERE o.Order_Status <> 'Cancelled'
GROUP BY p.Product_ID, p.Product_Name
HAVING SUM(od.Quantity) < (
SELECT AVG(Product_Quantity)
FROM (
SELECT
SUM(od2.Quantity) AS Product_Quantity
FROM order_details od2
JOIN orders o2
ON od2.Order_ID = o2.Order_ID
WHERE o2.Order_Status <> 'Cancelled'
GROUP BY od2.Product_ID
) AS ProductAverage
)

ORDER BY Amount DESC;
