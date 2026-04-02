-- Basic Metrics Exploration
-- Dataset: Sample Superstore | 9,994 rows

-- 1. Total Sales
SELECT ROUND(SUM(Sales), 2) AS total_sales
FROM orders;

-- 2. Total Profit
SELECT ROUND(SUM(Profit), 2) AS total_profit
FROM orders;

-- 3. Count of Distinct Orders
SELECT COUNT(DISTINCT "Order ID") AS total_orders
FROM orders;

-- 4. Average Discount
SELECT ROUND(AVG(Discount), 4) AS avg_discount
FROM orders;

-- 5. Date Range of Orders
-- Note: Order Date stored as text (M/D/YYYY) — MIN/MAX sorts alphabetically, not by date
-- Actual confirmed range: Jan 10, 2014 – Dec 30, 2017
SELECT MIN("Order Date") AS earliest_order,
       MAX("Order Date") AS latest_order
FROM orders;

-- Confirmed range: Jan 10, 2014 – Dec 30, 2017