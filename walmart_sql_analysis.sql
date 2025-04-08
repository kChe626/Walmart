SELECT * FROM walmart;

SELECT COUNT(*) FROM walmart;

SELECT 
	payment_method,
    COUNT(*)
FROM walmart
GROUP BY payment_method;

SELECT COUNT(DISTINCT Branch)
FROM walmart;

SELECT MAX(quantity) FROM walmart;

# Business Problems
-- Find different payment method and number of transactions, and numver of quanity sold

SELECT 
	payment_method,
    COUNT(*) as no_payments,
    SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method;

-- What is the highest-rated category in each branch, display the branch, category and avg rating

SELECT *
FROM
(	SELECT 
		branch,
		category,
		AVG(rating) as avg_rating,
    RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) as rank_position
	FROM walmart
	GROUP BY 1, 2
) AS rank_position1
WHERE rank_position = 1;

-- Find the busiest day for each branch based on the nuumver of transaction

SELECT *
FROM (
  SELECT 
    branch,
    DATE_FORMAT(STR_TO_DATE(`date`, '%d/%m/%y'), '%W') AS day_name,
    COUNT(*) AS no_transactions,
    RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank_order
  FROM walmart
  GROUP BY branch, day_name
) AS ranked
WHERE rank_order = 1;

-- Calculate the total quantity of items sold per payment method, number of qty sold

SELECT 
	payment_method,
    SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method;

-- Find the avg, min, max rating of products for each city.
-- List the city, avg_rating, and max_rating.

SELECT
	city,
    category,
    AVG(rating) as avg_rating,
	MIN(rating) as min_rating,
    MAX(rating) as max_rating
FROM walmart
GROUP BY 1,2
ORDER BY 1;

-- Calculate the total profit for each category by total_profit as (unit_price * quantity * profit_margin)
-- List category and total_profit, order from highest to lowest.

SELECT 
	category,
    SUM(total) as total_revene,
    SUM(total * profit_margin) as profit
FROM walmart
GROUP BY 1;

-- Determine the most common payment for each branch.

WITH cte
AS
(SELECT
	branch,
    payment_method,
    COUNT(*) as total_trans,
    RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as ranking
FROM walmart
GROUP BY 1,2
)
SELECT *
FROM cte
WHERE ranking = 1;

-- Categorize sales into 3 groups. Morning, Afternnon, and Evening
-- Find which of the shift and number of invoices

SELECT 
  branch,
  CASE 
    WHEN HOUR(`time`) < 12 THEN 'Morning'
    WHEN HOUR(`time`) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS part_of_day,
  COUNT(*) AS total_transactions
FROM walmart
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

-- Which 5 branch have the highest decrese ratio in
-- revenure compared to last year (current year: 2023)

-- rdr == last_rev-cr_rev/ls_rev*100


SELECT 
  *,
  EXTRACT(YEAR FROM STR_TO_DATE(`date`, '%d/%m/%y')) AS formatted_date
FROM walmart;
-- 2022 sales

WITH revenue_2022 AS (
  SELECT
    branch,
    SUM(total) AS revenue
  FROM walmart
  WHERE EXTRACT(YEAR FROM STR_TO_DATE(date, '%d/%m/%y')) = 2022
  GROUP BY branch
),
revenue_2023 AS (
  SELECT
    branch,
    SUM(total) AS revenue
  FROM walmart
  WHERE EXTRACT(YEAR FROM STR_TO_DATE(date, '%d/%m/%y')) = 2023
  GROUP BY branch
)

SELECT 
  ls.branch,
  ls.revenue AS last_year_revenue,
  cs.revenue AS current_year_revenue,
  ROUND((ls.revenue - cs.revenue) / ls.revenue * 100, 2) AS revenue_difference_percentage
FROM revenue_2022 AS ls
JOIN revenue_2023 AS cs
  ON ls.branch = cs.branch
WHERE ls.revenue > cs.revenue
ORDER BY 4 DESC;

	




