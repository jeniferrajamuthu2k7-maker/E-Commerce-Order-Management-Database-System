# SQL Query Implementation – E-Commerce Inventory Database

## Overview

This project implements SQL queries for an E-Commerce Inventory Database to retrieve, filter, sort, and analyse customer, product, order, payment, and review data.

## Tables Used

* `customers`
* `products`
* `categories`
* `orders`
* `order_details`
* `payment`
* `review`

## Operations Performed

* Retrieved customer, product, order, and payment details
* Filtered data using `WHERE`
* Sorted data using `ORDER BY`
* Retrieved unique values using `DISTINCT`
* Used `LIKE`, `BETWEEN`, and `IN`
* Joined related tables
* Generated basic business reports

## Product Availability Report

This report shows product price, stock quantity, and availability status using the `CASE` statement.

**Output:**
<img width="567" height="186" alt="image" src="https://github.com/user-attachments/assets/20586823-b896-4c88-9844-b4dca71f675c" />


## Customer Report

This report displays customer ID, name, city, email, and the total number of customers.

**Output:**
<img width="608" height="135" alt="image" src="https://github.com/user-attachments/assets/904497ea-03ed-418e-88c6-7110233b252e" />


## Order Report

This report summarizes total, completed, pending, and cancelled orders using `COUNT()`, `SUM()`, and `CASE`.

**Output:**
<img width="537" height="57" alt="image" src="https://github.com/user-attachments/assets/d3616f82-bade-4a07-afb6-573a75bf64ce" />

## Product Performance Report

This report shows product price, number of reviews, stock quantity, and availability status.

**Output:**
<img width="732" height="200" alt="image" src="https://github.com/user-attachments/assets/5eb6adad-84b5-43ce-9356-bfbe227e63d4" />

## SQL Concepts Used

* **SELECT** – Retrieves data
* **WHERE** – Filters records
* **ORDER BY** – Sorts records
* **DISTINCT** – Retrieves unique values
* **LIKE / BETWEEN / IN** – Applies conditions
* **JOIN / LEFT JOIN** – Combines related tables
* **GROUP BY** – Groups records
* **COUNT / SUM** – Performs calculations
* **CASE** – Displays conditional results

