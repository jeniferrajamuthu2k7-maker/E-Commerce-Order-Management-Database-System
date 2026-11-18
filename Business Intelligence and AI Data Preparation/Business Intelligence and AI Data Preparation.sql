-- =====================================================================
-- 1. SALES PERFORMANCE REPORT
-- =====================================================================
SELECT 
    COUNT(Order_ID) AS Total_Orders,
    SUM(Total_Amount) AS Total_Sales,
    AVG(Total_Amount) AS Average_Order_Value,
    DATE_FORMAT(Order_Date, '%Y-%m') AS Monthly_Period,
    SUM(Total_Amount) AS Monthly_Revenue
FROM Orders
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m');


-- =====================================================================
-- 2. CUSTOMER ANALYSIS REPORT
-- =====================================================================
SELECT 
    c.Customer_Name,
    COUNT(o.Order_ID) AS Number_Of_Orders,
    SUM(o.Total_Amount) AS Total_Purchases,
    MAX(o.Order_Date) AS Last_Purchase_Date
FROM Customers c
LEFT JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;


-- =====================================================================
-- 3. PRODUCT PERFORMANCE REPORT
-- =====================================================================
SELECT 
    i.Product_Name,
    SUM(od.Quantity) AS Quantity_Sold,
    SUM(od.Quantity * i.Price) AS Revenue_Generated,
    RANK() OVER (ORDER BY SUM(od.Quantity * i.Price) DESC) AS Product_Ranking
FROM Inventory i
JOIN Order_Details od ON i.Product_ID = od.Product_ID
GROUP BY i.Product_ID, i.Product_Name;

-- =====================================================================
-- 1. RANK PRODUCTS BASED ON SALES
-- =====================================================================
SELECT
    Product_ID,
    SUM(Quantity) AS Total_Sales,
    RANK() OVER(ORDER BY SUM(Quantity) DESC) AS Sales_Rank,
    DENSE_RANK() OVER(ORDER BY SUM(Quantity) DESC) AS Dense_Sales_Rank
FROM Order_Details
GROUP BY Product_ID;


-- =====================================================================
-- 2. RANK CUSTOMERS BASED ON PURCHASE AMOUNT
-- =====================================================================
SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(o.Total_Amount) AS Total_Spent,
    RANK() OVER(ORDER BY SUM(o.Total_Amount) DESC) AS Customer_Spending_Rank
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;


-- =====================================================================
-- 3. GENERATE LATEST ORDER SEQUENCE (ROW_NUMBER)
-- =====================================================================
SELECT 
    Order_ID,
    Customer_ID,
    Order_Date,
    ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY Order_Date DESC) AS Order_Sequence
FROM Orders;

-- =====================================================================
-- CUSTOMER SEGMENTATION QUERY
-- =====================================================================
SELECT 
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Total_Purchase_Amount,
    CASE 
        WHEN SUM(o.Total_Amount) >= 100000 OR COUNT(o.Order_ID) >= 15 THEN 'Premium / High Value'
        WHEN SUM(o.Total_Amount) >= 20000 OR COUNT(o.Order_ID) >= 5 THEN 'Regular'
        ELSE 'Low Value'
    END AS Customer_Segment
FROM Customers c
LEFT JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;

-- =====================================================================
-- FEATURE EXTRACTION & ML DATASET PREPARATION QUERY
-- =====================================================================
SELECT 
    c.Customer_ID,
    -- 1. Customer Features
    COUNT(o.Order_ID) AS Total_Purchases,
    COALESCE(SUM(o.Total_Amount), 0) AS Total_Spending,
    COALESCE(AVG(o.Total_Amount), 0) AS Average_Order_Value,
    MAX(o.Order_Date) AS Last_Purchase_Date,
    -- 2. Time-Based Extractions
    YEAR(MAX(o.Order_Date)) AS Last_Purchase_Year,
    MONTH(MAX(o.Order_Date)) AS Last_Purchase_Month
FROM Customers c
LEFT JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID;


SELECT 
    CASE 
        WHEN SUM(o.Total_Amount) >= 100000 OR COUNT(o.Order_ID) >= 15 THEN 'Premium / High Value'
        WHEN SUM(o.Total_Amount) >= 20000 OR COUNT(o.Order_ID) >= 5 THEN 'Regular'
        ELSE 'Low Value'
    END AS Customer_Category,
    COUNT(o.Order_ID) AS Purchase_Frequency,
    SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
LEFT JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;

SELECT 
    i.Product_Name,
    SUM(od.Quantity * i.Price) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(od.Quantity * i.Price) DESC) AS Sales_Rank
FROM Inventory i
JOIN Order_Details od ON i.Product_ID = od.Product_ID
GROUP BY i.Product_ID, i.Product_Name;

SELECT 
    c.Customer_ID,
    COUNT(o.Order_ID) AS Total_Purchases,
    COALESCE(SUM(o.Total_Amount), 0) AS Total_Spending,
    COALESCE(AVG(o.Total_Amount), 0) AS Average_Order_Value,
    MAX(o.Order_Date) AS Last_Purchase_Date,
    YEAR(MAX(o.Order_Date)) AS Last_Purchase_Year,
    MONTH(MAX(o.Order_Date)) AS Last_Purchase_Month
FROM Customers c
LEFT JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID;

-- =====================================================================
-- CORRECTED AI-READY DATASET & FEATURE EXTRACTION QUERY
-- =====================================================================
SELECT 
    c.Customer_ID,
    
    -- 1. Customer Features
    COUNT(o.Order_ID) AS Total_Purchases,
    COALESCE(SUM(o.Total_Amount), 0) AS Total_Spending,
    COALESCE(AVG(o.Total_Amount), 0) AS Average_Order_Value,
    
    -- 2. Product & Quantity Features
    SUM(od.Quantity) AS Total_Quantity_Ordered,
    COUNT(DISTINCT od.Product_ID) AS Unique_Products_Bought,
    
    -- Categorical Encoding (Converting price tiers into numerical format for ML models)
    CASE 
        WHEN AVG(i.Price) >= 50000 THEN 1  -- High-End / Premium Tier
        WHEN AVG(i.Price) >= 10000 THEN 2  -- Mid-Range Tier
        ELSE 3                             -- Budget Tier
    END AS Encoded_Price_Category,
    
    -- 3. Time-Based Features
    MAX(o.Order_Date) AS Last_Purchase_Date,
    YEAR(MAX(o.Order_Date)) AS Last_Purchase_Year,
    MONTH(MAX(o.Order_Date)) AS Last_Purchase_Month,
    DAY(MAX(o.Order_Date)) AS Last_Purchase_Day
    
FROM Customers c
LEFT JOIN Orders o ON c.Customer_ID = o.Customer_ID
LEFT JOIN Order_Details od ON o.Order_ID = od.Order_ID
LEFT JOIN Inventory i ON od.Product_ID = i.Product_ID
GROUP BY c.Customer_ID;