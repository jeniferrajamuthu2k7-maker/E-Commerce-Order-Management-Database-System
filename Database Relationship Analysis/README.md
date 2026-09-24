Database Relationship Analysis

Overview:
This project implements SQL JOIN queries on an E-Commerce Database to combine and analyse customer, order, product, and payment information.

Tables Used:
customers
orders
order_details
products
payment

Operations Performed:
Combined related tables using INNER JOIN, LEFT JOIN, and RIGHT JOIN
Retrieved customer and order information
Retrieved order and payment details
Retrieved products purchased by customers
Identified customers without purchases
Identified products with no sales
Generated a complete order report
Analysed customer purchase history
Generated sales and payment reports
Analysed customer spending and order activity

INNER JOIN:
Retrieved matching records from customers, orders, products, and payment tables.

Reports:

Customer and order details

<img width="396" height="175" alt="image" src="https://github.com/user-attachments/assets/b9aaa81d-689d-46e9-a029-d6fba742961a" />

Order and payment information

<img width="667" height="257" alt="image" src="https://github.com/user-attachments/assets/ef02b1ef-f676-49e5-b9cc-c1bd9f1aade0" />

Products purchased by customers

<img width="527" height="247" alt="image" src="https://github.com/user-attachments/assets/0f9be7b4-f65a-4d9a-9e1e-f08e9c11a14e" />

LEFT JOIN:
Retrieved all records from the left table, including records without matching data.

Reports:

All customers with their orders

<img width="377" height="167" alt="image" src="https://github.com/user-attachments/assets/f29f533f-d366-4150-9cf0-d4a654c1f9cf" />


Customers without purchases

<img width="327" height="42" alt="image" src="https://github.com/user-attachments/assets/9b6a4ff8-31c8-417a-b12e-87435ccf23c9" />


Products including products with no sales

<img width="577" height="315" alt="image" src="https://github.com/user-attachments/assets/0441a703-81b3-49c4-a9f3-b4947e0da40f" />

RIGHT JOIN:
Retrieved all records from the right table and matching records from the left table.

Reports:

All orders with customer information

<img width="340" height="163" alt="image" src="https://github.com/user-attachments/assets/2ad09ca6-1d77-42ef-a863-c564ac422f03" />

Orders with missing customer details

<img width="346" height="61" alt="image" src="https://github.com/user-attachments/assets/65d99e3a-ce16-4dbd-95c7-9a3409d8227e" />

Payment records with order information

<img width="622" height="257" alt="image" src="https://github.com/user-attachments/assets/75fb59e4-3cef-42ee-82c3-fa33520ce3a2" />

Complete Order Report:
Combined customers, orders, order_details, products, and payment tables.

Output Includes:
Customer Name
Product Name
Quantity
Order Date
Total Amount
Payment Status

<img width="757" height="412" alt="image" src="https://github.com/user-attachments/assets/318badcd-2c97-490f-af64-0219ba7d2538" />

Customer Purchase History:

<img width="552" height="267" alt="image" src="https://github.com/user-attachments/assets/a2cb6baf-c350-4109-a212-173febb3c80d" />

The queries retrieve:

Products purchased by customers
Total amount spent by each customer
Number of orders placed by each customer
Latest purchase details

Business Reports:

REPORT 1: Customer Order Report

Displays customer name, order ID, order date, and order status.

<img width="431" height="162" alt="image" src="https://github.com/user-attachments/assets/e5ccaeda-713e-41b8-9c8a-2768c064a71f" />


REPORT 2: Sales Report

Displays product name, quantity sold, and total revenue.

<img width="467" height="142" alt="image" src="https://github.com/user-attachments/assets/e95d1129-bc48-4659-bc24-09bf7e90cba8" />

REPORT 3: Payment Analysis Report

Displays payment mode, number of transactions, and successful payments.

<img width="496" height="125" alt="image" src="https://github.com/user-attachments/assets/8c8f049c-bf46-450a-9f9b-bf71139b156f" />

Customer Purchase Analysis:
Analyses customer spending and number of orders.

SQL Concepts Used:

SELECT – Retrieves required data
JOIN – Combines related tables
WHERE – Filters records
GROUP BY – Groups data for analysis
SUM() – Calculates totals
COUNT() – Counts records
MAX() – Finds the latest purchase
CASE – Performs conditional calculations
ORDER BY – Sorts results
IS NULL – Identifies missing records

This project demonstrates the use of SQL JOINs and aggregate functions to retrieve meaningful information and generate useful business reports from an E-Commerce Database.
