-- ============================================
-- Analysis Queries - E-Commerce Performance
-- Database: ecommerce_db
-- ============================================
USE ecommerce_db;

-- 1. Total revenue and orders
SELECT
    SUM(total_amount) AS total_revenue,
    COUNT(*)          AS total_orders,
    AVG(total_amount) AS avg_order_value
FROM orders
WHERE order_status = 'Delivered';

-- 2. Revenue by product category
SELECT
    product_name,
    SUM(total_amount) AS revenue
FROM orders
WHERE order_status = 'Delivered'
GROUP BY product_name
ORDER BY revenue DESC;

-- 3. Monthly sales trend
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount)                AS revenue,
    COUNT(*)                         AS orders
FROM orders
WHERE order_status = 'Delivered'
GROUP BY month
ORDER BY month;

-- 4. Top 5 customers by spend
SELECT
    o.customer_id,
    c.customer_gender,
    c.region,
    SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY o.customer_id, c.customer_gender, c.region
ORDER BY total_spent DESC
LIMIT 5;

-- 5. Repeat vs one-time customers
SELECT
    CASE WHEN order_count > 1 THEN 'Repeat Customer'
         ELSE 'One-time Customer' END AS customer_type,
    COUNT(*) AS num_customers
FROM (
    SELECT customer_id, COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) t
GROUP BY customer_type;

-- 6. Payment method distribution
SELECT
    payment_method,
    COUNT(*)          AS num_orders,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY payment_method
ORDER BY revenue DESC;

-- 7. Cancelled order impact
SELECT
    order_status,
    COUNT(*)          AS num_orders,
    SUM(total_amount) AS lost_revenue
FROM orders
GROUP BY order_status;

-- 8. Regional performance
SELECT
    c.region,
    COUNT(o.order_id)   AS total_orders,
    SUM(o.total_amount) AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.region
ORDER BY revenue DESC;

-- 9. Age group spending pattern
SELECT
    CASE
        WHEN customer_age < 25 THEN '18-25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN customer_age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '46+'
    END AS age_group,
    SUM(total_amount) AS revenue
FROM orders
WHERE order_status = 'Delivered'
GROUP BY age_group
ORDER BY revenue DESC;

-- 10. Month-over-month growth rate
SELECT
    month,
    revenue,
    ROUND((revenue - LAG(revenue) OVER (ORDER BY month))
          / LAG(revenue) OVER (ORDER BY month) * 100, 2) AS growth_pct
FROM (
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
           SUM(total_amount) AS revenue
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY month
) t;
