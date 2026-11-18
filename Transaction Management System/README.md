TRANSACTION MANAGEMENT SYSTEM USING SQL

Overview:
This project implements Transaction Management in an E-Commerce Database using SQL to ensure reliable order processing, payment handling, and inventory management using COMMIT, ROLLBACK, and ACID properties.

Tables Used:
- Customer
- Orders
- Order_Details
- Products
- Payment
- Inventory

Operations Performed:
- Implemented order placement transactions
- Inserted order and product details
- Updated inventory stock
- Recorded UPI payment details
- Applied COMMIT and ROLLBACK operations
- Verified database consistency

 1. Successful Order Transaction Execution

- Created a new customer order.
- Inserted ordered product details.
- Reduced inventory stock.
- Recorded successful UPI payment.
- Updated order status to Completed.
- Executed COMMIT to save all changes.

2. Failed Transaction with ROLLBACK Demonstration

- Created a temporary order.
- Inserted product details.
- Simulated payment failure.
- Executed ROLLBACK to cancel all transaction changes.
- Verified stock restoration and transaction cancellation.

3. ACID Properties

- Atomicity – All transaction operations succeed together or are completely cancelled.
- Consistency – Maintains database accuracy and prevents negative stock.
- Isolation – Prevents concurrent transactions from interfering with each other.
- Durability – Ensures committed changes remain permanently stored.

4. Transaction Reports

REPORT 1: Order Transaction Report
Displays order ID, customer name, amount, payment status, and order status.
<img width="567" height="105" alt="image" src="https://github.com/user-attachments/assets/22cbb206-c7c6-46c1-bb2d-20c69691f8b8" />


REPORT 2: Failed Transaction Report
Displays failed payments, cancelled orders, and stock restoration details.
<img width="563" height="65" alt="image" src="https://github.com/user-attachments/assets/8868e70f-dfc9-4c7b-9c43-dfc284e314b7" />


REPORT 3: Inventory Update Report
Displays product name, previous stock, current stock, and quantity sold.
<img width="483" height="66" alt="image" src="https://github.com/user-attachments/assets/16dd052f-4092-4456-8af7-4bc586e350a1" />

SQL Concepts Used:

- START TRANSACTION
- COMMIT
- ROLLBACK
- ACID Properties
- SELECT FOR UPDATE
- INSERT
- UPDATE
- JOIN
- CASE
  
This project demonstrates reliable transaction processing in an E-Commerce Database while maintaining data integrity and consistency.
