-- Seller and Inventoty Management System

-- Create Seller table

USE inventory_db;

create table sellers (
seller_id INT Primary Key Auto_Increment,
store_name VARCHAR(120) NOT NULL UNIQUE,
contact_email VARCHAR(100) NOT NULL UNIQUE,
phone_number VARCHAR(20),
city VARCHAR(50),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE inventory(
item_id INT Primary Key Auto_Increment,
item_name VARCHAR(150) NOT NULL,
seller_id INT not null,
sku VARCHAR(50) UNIQUE,
unit_price DECIMAL(10, 2) NOT NULL,
stock_quantity INT NOT NULL DEFAULT 0,
reorder_level INT DEFAULT 10,
last_restocked TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

-- Foreign Key Constraint
CONSTRAINT fk_sellers_inventory
FOREIGN KEY (seller_id)
REFERENCES sellers(seller_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

INSERT INTO sellers
(store_name, contact_email, phone_number, city)
VALUES
('Tech World', 'techworld@gmail.com', '9876543210', 'Chennai'),
('Fresh Mart', 'freshmart@gmail.com', '9876543211', 'Bangalore'),
('Style Hub', 'stylehub@gmail.com', '9876543212', 'Mumbai'),
('Book Point', 'bookpoint@gmail.com', '9876543213', 'Delhi'),
('Home Needs', 'homeneeds@gmail.com', '9876543214', 'Hyderabad'),
('Gadget Zone', 'gadgetzone@gmail.com', '9876543215', 'Pune'),
('Daily Basket', 'dailybasket@gmail.com', '9876543216', 'Kochi'),
('Fashion Corner', 'fashioncorner@gmail.com', '9876543217', 'Coimbatore'),
('Smart Store', 'smartstore@gmail.com', '9876543218', 'Madurai'),
('Mega Shop', 'megashop@gmail.com', '9876543219', 'Trichy');

INSERT INTO inventory
(item_name, seller_id, sku, unit_price, stock_quantity, reorder_level)
VALUES
('Wireless Mouse', 1, 'WM001', 599.00, 50, 10),
('Keyboard', 1, 'KB001', 899.00, 35, 10),
('Notebook', 2, 'NB001', 80.00, 100, 20),
('Cotton Shirt', 3, 'CS001', 799.00, 40, 10),
('Java Programming Book', 4, 'JP001', 650.00, 25, 5),
('Water Bottle', 5, 'WB001', 350.00, 60, 15),
('Bluetooth Speaker', 6, 'BS001', 1499.00, 20, 5),
('Rice Bag', 7, 'RB001', 1200.00, 30, 10),
('Handbag', 8, 'HB001', 999.00, 18, 5),
('Smart Watch', 9, 'SW001', 2499.00, 15, 5);

-- 1. Update the price
UPDATE inventory
SET unit_price = 649.00
WHERE item_id = 1;

-- 2. Increase stock quantity
UPDATE inventory
SET stock_quantity = stock_quantity + 20
WHERE item_id = 2;

-- 3. Change reorder level
UPDATE inventory
SET reorder_level = 15
WHERE item_id = 3;

-- 4. Update seller city
UPDATE sellers
SET city = 'Chennai'
WHERE seller_id = 5;

SELECT * FROM sellers;

SELECT * FROM inventory;

-- Report 1: Comprehensive Availability & Stock Classification Report
-- Evaluates every product's operational state (Available, Low Stock Alert, or Unavailable / Out of Stock).
SELECT
s.store_name,
i.item_id,
i.item_name,
i.sku,
i.unit_price,
i.stock_quantity,
i.reorder_level,
CASE
WHEN i.stock_quantity = 0 THEN 'Unavailable (Out of Stock)'
WHEN i.stock_quantity <= i.reorder_level THEN 'Available (Low Stock Alert)'
ELSE 'Available (Optimal Stock)'
END AS inventory_status
FROM inventory i
INNER JOIN sellers s ON i.seller_id = s.seller_id
ORDER BY s.store_name, i.stock_quantity ASC;

-- Report 2: Unavailable Product Breakdown (Out-of-Stock Audit)
-- Isolates all stock-out occurrences across vendors to prioritize replenishment orders.
SELECT
s.seller_id,
s.store_name,
s.contact_email,
i.sku,
i.item_name,
i.unit_price,
i.last_restocked
FROM inventory i
INNER JOIN sellers s ON i.seller_id = s.seller_id
WHERE i.stock_quantity = 0
ORDER BY s.store_name, i.item_name;

-- Report 3: Seller Portfolio Valuation & Availability Aggregation
-- Provides executive summary metrics for each seller, counting total SKUs, active available items, unavailable items, and total financial valuation.
SELECT
s.seller_id,
s.store_name,
s.city,
COUNT(i.item_id) AS total_skus_managed,
SUM(CASE WHEN i.stock_quantity > 0 THEN 1 ELSE 0 END) AS available_skus,
SUM(CASE WHEN i.stock_quantity = 0 THEN 1 ELSE 0 END) AS unavailable_skus,
COALESCE(SUM(i.stock_quantity), 0) AS total_units_in_stock,
COALESCE(ROUND(SUM(i.unit_price * i.stock_quantity), 2), 0.00) AS
total_inventory_valuation
FROM sellers s
LEFT JOIN inventory i ON s.seller_id = i.seller_id
GROUP BY s.seller_id, s.store_name, s.city
ORDER BY total_inventory_valuation DESC;