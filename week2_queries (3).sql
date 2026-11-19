-- Week 2: SQL for Data Analysis
-- This script uses the actual supplied 200-row sales CSV dataset.
-- Import sales_data.csv into a SQL table named sales before running queries.
-- Column names: order_id, customer_name, order_date, category, sub_category,
-- product_name, quantity, unit_price, total_price, region

-- 1. Display all rows
SELECT * FROM sales;

-- 2. Filter orders with total_price greater than 1000
SELECT *
FROM sales
WHERE total_price > 1000;

-- 3. Total revenue by product category
SELECT category, SUM(total_price) AS total_revenue
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

-- 4. Sort records by region and order total
SELECT *
FROM sales
ORDER BY region ASC, total_price DESC;

-- 5. Aggregate values: total sales, average order value, and order count
SELECT SUM(total_price) AS total_sales,
       AVG(total_price) AS average_order_value,
       COUNT(*) AS order_count
FROM sales;

-- 6. Average order value by customer
SELECT customer_name, AVG(total_price) AS average_order_value
FROM sales
GROUP BY customer_name
ORDER BY average_order_value DESC;

-- 7. Top 5 customers by total spending
SELECT customer_name, SUM(total_price) AS total_spent
FROM sales
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- 8. Customer order counts
SELECT customer_name, COUNT(*) AS order_count
FROM sales
GROUP BY customer_name
ORDER BY order_count DESC;

-- 9. Subquery: orders above the overall average total_price
SELECT *
FROM sales
WHERE total_price > (SELECT AVG(total_price) FROM sales);

-- 10. CASE: categorize order totals
SELECT order_id, customer_name, total_price,
       CASE
           WHEN total_price >= 10000 THEN 'High'
           WHEN total_price >= 3000 THEN 'Medium'
           ELSE 'Low'
       END AS order_value_category
FROM sales
ORDER BY total_price DESC;

-- 11. Example JOIN (self join): pair orders from same customer
-- with distinct order IDs, to demonstrate joining using this dataset.
SELECT a.customer_name, a.order_id AS order_a, b.order_id AS order_b
FROM sales a
JOIN sales b ON a.customer_name = b.customer_name
             AND a.order_id < b.order_id
ORDER BY a.customer_name, a.order_id;
