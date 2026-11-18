-- 1. VIEWS
-- 1.1 Customer Order Report
CREATE OR REPLACE VIEW Customer_Order_Report AS
SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Order_Date,
    o.Total_Amount,
    o.Order_Status
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID;

-- 1.2 Product Sales Report
CREATE OR REPLACE VIEW Product_Sales_Report AS
SELECT
    p.Product_Name,
    SUM(od.Quantity) AS Quantity_Sold,
    SUM(od.Quantity * od.Price) AS Total_Revenue
FROM products p
JOIN order_details od
ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name;

-- 1.3 Payment Status Report
CREATE OR REPLACE VIEW Payment_Status_Report AS
SELECT
    Order_ID,
    Payment_Mode,
    Payment_Status,
    Transaction_Amount
FROM payment;

-- 2. STORED PROCEDURES

DELIMITER //

-- 2.1 Add New Customer Order
DROP PROCEDURE IF EXISTS Add_New_Order //

CREATE PROCEDURE Add_New_Order(
    IN Cust_ID INT,
    IN Prod_ID INT,
    IN Qty INT,
    IN Pay_Mode VARCHAR(30)
)
BEGIN
    DECLARE New_Order_ID INT;
    DECLARE Product_Price DECIMAL(10,2);
    DECLARE Total DECIMAL(10,2);
    DECLARE Available_Stock INT;

    SELECT Price, Stock_Quantity
    INTO Product_Price, Available_Stock
    FROM products
    WHERE Product_ID = Prod_ID;

    IF Available_Stock IS NULL OR Available_Stock < Qty OR Qty <= 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid product or insufficient stock';

    ELSE

        SET Total = Product_Price * Qty;

         INSERT INTO orders
        (Customer_ID, Total_Amount, Order_Status)
        VALUES
        (Cust_ID, 0, 'Pending');

        SET New_Order_ID = LAST_INSERT_ID();

        INSERT INTO order_details
        (Order_ID, Product_ID, Quantity, Price)
        VALUES
        (New_Order_ID, Prod_ID, Qty, Product_Price);

        UPDATE products
        SET Stock_Quantity = Stock_Quantity - Qty
        WHERE Product_ID = Prod_ID;

        UPDATE orders
        SET Total_Amount = Total
        WHERE Order_ID = New_Order_ID;

        INSERT INTO payment
        (Order_ID, Payment_Mode, Payment_Status, Transaction_Amount)
        VALUES
        (New_Order_ID, Pay_Mode, 'Pending', Total);

    END IF;
END //


-- 2.2 Update Order Status
DROP PROCEDURE IF EXISTS Update_Order_Status //

CREATE PROCEDURE Update_Order_Status(
    IN O_ID INT,
    IN New_Status VARCHAR(30)
)
BEGIN
    UPDATE orders
    SET Order_Status = New_Status
    WHERE Order_ID = O_ID;
END //


-- 2.3 Customer Purchase History
DROP PROCEDURE IF EXISTS Get_Customer_History //

CREATE PROCEDURE Get_Customer_History(
    IN Cust_ID INT
)
BEGIN
    SELECT
        Order_ID,
        Order_Date,
        Total_Amount,
        Order_Status
    FROM orders
    WHERE Customer_ID = Cust_ID;
END //


-- 2.4 Increase Product Stock
DROP PROCEDURE IF EXISTS Add_Product_Stock //

CREATE PROCEDURE Add_Product_Stock(
    IN Prod_ID INT,
    IN Qty INT
)
BEGIN
    UPDATE products
    SET Stock_Quantity = Stock_Quantity + Qty
    WHERE Product_ID = Prod_ID;
END //

DELIMITER ;

-- 3. FUNCTIONS

DELIMITER //

-- 3.1 Calculate Total Sales
DROP FUNCTION IF EXISTS Calculate_Total_Sales //

