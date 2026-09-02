# Payment Management And Analysis

##  Project Overview

This project focuses on creating and analyzing a **Payment Management System** using MySQL. The Payment table is connected with the Orders table through a **foreign key relationship**, allowing payment details to be tracked for each order.

---

##  Objectives

* Create a structured Payment table.
* Establish an **Order–Payment relationship** using a foreign key.
* Store payment mode, status, date, and transaction amount.
* Perform payment status analysis.
* Analyze payment methods and revenue.
* Display customer payment history using table joins.

---

##  Payment Table Design

The `Payment` table stores payment details such as Order ID, Payment Date, Payment Mode, Payment Status, and Transaction Amount. It uses **Primary Key, Foreign Key, Auto Increment, Default, and CHECK constraints** for proper data management.


---

##  ER Relationship

The Payment table is connected to the Orders table using:

**Orders (1) ─────── (Many) Payment**

One order can have payment records associated with it, while each payment belongs to a particular order.

<img width="1016" height="802" alt="image" src="https://github.com/user-attachments/assets/aca917fb-f7ea-4b1b-bf96-723168b20f00" />

---


# Payment Analysis Reports

## Report 1 – Payment Mode Analysis

<img width="551" height="70" alt="image" src="https://github.com/user-attachments/assets/3ab9ea10-7167-4710-b45b-37ae8047e95b" />


Shows the number of UPI transactions, card payments and the most preferred payment method.

---

## Report 2 – Revenue Analysis

<img width="702" height="67" alt="image" src="https://github.com/user-attachments/assets/c00947f0-c692-4373-bb96-f9e0a7a05a0f" />


Shows total revenue, revenue by payment method and average transaction amount.

---

## Report 3 – Customer Payment History

<img width="580" height="257" alt="image" src="https://github.com/user-attachments/assets/d2ecc30b-1ce7-481f-b752-d2dcb30b196d" />


Shows customer name, order ID, payment mode, amount and payment status.
---

##  Technologies Used

* **MySQL**
* **MySQL Workbench**
* SQL

---

##  Conclusion

The Payment Management System provides a structured way to store and analyze customer payment information. The SQL queries help identify preferred payment methods, analyze revenue, monitor transaction statuses, and track individual customer payment history.
