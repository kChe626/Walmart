-- Walmart Sales Analysis SQL Queries
-- Description: Business analysis on Walmart cleaned dataset

-- Top 5 product categories by units sold
SELECT 
    category, 
    SUM(quantity) AS total_units_sold
FROM walmart_cleaned
GROUP BY category
ORDER BY total_units_sold DESC
LIMIT 5;

-- Monthly revenue trend
SELECT 
    YEAR(date) AS sales_year, 
    MONTH(date) AS sales_month, 
    ROUND(SUM(total), 2) AS monthly_revenue
FROM walmart_cleaned
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;

-- Revenue by branch
SELECT 
    branch, 
    ROUND(SUM(total), 2) AS total_revenue
FROM walmart_cleaned
GROUP BY branch
ORDER BY total_revenue DESC;

-- Revenue by payment method
SELECT 
    payment_method, 
    ROUND(SUM(total), 2) AS total_revenue
FROM walmart_cleaned
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- Average profit margin by category
SELECT 
    category, 
    ROUND(AVG(profit_margin), 2) AS avg_profit_margin
FROM walmart_cleaned
GROUP BY category
ORDER BY avg_profit_margin DESC;

-- Day-of-week revenue
SELECT 
    DAYNAME(date) AS day_of_week, 
    ROUND(SUM(total), 2) AS total_revenue
FROM walmart_cleaned
GROUP BY day_of_week
ORDER BY total_revenue DESC;
