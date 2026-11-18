DATABASE AUTOMATION USING VIEWS AND PROCEDURES

Overview
This project implements database automation in an E-Commerce Database using SQL Views, Stored Procedures, and Functions to simplify repetitive operations and generate business reports.

Tables Used:
customers,
orders,
order_details,
products,
payment,
inventory.

Operations Performed:
Created views for frequently used reports,
Generated customer purchase reports,
Generated product sales reports,
Generated payment status reports,
Developed stored procedures for order processing,
Updated order status using procedures,
Generated customer purchase history,
Created functions for sales calculations,
Automated inventory stock updates,
Identified low-stock products,
Generated daily and monthly sales reports.

Views:
Created views to retrieve frequently used business information.

Reports:
Customer Order Report,
Product Sales Report,
Payment Status Report.

Stored Procedures:
Developed procedures to automate repetitive database operations.

Operations:
Add new customer orders,
Update order status,
Generate customer purchase history,
Increase product stock.

Functions:
Created SQL functions to perform sales calculations.

Functions:
Calculate Total Sales,
Calculate Customer Total Spending,
Calculate Product Revenue.

Automation:
Implemented automation for order processing and inventory management.

Operations:
Reduce product stock after purchases,
Check product stock availability,
Increase stock after new supplies,
Identify low-stock products,
Generate daily sales reports,
Generate monthly revenue reports.

Business Reports:

REPORT 1 Customer Purchase Report:
Displays customer name, total number of orders, and total purchase amount.
<img width="268" height="150" alt="image" src="https://github.com/user-attachments/assets/b55ccf7c-3399-4c35-9fc9-d7f879081e2d" />

REPORT 2 Sales Report:
Displays product name, quantity sold, and total revenue generated.
<img width="440" height="142" alt="image" src="https://github.com/user-attachments/assets/f1607725-a4f5-40d2-a978-e1974857d5d2" />

REPORT 3 Inventory Report:
Displays product name, available stock quantity, and stock status.
<img width="391" height="180" alt="image" src="https://github.com/user-attachments/assets/01f45422-c97b-4334-ad53-f3bd049209b8" />

Testing:
Tested the created database objects to verify their execution and results.
Verified view data retrieval,
Tested stored procedure execution,
Checked function return values,
Verified stock updates,
Checked report generation.

Workflow:
Customer Places Order

    ↓
Check Product Availability

    ↓
Insert Order Details

    ↓
Calculate Total Amount

    ↓
Reduce Product Stock

    ↓
Create Payment Record

    ↓
Update Order Information

    ↓
Generate Business Reports


SQL Concepts Used:
VIEW – Creates virtual tables,
PROCEDURE – Automates SQL operations,
FUNCTION – Performs calculations and returns values,
JOIN – Combines related tables,
SUM() – Calculates total values,
COUNT() – Counts records,
GROUP BY – Groups records,
TRIGGER – Automates database actions,
CASE – Performs conditional operations,
This project demonstrates database automation using SQL to simplify order processing, sales calculations, inventory management, and business report generation in an E-Commerce Database.
