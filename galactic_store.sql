-- ---------------------------------------------------------
-- PROJECT: The Galactic Space Store
-- AUTHOR: [Your Name]
-- DATABASE: PostgreSQL
-- DESCRIPTION: A simulation of a space store database covering 
--              CRUD, Joins, Subqueries, Window Functions, and Views.
-- ---------------------------------------------------------

-- ==========================================
-- 1. SETUP TABLES (DDL)
-- ==========================================

-- Drop tables if they exist to start fresh
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50),
    price INT,
    category VARCHAR(20)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE
);

-- ==========================================
-- 2. INSERT DATA (DML)
-- ==========================================

INSERT INTO products (product_name, price, category) VALUES 
('Mars Rover', 500, 'Vehicle'), 
('Laser Saber', 50, 'Gadget'),
('Space Burger', 10, 'Food'), 
('Galaxy Cruiser', 1000, 'Vehicle'),
('Invisibility Cloak', 300, 'Gadget');

INSERT INTO customers (first_name, country) VALUES 
('Alice', 'USA'), 
('Bob', 'Mars'), 
('Charlie', 'Moon'), 
('Diana', 'USA');

INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES 
(1, 3, 2, '2025-01-01'), 
(2, 4, 1, '2025-01-02'),
(1, 2, 1, '2025-01-03'), 
(3, 1, 1, '2025-01-04');

-- Insert a "Mystery Order" for Join testing (Optional)
-- INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES (99, 1, 1, '2025-01-05');

-- ==========================================
-- 3. ANALYTICAL QUERIES & PRACTICE
-- ==========================================

-- ----------------------------
-- A. JOINS (Connecting Tables)
-- ----------------------------

-- Inner Join: Show customers who bought items
SELECT a.first_name, b.product_name, c.quantity
FROM orders AS c
INNER JOIN customers AS a ON c.customer_id = a.customer_id
INNER JOIN products AS b ON c.product_id = b.product_id;

-- Left Join: Show all customers, even those who haven't ordered (Diana)
SELECT a.first_name, b.order_date
FROM customers AS a
LEFT JOIN orders AS b ON a.customer_id = b.customer_id;

-- Right Join: Show all orders, even those with no valid customer
SELECT customers.first_name, orders.order_date
FROM customers
RIGHT JOIN orders ON customers.customer_id = orders.customer_id;

-- ----------------------------
-- B. SUBQUERIES (Filtering by Calculations)
-- ----------------------------

-- Find products that cost MORE than the average price
SELECT product_name, price 
FROM products 
WHERE price > (SELECT AVG(price) FROM products);

-- ----------------------------
-- C. STRING & DATE FUNCTIONS
-- ----------------------------

-- Create an Official ID (Clean up names)
SELECT TRIM(UPPER(CONCAT(first_name, '-', country))) AS official_id
FROM customers;

-- Calculate how old an order is (in days/months)
SELECT order_id, order_date, AGE(CURRENT_DATE, order_date) AS order_age
FROM orders;

-- ----------------------------
-- D. WINDOW FUNCTIONS (Ranking)
-- ----------------------------

-- Rank products by price within their category
SELECT product_name, category, price, 
RANK() OVER(PARTITION BY category ORDER BY price DESC) AS price_rank 
FROM products;

-- ----------------------------
-- E. VIEWS & INDEXES (Optimization)
-- ----------------------------

-- Create an Index for faster searching by country
CREATE INDEX idx_country ON customers(country);

-- Create a View for the Store Manager (Reporting)
-- Use OR REPLACE to avoid errors if running multiple times
CREATE OR REPLACE VIEW order_summary AS
SELECT c.first_name, p.product_name, o.quantity, (p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

-- Test the View
SELECT * FROM order_summary;