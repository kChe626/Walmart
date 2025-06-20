----------------------------------------------
-- Walmart Sales Analysis SQL Script
-- Cleans, loads, and analyzes Walmart sales data
----------------------------------------------

-- Drop table if exists to allow rerun without error
DROP TABLE IF EXISTS walmart_cleaned_data_python;

-- Create table with structure matching analysis needs
CREATE TABLE walmart_cleaned_data_python (
    invoice_id VARCHAR(50),
    branch VARCHAR(50),
    city VARCHAR(50),
    category VARCHAR(100),
    unit_price DECIMAL(10,2),
    quantity INT,
    date DATE,
    time TIME,
    payment_method VARCHAR(50),
    rating DECIMAL(3,1),
    profit_margin DECIMAL(5,2),
    total DECIMAL(10,2)
);

SELECT * FROM walmart_cleaned_data_python LIMIT 50;

---------------------------------
-- Analysis Queries
---------------------------------

-- Top-Selling Categories
SELECT 
    category, 
    SUM(quantity) AS total_units_sold
FROM walmart_cleaned_data_python
GROUP BY category
ORDER BY total_units_sold DESC
LIMIT 5;

-- Top-Selling Categories
SELECT 
    category, 
    SUM(quantity) AS total_units_sold
FROM walmart_cleaned_data_python
GROUP BY category
ORDER BY total_units_sold DESC
LIMIT 5;

-- Revenue by Payment Method
SELECT 
    payment_method, 
    ROUND(SUM(total), 2) AS total_revenue
FROM walmart_cleaned_data_python
GROUP BY payment_method
ORDER BY total_revenue DESC;

Monthly Revenue Trend
SELECT 
    branch, 
    ROUND(SUM(total), 2) AS total_revenue
FROM walmart_cleaned_data_python
GROUP BY branch
ORDER BY total_revenue DESC;

-- Average Profit Margin by Category
SELECT 
    YEAR(date) AS sales_year, 
    MONTH(date) AS sales_month, 
    ROUND(SUM(total), 2) AS monthly_revenue
FROM walmart_cleaned_data_python
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;

-- Top Branches by Revenue
SELECT 
    branch, 
    ROUND(SUM(total), 2) AS total_revenue
FROM walmart_cleaned_data_python
GROUP BY branch
ORDER BY total_revenue DESC;

-- Average Profit Margin by Category
SELECT 
    category, 
    ROUND(AVG(profit_margin), 2) AS avg_profit_margin
FROM walmart_cleaned_data_python
GROUP BY category
ORDER BY avg_profit_margin DESC;

-- Sales by Day of the Week
SELECT 
    DAYNAME(date) AS day_of_week, 
    ROUND(SUM(total), 2) AS total_revenue
FROM walmart_cleaned_data_python
GROUP BY day_of_week
ORDER BY total_revenue DESC;
