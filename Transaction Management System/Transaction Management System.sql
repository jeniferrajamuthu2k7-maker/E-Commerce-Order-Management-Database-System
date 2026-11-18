-- STEP 1: SAFE SCHEMA SETUP (Drops & Recreates Tables)

SET foreign_key_checks = 0;

DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Customers;

SET foreign_key_checks = 1;

-- 1. Customers Table
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100)
);

-- 2. Inventory / Products Table
CREATE TABLE Inventory (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Stock_Quantity INT NOT NULL CHECK (Stock_Quantity >= 0),
    Price DECIMAL(10, 2) NOT NULL
);

-- 3. Orders Table
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Total_Amount DECIMAL(10, 2),
    Order_Status VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- 4. Order_Details Table
CREATE TABLE Order_Details (
    Order_Detail_ID INT PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID)
);

-- 5. Payments Table
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT,
    Payment_Method VARCHAR(50),
    Payment_Status VARCHAR(50),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- Insert Initial Seed Data
INSERT INTO Customers VALUES (101, 'Rahul Sharma', 'rahul@example.com');
INSERT INTO Inventory VALUES (10, 'Laptop', 10, 55000.00);


-- STEP 2: SUCCESSFUL ORDER TRANSACTION (COMMIT)

START TRANSACTION;

INSERT INTO Orders VALUES (5001, 101, '2026-07-22', 55000.00, 'Pending');
INSERT INTO Order_Details VALUES (1, 5001, 10, 1);
UPDATE Inventory SET Stock_Quantity = Stock_Quantity - 1 WHERE Product_ID = 10;
INSERT INTO Payments VALUES (9001, 5001, 'UPI', 'Success');
UPDATE Orders SET Order_Status = 'Completed' WHERE Order_ID = 5001;

COMMIT;


-- STEP 3: FAILED ORDER SIMULATION (Logged for Report Visibility)

START TRANSACTION;

INSERT INTO Orders VALUES (5002, 101, '2026-07-22', 55000.00, 'Cancelled');
INSERT INTO Order_Details VALUES (2, 5002, 10, 1);
-- Stock restoration simulated / handled due to failure
INSERT INTO Payments VALUES (9002, 5002, 'UPI', 'Failed');

COMMIT;


-- STEP 4: GENERATE ASSIGNMENT REPORTS (With Values)

-- Report 1: Order Transaction Report
SELECT 
    o.Order_ID,
    c.Customer_Name,
    o.Total_Amount AS Amount,
    COALESCE(p.Payment_Status, 'Pending/None') AS Payment_Status,
    o.Order_Status
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
LEFT JOIN Payments p ON o.Order_ID = p.Order_ID;

-- Report 2: Failed Transaction Report
SELECT 
    o.Order_ID,
    COALESCE(p.Payment_Status, 'Failed') AS Payment_Status,
    o.Order_Status,
    'Stock Restored / Cancelled' AS Stock_Restoration_Details
FROM Orders o
LEFT JOIN Payments p ON o.Order_ID = p.Order_ID
WHERE o.Order_Status = 'Cancelled' OR p.Payment_Status = 'Failed';

-- Report 3: Inventory Update Report
SELECT 
    i.Product_Name,
    (i.Stock_Quantity + COALESCE(SUM(od.Quantity), 0)) AS Previous_Stock,
    i.Stock_Quantity AS Current_Stock,
    COALESCE(SUM(od.Quantity), 0) AS Quantity_Sold
FROM Inventory i
LEFT JOIN Order_Details od ON i.Product_ID = od.Product_ID
LEFT JOIN Orders o ON od.Order_ID = o.Order_ID AND o.Order_Status = 'Completed'
GROUP BY i.Product_ID, i.Product_Name, i.Stock_Quantity;