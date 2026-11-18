 BUSINESS INTELLIGENCE AND AI DATA PREPARATION

1. SQL Analytical Queries
   
Generated three analytical reports:

Sales Performance: Total sales, number of orders, average order value and monthly revenue.

Customer Analysis: Customer name, total purchases, number of orders and last purchase date.

Product Performance: Product name, quantity sold, revenue generated and product ranking.

2. Window Functions:

Implemented:

RANK() – Ranks products and customers based on sales and spending.

DENSE_RANK() – Ranks products without skipping rank numbers.

ROW_NUMBER() – Generates the latest order sequence for each customer.

3. Customer Segmentation:

Classified customers into:

Premium / High Value

Regular

Low Value

Segmentation is based on total spending and purchase frequency.

4. AI-Ready Dataset Preparation:

Prepared a customer-level dataset by combining multiple tables.

Selected Features:

Customer ID

Total Purchases

Total Spending

Average Order Value

Total Quantity Ordered

Unique Products Bought

Encoded Price Category

Last Purchase Date, Year, Month and Day

Data Preparation:

Combined tables using JOIN operations.

Used GROUP BY to generate customer-level records.

Applied COALESCE() to handle missing numerical values.

Used CASE statements for numerical category encoding.

Extracted date-based features.

5. Feature Extraction:

Extracted meaningful customer, product and time-based features, including:

Purchase count, total spending and average order value.

Product quantity and revenue.

Unique products purchased.

Last purchase year, month and day.

6. Business Intelligence Reports:

Report 1: Customer Segmentation Report

<img width="470" height="50" alt="image" src="https://github.com/user-attachments/assets/af7cbbcc-d429-469a-8ebd-a934c9c14d12" />

Displays customer category, purchase frequency and total spending.

Report 2: Sales Ranking Report

<img width="331" height="65" alt="image" src="https://github.com/user-attachments/assets/0a6e3971-0345-4fca-b4a1-5e80f3edfba7" />

Displays product name, total sales and sales rank using RANK().

Report 3: AI Dataset Report

<img width="1635" height="92" alt="image" src="https://github.com/user-attachments/assets/34d1ba27-4c13-4deb-80cc-c5c710732259" />

Documents selected features, data cleaning and preparation steps, and final dataset structure.

Conclusion:
Successfully implemented advanced SQL analytics, window functions, customer segmentation, feature extraction and AI-ready dataset preparation to support business decision-making and future Machine Learning applications.









 