CREATE FUNCTION Calculate_Total_Sales(
    Start_Date DATE,
    End_Date DATE
)
RETURNS DECIMAL(10,2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE Total DECIMAL(10,2);

    SELECT IFNULL(SUM(Total_Amount), 0)
    INTO Total
    FROM orders
    WHERE Order_Date >= Start_Date
    AND Order_Date < DATE_ADD(End_Date, INTERVAL 1 DAY);

    RETURN Total;
END //


-- 3.2 Calculate Customer Spending
DROP FUNCTION IF EXISTS Customer_Total_Spending //

CREATE FUNCTION Customer_Total_Spending(
    Cust_ID INT
)
RETURNS DECIMAL(10,2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE Total DECIMAL(10,2);

    SELECT IFNULL(SUM(Total_Amount), 0)
    INTO Total
    FROM orders
    WHERE Customer_ID = Cust_ID;

    RETURN Total;
END //


-- 3.3 Calculate Product Revenue
DROP FUNCTION IF EXISTS Product_Revenue //

CREATE FUNCTION Product_Revenue(
    Prod_ID INT
)
RETURNS DECIMAL(10,2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE Total DECIMAL(10,2);

    SELECT IFNULL(SUM(Quantity * Price), 0)
    INTO Total
    FROM order_details
    WHERE Product_ID = Prod_ID;

    RETURN Total;
END //

DELIMITER ;

-- 4. AUTOMATION

-- 4.1 Low Stock Report
CREATE OR REPLACE VIEW Low_Stock_Report AS
SELECT
    Product_ID,
    Product_Name,
    Stock_Quantity,
    'Low Stock' AS Stock_Status
FROM products
WHERE Stock_Quantity <= 5;


-- 4.2 Daily Sales Report
CREATE OR REPLACE VIEW Daily_Sales_Report AS
SELECT
    DATE(Order_Date) AS Sales_Date,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Total_Amount) AS Daily_Revenue
FROM orders
GROUP BY DATE(Order_Date);


-- 4.3 Monthly Revenue Report
CREATE OR REPLACE VIEW Monthly_Revenue_Report AS
SELECT
    YEAR(Order_Date) AS Sales_Year,
    MONTH(Order_Date) AS Sales_Month,
    SUM(Total_Amount) AS Monthly_Revenue
FROM orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date);


-- 4.4 Customer Purchase Report
CREATE OR REPLACE VIEW Customer_Purchase_Report AS
SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Total_Amount
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;


-- 5. TEST VIEWS

SELECT * FROM Customer_Order_Report;
SELECT * FROM Product_Sales_Report;
SELECT * FROM Payment_Status_Report;
SELECT * FROM Low_Stock_Report;
SELECT * FROM Daily_Sales_Report;
SELECT * FROM Monthly_Revenue_Report;
SELECT * FROM Customer_Purchase_Report;


-- 6. TEST PROCEDURES

-- Add a new order
CALL Add_New_Order(1, 1, 2, 'UPI');

-- Update order status
CALL Update_Order_Status(1, 'Shipped');

-- Customer purchase history
CALL Get_Customer_History(1);

-- Increase product stock
CALL Add_Product_Stock(1, 10);

-- 7. TEST FUNCTIONS

SELECT Calculate_Total_Sales('2026-01-01', '2026-12-31');

SELECT Customer_Total_Spending(1);

SELECT Product_Revenue(1);

-- 8. VERIFY AUTOMATION

SELECT * FROM orders;

SELECT * FROM order_details;

SELECT * FROM payment;

SELECT
    Product_ID,
    Product_Name,
    Stock_Quantity
FROM products;

-- 1. CUSTOMER PURCHASE REPORT

CREATE OR REPLACE VIEW Customer_Purchase_Report AS
SELECT
    c.Customer_Name AS Customer,
    COUNT(o.Order_ID) AS Orders,
    SUM(o.Total_Amount) AS Amount
FROM customers c
JOIN orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;

SELECT * FROM Customer_Purchase_Report;

-- 2. SALES REPORT

CREATE OR REPLACE VIEW Sales_Report AS
SELECT
    p.Product_Name AS Product,
    SUM(od.Quantity) AS Quantity_Sold,
    SUM(od.Quantity * od.Price) AS Revenue
FROM products p
JOIN order_details od
ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name;

SELECT * FROM Sales_Report;

-- 3. INVENTORY REPORT

CREATE OR REPLACE VIEW Inventory_Report AS
SELECT
    Product_Name AS Product,
    Stock_Quantity AS Stock,
    CASE
        WHEN Stock_Quantity <= 5 THEN 'Low Stock'
        ELSE 'Available'
    END AS Status
FROM products;

SELECT * FROM Inventory_Report;