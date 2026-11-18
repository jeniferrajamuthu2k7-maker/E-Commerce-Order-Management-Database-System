DATABASE SECURITY AND PERFORMANCE OPTIMIZATION USING SQL

Overview: 

This project implements Database Security and Performance Optimization in an E-Commerce Database using SQL user permissions, access control, indexing, and query optimization techniques to improve database security and efficiency.

Tables Used:

- Customer
- Orders
- Order_Details
- Products
- Payment
- Inventory

Operations Performed:

1. Database User and Role Creation

Created different database users with role-based permissions.

Roles:
- Admin User
- Sales User
- Inventory User
- Customer Support User


2. GRANT and REVOKE Implementation

Implemented permission management using SQL commands.

Operations:
- Granted SELECT permissions to Sales User.
- Granted stock update permissions to Inventory User.
- Granted customer and order viewing permissions to Customer Support User.
- Revoked unauthorized INSERT permissions.
- Managed database access using GRANT and REVOKE.


3. Access Control Demonstration

Implemented and tested role-based access control.

Operations:
- Verified authorized database operations.
- Tested unauthorized access.
- Demonstrated permission errors.
- Ensured users could access only permitted database resources.


4. Index Creation

Created indexes on frequently searched columns to improve query performance.

Indexes Created:
- Product Name
- Category ID
- Customer Email
- Customer Phone
- Order Date
- Customer ID


5. Query Optimization Analysis

Analyzed query performance before and after index creation.

Queries Optimized:
- Search products by category.
- Retrieve customer order history.
- Generate sales reports.
- Identify top-selling products.

Used `EXPLAIN` to analyze query execution plans and compare performance.


Reports Generated:

REPORT 1: User Access Report

Displays database usernames, assigned roles, and granted permissions.

<img width="461" height="136" alt="image" src="https://github.com/user-attachments/assets/7032ec76-a15b-4560-b8c7-7b2dcedccd8e" />


REPORT 2: Query Performance Report

Compares query execution plans and performance before and after indexing.

<img width="793" height="105" alt="image" src="https://github.com/user-attachments/assets/96bbaa7f-8289-4ee6-94c0-54cbf51c4474" />


REPORT 3: Database Security Report

Displays user roles, granted privileges, and revoked permissions.

<img width="795" height="145" alt="image" src="https://github.com/user-attachments/assets/e8c433b4-cc91-4e00-bc64-5b30e47930ae" />



Testing:

- Verified user permissions.
- Tested GRANT and REVOKE commands.
- Checked authorized and unauthorized operations.
- Verified index creation.
- Analyzed query execution plans using EXPLAIN.
- Compared query performance before and after optimization.

SQL Concepts Used:

- CREATE USER – Creates database users.
- CREATE ROLE – Creates database roles.
- GRANT – Provides database permissions.
- REVOKE – Removes database permissions.
- INDEX – Improves data retrieval speed.
- EXPLAIN – Analyzes query execution plans.
- SELECT – Retrieves database records.
- JOIN – Combines related tables.
- GROUP BY – Groups records for reports.

This project demonstrates database security through access control and performance optimization through indexing and query analysis, ensuring secure and efficient database operations in an E-Commerce Database System.


