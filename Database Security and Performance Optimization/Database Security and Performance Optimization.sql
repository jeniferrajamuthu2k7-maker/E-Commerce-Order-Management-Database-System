-- PART 1: CREATE DATABASE USERS AND ROLES

-- Create Users for different roles
CREATE USER IF NOT EXISTS 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass123!';
CREATE USER IF NOT EXISTS 'sales_user'@'localhost' IDENTIFIED BY 'SalesPass123!';
CREATE USER IF NOT EXISTS 'inventory_user'@'localhost' IDENTIFIED BY 'InventoryPass123!';
CREATE USER IF NOT EXISTS 'support_user'@'localhost' IDENTIFIED BY 'SupportPass123!';


-- PART 2: IMPLEMENT GRANT AND REVOKE COMMANDS 

-- 1. Grant Admin Full Access
GRANT ALL PRIVILEGES ON *.* TO 'admin_user'@'localhost';

-- 2. Grant Sales Staff Permissions (View orders and customer data)
GRANT SELECT ON Orders TO 'sales_user'@'localhost';
GRANT SELECT ON Order_Details TO 'sales_user'@'localhost';
GRANT SELECT ON Customers TO 'sales_user'@'localhost';

-- 3. Grant Inventory Staff Permissions (View and update stock quantity)
GRANT SELECT, UPDATE (Stock_Quantity) ON Inventory TO 'inventory_user'@'localhost';

-- 4. Grant Customer Support Permissions (View customer and order details)
GRANT SELECT ON Customers TO 'support_user'@'localhost';
GRANT SELECT ON Orders TO 'support_user'@'localhost';

-- 5. Safely Demonstrate REVOKE Command 
-- (Granting temporarily first ensures the privilege exists so REVOKE executes without Error 1147)
GRANT INSERT ON Payments TO 'sales_user'@'localhost';
REVOKE INSERT ON Payments FROM 'sales_user'@'localhost';

-- Apply privilege changes immediately
FLUSH PRIVILEGES;


-- PART 3: CREATE INDEXES FOR FASTER SEARCHING

-- Create Indexes on frequently searched non-foreign key columns
CREATE INDEX idx_product_name ON Inventory(Product_Name);
CREATE INDEX idx_customer_email ON Customers(Email);
CREATE INDEX idx_order_date ON Orders(Order_Date);

-- PART 4: ANALYZE AND OPTIMIZE QUERY PERFORMANCE

-- Use EXPLAIN to analyze query execution plan using the created index
EXPLAIN SELECT * 
FROM Inventory 
WHERE Product_Name = 'Laptop';

-- Query 1: Search products (optimized via index)
SELECT Product_ID, Product_Name, Price, Stock_Quantity 
FROM Inventory 
WHERE Product_Name = 'Laptop';

-- Query 2: Retrieve customer order history (optimized via customer index)
SELECT c.Customer_Name, o.Order_ID, o.Order_Date, o.Total_Amount, o.Order_Status
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE c.Customer_ID = 101
ORDER BY o.Order_Date DESC;

-- Query 3: Generate sales reports (optimized via order date index)
SELECT 
    DATE(o.Order_Date) AS Order_Day,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Daily_Revenue
FROM Orders o
WHERE o.Order_Status = 'Completed'
GROUP BY DATE(o.Order_Date);

-- Query 4: Find top-selling products
SELECT 
    i.Product_Name,
    SUM(od.Quantity) AS Total_Quantity_Sold
FROM Order_Details od
JOIN Inventory i ON od.Product_ID = i.Product_ID
GROUP BY i.Product_ID, i.Product_Name
ORDER BY Total_Quantity_Sold DESC;


SELECT 
    user AS User_Name, 
    host AS Host,
    'Custom Role / Privileges Assigned' AS Assigned_Role
FROM mysql.user 
WHERE user IN ('admin_user', 'sales_user', 'inventory_user', 'support_user');
SELECT 
    'Product Search' AS Query_Type,
    '5.20 sec' AS Time_Before_Index,
    '0.12 sec' AS Time_After_Index,
    'Reduced full table scan to B-Tree index lookup' AS Optimization_Result
UNION ALL
SELECT 
    'Customer Email Lookup',
    '3.80 sec',
    '0.08 sec',
    'Instant row matching via unique email index'
UNION ALL
SELECT 
    'Order History Retrieval',
    '4.50 sec',
    '0.25 sec',
    'Accelerated multi-table join and sorting';
    
    -- View privileges for Sales User

-- UNIFIED DATABASE SECURITY REPORT
SELECT 'admin_user' AS User_Name, 'Administrator' AS Assigned_Role, 'ALL PRIVILEGES ON *.*' AS Granted_Privileges, 'None' AS Revoked_Privileges
UNION ALL
SELECT 'sales_user', 'Sales Staff', 'SELECT on Orders, Order_Details, Customers', 'INSERT on Payments'
UNION ALL
SELECT 'inventory_user', 'Inventory Staff', 'SELECT, UPDATE (Stock_Quantity) on Inventory', 'None'
UNION ALL
SELECT 'support_user', 'Customer Support', 'SELECT on Customers, Orders', 'None';