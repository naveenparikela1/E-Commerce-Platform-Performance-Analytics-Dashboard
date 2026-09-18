-- ============================================
-- E-Commerce Performance Analysis - Schema
-- Database: ecommerce_db
-- ============================================

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS customers (
    customer_id     VARCHAR(10) PRIMARY KEY,
    customer_age    INT,
    customer_gender VARCHAR(10),
    region          VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS products (
    product_id       INT AUTO_INCREMENT PRIMARY KEY,
    product_name     VARCHAR(100),
    product_category VARCHAR(50),
    unit_price       DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id       INT PRIMARY KEY,
    customer_id    VARCHAR(10),
    order_date     DATE,
    product_name   VARCHAR(100),
    quantity       INT,
    unit_price     DECIMAL(10, 2),
    discount       DECIMAL(5, 2),
    payment_method VARCHAR(20),
    order_status   VARCHAR(20),
    total_amount   DECIMAL(12, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Load CSV data (adjust path as needed)
-- LOAD DATA INFILE '/path/to/ecommerce_data.csv'
-- INTO TABLE orders
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- Create indexes for faster queries
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_orders_customer ON orders(customer_id);
