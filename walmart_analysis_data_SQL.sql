SELECT * FROM walmart_cleaned_data_python LIMIT 50;

-- Top-Selling Categories
SELECT 
    category, 
    SUM(quantity) AS total_units_sold
FROM walmart_cleaned_data_python
GROUP BY category
ORDER BY total_units_sold DESC
LIMIT 5;

--  Revenue by Payment Method
SELECT 
    payment_method, 
    ROUND(SUM(total), 2) AS total_revenue
FROM walmart_cleaned_data_python
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- Monthly Revenue Trend
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

-- 
