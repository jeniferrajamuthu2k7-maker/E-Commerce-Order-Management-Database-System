 Product Review & Rating Management – SQL Project
 Project Overview
This project focuses on creating and analyzing a Product Review and Rating Management System using MySQL. The Review table is connected with the Customers and Products tables through foreign key relationships, allowing customer feedback and product ratings to be stored and analyzed.

 Objectives
Create a structured Review table.

Establish Customer–Review and Product–Review relationships using foreign keys.

Store product ratings, customer comments, and review dates.

Validate ratings using a CHECK constraint (1–5).

Analyze product ratings and customer feedback.

Identify highly rated and low-rated products.

 Review Table Design
The Review table stores customer feedback such as Customer ID, Product ID, Rating, Review Text, and Review Date. It uses Primary Key, Foreign Key, NOT NULL, Auto Increment, Default, and CHECK constraints for proper data management.

ER Relationship
The Review table is connected to the Customers and Products tables using foreign key relationships:

Customers (1) ─────── (Many) Review

Products (1) ─────── (Many) Review

One customer can write multiple reviews, while each review belongs to one customer. Similarly, one product can have multiple reviews, while each review belongs to one product.

<img width="1025" height="792" alt="image" src="https://github.com/user-attachments/assets/5901905c-bb43-4698-aa24-ce3f5d740651" />

 Product Review Analysis Reports
 
Report 1 - Product Rating Analysis

<img width="522" height="182" alt="image" src="https://github.com/user-attachments/assets/c9e46c68-107c-48e3-80d0-f6518838d2fd" />

Shows the product name, number of reviews, and average rating to evaluate overall product performance.

Report 2 - Customer Feedback Analysis

<img width="673" height="200" alt="image" src="https://github.com/user-attachments/assets/3a77ed81-166f-4977-9962-517ffb36374d" />

Shows the number of reviews, average rating, and product performance, helping identify most reviewed, highly rated, and products requiring improvement.

Report 3 – Rating Distribution

<img width="710" height="83" alt="image" src="https://github.com/user-attachments/assets/1bbcddda-cad9-4632-abdd-54705885ba68" />

Shows the distribution of 5-star, 4-star, and low ratings, providing an overview of customer satisfaction.

 Technologies Used
MySQL
MySQL Workbench
SQL

 Conclusion
The Product Review and Rating Management System provides a structured way to store and analyze customer feedback. The SQL queries help identify highly rated products, customer satisfaction levels, review counts, and products requiring improvement.
