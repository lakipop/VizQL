-- VizQL Sample Database
-- This script creates sample tables and data for testing VizQL

-- ==============================================
-- CLEANUP (if running multiple times)
-- ==============================================
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS categories;

-- ==============================================
-- TABLE: categories
-- ==============================================
CREATE TABLE categories (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================
-- TABLE: products
-- ==============================================
CREATE TABLE products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  stock INT DEFAULT 0,
  category_id INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- ==============================================
-- TABLE: customers
-- ==============================================
CREATE TABLE customers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone VARCHAR(20),
  city VARCHAR(100),
  country VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================
-- TABLE: orders
-- ==============================================
CREATE TABLE orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total_amount DECIMAL(10,2) NOT NULL,
  status VARCHAR(50) DEFAULT 'pending',
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- ==============================================
-- TABLE: order_items
-- ==============================================
CREATE TABLE order_items (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- ==============================================
-- INSERT SAMPLE DATA: categories
-- ==============================================
INSERT INTO categories (name, description) VALUES
  ('Electronics', 'Electronic devices and accessories'),
  ('Furniture', 'Home and office furniture'),
  ('Clothing', 'Apparel and accessories'),
  ('Books', 'Physical and digital books'),
  ('Sports', 'Sports equipment and gear');

-- ==============================================
-- INSERT SAMPLE DATA: products
-- ==============================================
INSERT INTO products (name, description, price, stock, category_id) VALUES
  -- Electronics
  ('Laptop Pro 15"', 'High-performance laptop for professionals', 1299.99, 25, 1),
  ('Wireless Mouse', 'Ergonomic wireless mouse with precision tracking', 29.99, 150, 1),
  ('Mechanical Keyboard', 'RGB mechanical gaming keyboard', 89.99, 75, 1),
  ('USB-C Hub', '7-in-1 USB-C hub with HDMI and card reader', 49.99, 100, 1),
  
  -- Furniture
  ('Office Desk', 'Adjustable height standing desk', 399.99, 20, 2),
  ('Ergonomic Chair', 'Mesh office chair with lumbar support', 249.99, 35, 2),
  ('Bookshelf', '5-tier wooden bookshelf', 129.99, 15, 2),
  
  -- Clothing
  ('Cotton T-Shirt', 'Premium cotton crew neck t-shirt', 19.99, 200, 3),
  ('Denim Jeans', 'Classic fit denim jeans', 59.99, 120, 3),
  ('Winter Jacket', 'Waterproof insulated winter jacket', 149.99, 40, 3),
  
  -- Books
  ('JavaScript Guide', 'Complete guide to modern JavaScript', 39.99, 50, 4),
  ('Database Design', 'Principles of database design and SQL', 44.99, 30, 4),
  ('Creative Writing', 'The art and craft of creative writing', 24.99, 45, 4),
  
  -- Sports
  ('Yoga Mat', 'Non-slip exercise yoga mat', 34.99, 80, 5),
  ('Resistance Bands', 'Set of 5 resistance bands', 24.99, 100, 5),
  ('Running Shoes', 'Lightweight running shoes', 89.99, 60, 5);

-- ==============================================
-- INSERT SAMPLE DATA: customers
-- ==============================================
INSERT INTO customers (first_name, last_name, email, phone, city, country) VALUES
  ('John', 'Smith', 'john.smith@email.com', '555-0101', 'New York', 'USA'),
  ('Emma', 'Johnson', 'emma.j@email.com', '555-0102', 'London', 'UK'),
  ('Michael', 'Brown', 'mbrown@email.com', '555-0103', 'Toronto', 'Canada'),
  ('Sophia', 'Davis', 'sophia.d@email.com', '555-0104', 'Sydney', 'Australia'),
  ('James', 'Wilson', 'jwilson@email.com', '555-0105', 'Los Angeles', 'USA'),
  ('Olivia', 'Martinez', 'olivia.m@email.com', '555-0106', 'Madrid', 'Spain'),
  ('William', 'Garcia', 'wgarcia@email.com', '555-0107', 'Mexico City', 'Mexico'),
  ('Ava', 'Anderson', 'ava.a@email.com', '555-0108', 'Chicago', 'USA'),
  ('Noah', 'Thomas', 'nthomas@email.com', '555-0109', 'Berlin', 'Germany'),
  ('Isabella', 'Lee', 'isabella.l@email.com', '555-0110', 'Singapore', 'Singapore');

-- ==============================================
-- INSERT SAMPLE DATA: orders
-- ==============================================
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
  (1, '2025-11-01 10:30:00', 1349.98, 'completed'),
  (2, '2025-11-01 14:15:00', 89.99, 'completed'),
  (3, '2025-11-02 09:00:00', 649.98, 'shipped'),
  (4, '2025-11-02 16:45:00', 39.99, 'completed'),
  (5, '2025-11-03 11:20:00', 279.97, 'processing'),
  (6, '2025-11-03 13:30:00', 149.99, 'shipped'),
  (7, '2025-11-04 08:45:00', 124.98, 'completed'),
  (8, '2025-11-04 15:10:00', 534.97, 'processing'),
  (9, '2025-11-05 10:00:00', 79.98, 'pending'),
  (10, '2025-11-05 12:30:00', 189.98, 'pending');

-- ==============================================
-- INSERT SAMPLE DATA: order_items
-- ==============================================
INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal) VALUES
  -- Order 1
  (1, 1, 1, 1299.99, 1299.99),
  (1, 2, 1, 29.99, 29.99),
  (1, 4, 1, 49.99, 49.99),
  
  -- Order 2
  (2, 3, 1, 89.99, 89.99),
  
  -- Order 3
  (3, 5, 1, 399.99, 399.99),
  (3, 6, 1, 249.99, 249.99),
  
  -- Order 4
  (4, 11, 1, 39.99, 39.99),
  
  -- Order 5
  (5, 8, 3, 19.99, 59.97),
  (5, 9, 2, 59.99, 119.98),
  (5, 14, 2, 34.99, 69.98),
  
  -- Order 6
  (6, 10, 1, 149.99, 149.99),
  
  -- Order 7
  (7, 15, 5, 24.99, 124.95),
  
  -- Order 8
  (8, 16, 2, 89.99, 179.98),
  (8, 6, 1, 249.99, 249.99),
  (8, 7, 1, 129.99, 129.99),
  
  -- Order 9
  (9, 12, 1, 44.99, 44.99),
  (9, 13, 1, 24.99, 24.99),
  
  -- Order 10
  (10, 2, 2, 29.99, 59.98),
  (10, 4, 2, 49.99, 99.98);

-- ==============================================
-- VERIFY DATA
-- ==============================================
SELECT 'Categories' as Table_Name, COUNT(*) as Row_Count FROM categories
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Customers', COUNT(*) FROM customers
UNION ALL
SELECT 'Orders', COUNT(*) FROM orders
UNION ALL
SELECT 'Order_Items', COUNT(*) FROM order_items;

-- ==============================================
-- SAMPLE QUERIES FOR TESTING
-- ==============================================

-- Query 1: All products with categories
-- SELECT p.*, c.name as category_name FROM products p
-- JOIN categories c ON p.category_id = c.id;

-- Query 2: Top selling products
-- SELECT p.name, SUM(oi.quantity) as total_sold, SUM(oi.subtotal) as revenue
-- FROM products p
-- JOIN order_items oi ON p.id = oi.product_id
-- GROUP BY p.id
-- ORDER BY total_sold DESC;

-- Query 3: Customer order history
-- SELECT c.first_name, c.last_name, o.order_date, o.total_amount, o.status
-- FROM customers c
-- JOIN orders o ON c.id = o.customer_id
-- ORDER BY o.order_date DESC;

-- Query 4: Orders by status
-- SELECT status, COUNT(*) as count, SUM(total_amount) as total_revenue
-- FROM orders
-- GROUP BY status;

-- Query 5: Products low in stock
-- SELECT name, stock, price FROM products WHERE stock < 50 ORDER BY stock ASC;
