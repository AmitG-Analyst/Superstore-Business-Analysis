-- Q1: Profitability by Region
SELECT Region,
       ROUND(SUM(Sales), 2) AS total_sales,
       ROUND(SUM(Profit), 2) AS total_profit,
       ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM orders
GROUP BY Region
ORDER BY total_profit ASC;

-- Q2: Sub-Categories sold at a net loss
SELECT "Sub-Category",
       ROUND(SUM(Sales), 2) AS total_sales,
       ROUND(SUM(Profit), 2) AS total_profit,
       ROUND(AVG(Discount), 4) AS avg_discount
FROM orders
GROUP BY "Sub-Category"
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;

-- Q3: Do higher discounts consistently destroy profit margins, or only in specific categories?
SELECT Category,
       ROUND(SUM(Sales), 2) AS total_sales,
       ROUND(SUM(Profit), 2) AS total_profit,
       ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin_pct,
       ROUND(AVG(Discount), 4) AS avg_discount
FROM orders
GROUP BY Category
ORDER BY total_profit ASC;

-- Finding: Discounts do not consistently destroy margins across all categories.
-- Furniture is the outlier — 17.39% avg discount results in only 2.49% profit margin.
-- Office Supplies and Technology maintain healthy ~17% margins despite similar discount levels.
-- Furniture's losses likely driven by high shipping/handling costs and returns, not discounting alone.

-- Q4: Which customer segment generates the most revenue but the least profit?
SELECT Segment,
       ROUND(SUM(Sales), 2) AS total_sales,
       ROUND(SUM(Profit), 2) AS total_profit,
       ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin_pct
FROM orders
GROUP BY Segment
ORDER BY profit_margin_pct ASC;

-- Finding: Consumer segment leads in revenue at $1.16M but has the lowest margin at 11.55%.
-- Counterintuitive — corporate bulk buying would typically suggest lower margins there.
-- Consumer likely more price-sensitive, driving higher discount-seeking behavior.
-- Home Office smallest in revenue but healthiest margin at 14.03% — fewer, more deliberate purchases.
-- Next investigation: whether Furniture is the primary drag on Consumer segment margins.

-- Q5: Does shipping mode choice correlate with profitability across regions?
SELECT "Ship Mode",
       Region,
       ROUND(SUM(Sales), 2) AS total_sales,
       ROUND(SUM(Profit), 2) AS total_profit,
       ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin_pct
FROM orders
GROUP BY Region, "Ship Mode"
ORDER BY profit_margin_pct ASC;

-- Finding: Same Day shipping in South is a significant outlier at -8.39% margin — needs investigation.
-- Central region shows a consistent profit ceiling of 6-9% regardless of shipping mode used.
-- Same Day in East and West shows strongest margins (18%+) but low sales volume — not scalable yet.
-- Central findings here triangulate with Q1 — confirming it is a margin problem, not volume.

-- Q6: Which states are underperforming despite high order volume?
SELECT State,
       COUNT(*) AS number_of_orders,
       ROUND(SUM(Sales), 2) AS total_sales,
       ROUND(SUM(Profit), 2) AS total_profit,
       ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct
FROM orders
GROUP BY State
ORDER BY profit_margin_pct ASC;

-- Finding: Texas (985 orders, -15.12%), Pennsylvania (587 orders, -13.35%) and Illinois
-- (492 orders, -15.73%) are the clearest high-volume, low-profit states.
-- These states are losing money at scale — not a margin problem on paper, a dollar problem in reality.
-- Hypothesis: Furniture heavy sales mix in these states likely driving losses, consistent with Q2/Q3.
-- California (2001 orders, 16.69%) is a positive outlier — product mix investigation recommended.

-- Q7: What does the profit trend look like over time, year over year?

-- VERSION 1 (does NOT work -- included to document why)
-- STRFTIME('%Y', "Order Date") fails here because SQLite's STRFTIME
-- requires dates in YYYY-MM-DD format. Our dates are stored as M/D/YYYY
-- (e.g. "1/10/2014"), so SQLite cannot parse them and returns NULL.
SELECT STRFTIME('%Y', "Order Date") AS order_year,
       ROUND(SUM(Sales), 2) AS total_sales,
       ROUND(SUM(Profit), 2) AS total_profit,
       ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct
FROM orders
GROUP BY STRFTIME('%Y', "Order Date");

-- VERSION 2 (correct -- use this)
-- SUBSTR extracts the last 4 characters of the date string, which is
-- always the year regardless of whether month/day are 1 or 2 digits.
-- LENGTH("Order Date") - 3 calculates the starting position of the year.
SELECT SUBSTR("Order Date", LENGTH("Order Date") - 3, 4) AS order_year,
       ROUND(SUM(Sales), 2) AS total_sales,
       ROUND(SUM(Profit), 2) AS total_profit,
       ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct
FROM orders
GROUP BY SUBSTR("Order Date", LENGTH("Order Date") - 3, 4);

-- Finding: Sales grew consistently from $484K (2014) to $733K (2017).
-- Profit margin improved from 10.23% (2014) to 13.43% (2016) before dipping to 12.74% in 2017.
-- 2015 shows a mix shift -- sales dipped slightly but margin jumped from 10.23% to 13.1%,
-- suggesting the business moved toward more profitable products.
-- 2017 margin dip despite record sales likely driven by promotional discounting or new lower-margin
-- products -- warrants further investigation by product category and region.
-- Next step: product-region-year breakdown to understand whether growth is sustainable.