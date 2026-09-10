CREATE TABLE review (
    review_id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    review_text VARCHAR(500),
    review_date DATE NOT NULL DEFAULT (CURRENT_DATE),

    CONSTRAINT pk_review PRIMARY KEY (review_id),

    CONSTRAINT fk_review_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(Customer_ID),

    CONSTRAINT fk_review_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT chk_rating
        CHECK (rating BETWEEN 1 AND 5)
);

SELECT
    o.Customer_ID,
    c.Customer_Name,
    od.Product_ID,
    p.Product_Name,
    o.Order_Status
FROM orders o
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
JOIN order_details od
    ON o.Order_ID = od.Order_ID
JOIN products p
    ON od.Product_ID = p.Product_ID
ORDER BY o.Customer_ID;

INSERT INTO review
(customer_id, product_id, rating, review_text)
VALUES
(1, 1, 5, 'Excellent sound quality and comfortable to use'),
(1, 2, 5, 'Excellent performance and very fast'),
(3, 1, 4, 'Good sound quality and battery life'),
(3, 4, 3, 'Good mouse but could be improved'),
(4, 5, 4, 'Good quality and clear sound');

SELECT * FROM review;

SELECT
    c.Customer_Name,
    p.product_name,
    r.rating,
    r.review_text,
    r.review_date
FROM review r
JOIN customers c
    ON r.customer_id = c.Customer_ID
JOIN products p
    ON r.product_id = p.product_id
ORDER BY r.review_date DESC;

SELECT
    p.product_name,
    ROUND(AVG(r.rating), 2) AS Average_Rating
FROM products p
JOIN review r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) > 4;

SELECT
    p.product_name,
    COUNT(r.review_id) AS Number_of_Reviews
FROM products p
JOIN review r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY Number_of_Reviews DESC;

SELECT
    rating,
    COUNT(*) AS Rating_Count
FROM review
GROUP BY rating
ORDER BY rating DESC;

SELECT
    p.product_name,
    ROUND(AVG(r.rating), 2) AS Average_Rating
FROM products p
JOIN review r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) <= 3;

UPDATE review
SET review_text = 'Poor performance'
WHERE review_id = 2;

DELETE FROM review
WHERE review_id = 5;

-- Report 1 --
INSERT INTO review
(customer_id, product_id, rating, review_text)
VALUES
(2, 3, 4, 'Smart watch has useful features'),
(4, 4, 3, 'Good mouse but could be improved'),
(5, 5, 4, 'Good quality and comfortable'),
(1, 6, 5, 'Very useful guide for learning SQL'),
(2, 7, 4, 'Good pen quality and smooth writing');

SELECT
    p.product_name AS Product_Name,
    COUNT(r.review_id) AS Number_of_Reviews,
    ROUND(AVG(r.rating), 2) AS Average_Rating
FROM products p
LEFT JOIN review r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY Average_Rating DESC;

-- Report 2 --
SELECT
    p.product_name AS Product_Name,
    COUNT(r.review_id) AS Number_of_Reviews,
    ROUND(AVG(r.rating), 2) AS Average_Rating,
    CASE
        WHEN AVG(r.rating) >= 4 THEN 'Highly Rated'
        WHEN AVG(r.rating) <= 3 THEN 'Requires Improvement'
        ELSE 'Average'
    END AS Performance
FROM products p
LEFT JOIN review r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(r.review_id) > 0
ORDER BY Number_of_Reviews DESC;

-- Report 3 --
SELECT
    CASE
        WHEN rating = 5 THEN '5-Star Ratings'
        WHEN rating = 4 THEN '4-Star Ratings'
        WHEN rating <= 3 THEN 'Low Ratings'
    END AS Rating_Category,
    COUNT(*) AS Number_of_Ratings
FROM review
GROUP BY Rating_Category
ORDER BY Number_of_Ratings DESC;

SHOW CREATE TABLE review;SELECT
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'inventory_db'
AND TABLE_NAME = 'review'
AND REFERENCED_TABLE_NAME IS NOT NULL;


