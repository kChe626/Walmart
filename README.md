# Walmart Sales Data Cleaning & Analysis Project

This project demonstrates an end-to-end data processing pipeline for Walmart sales data, showcasing skills in data cleaning, transformation, and database integration. The workflow processes raw transactional data into analysis-ready insights stored in a MySQL database.
Walmart dataset to provided from kaggle

---

## Project Overview

The goal of this project is to:

- Detect and handle file encoding issues
- Clean column names and data types
- Remove duplicates and missing values
- Engineer new features
- Export cleaned data to CSV and MySQL
- Run SQL queries to answer business-related questions

---

## Technologies Used

- **Python**
  - pandas
  - chardet
  - sqlalchemy
  - pymysql
- **MySQL**
- Jupyter Notebook

---

## Installation

1. Clone the repo:
```bash
git clone https://github.com/yourusername/walmart-data-cleaning.git
cd walmart-data-cleaning
```

2. Install dependencies:
```bash
pip install pandas chardet sqlalchemy pymysql mysql-connector-python
```

---

##  Data Cleaning (Python)

Steps performed:
- **Encoding Detection**: Using `chardet` to auto-detect encoding of `Walmart.csv`.
- **Data Loading**: Reading the file into a DataFrame with proper encoding.
- **Duplicates & Nulls**: Removed duplicates and missing values.
- **Data Type Fixes**: Converted `unit_price` from string to float.
- **Column Normalization**: Renamed columns to lowercase.
- **Data Export**: Cleaned data saved as CSV and uploaded to MySQL.

---

## SQL Analysis & Business Insights

Here are some of the questions answered using SQL:

### 1. What are the different payment methods and their usage?
```sql
SELECT payment_method, COUNT(*) as no_payments, SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method;
```

### 2. What’s the highest-rated category per branch?
```sql
SELECT branch, category, AVG(rating) as avg_rating
FROM walmart
GROUP BY branch, category
ORDER BY branch, avg_rating DESC;
```

### 3. Busiest day per branch?
```sql
SELECT branch, DATE_FORMAT(STR_TO_DATE(`date`, '%d/%m/%y'), '%W') AS day_name, COUNT(*) AS no_transactions
FROM walmart
GROUP BY branch, day_name
ORDER BY branch, no_transactions DESC;
```

### 4. Average, min, max rating per city/category
```sql
SELECT city, category, AVG(rating), MIN(rating), MAX(rating)
FROM walmart
GROUP BY city, category;
```

### 5. Profit by Category
```sql
SELECT category, SUM(total * profit_margin) AS profit
FROM walmart
GROUP BY category
ORDER BY profit DESC;
```

### 6. Most Common Payment Method per Branch
```sql
WITH cte AS (
  SELECT branch, payment_method, COUNT(*) as total_trans,
         RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as ranking
  FROM walmart
  GROUP BY branch, payment_method
)
SELECT * FROM cte WHERE ranking = 1;
```

### 7. Time of Day Analysis
Categorized into Morning, Afternoon, Evening:
```sql
SELECT branch,
  CASE 
    WHEN HOUR(`time`) < 12 THEN 'Morning'
    WHEN HOUR(`time`) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS part_of_day,
  COUNT(*) AS total_transactions
FROM walmart
GROUP BY branch, part_of_day;
```

### 8. Revenue Decrease Year-over-Year (2022 to 2023)
```sql
WITH revenue_2022 AS (
  SELECT branch, SUM(total) AS revenue
  FROM walmart
  WHERE EXTRACT(YEAR FROM STR_TO_DATE(date, '%d/%m/%y')) = 2022
  GROUP BY branch
),
revenue_2023 AS (
  SELECT branch, SUM(total) AS revenue
  FROM walmart
  WHERE EXTRACT(YEAR FROM STR_TO_DATE(date, '%d/%m/%y')) = 2023
  GROUP BY branch
)
SELECT 
  r2.branch,
  r2.revenue AS last_year_revenue,
  r3.revenue AS current_year_revenue,
  ROUND((r2.revenue - r3.revenue) / r2.revenue * 100, 2) AS revenue_difference_percentage
FROM revenue_2022 r2
JOIN revenue_2023 r3 ON r2.branch = r3.branch
WHERE r2.revenue > r3.revenue
ORDER BY revenue_difference_percentage DESC;
```

---

##  Files Included

- `walmart_cleaning_script.py` — Python script for data cleaning
- `walmart_cleaned_data.csv` — Cleaned dataset
- `sql_analysis.sql` — SQL file with all analysis queries
- `README.md` — Project overview and documentation

---

## Acknowledgments

- Walmart dataset from [https://www.kaggle.com/datasets/najir0123/walmart-10k-sales-datasets]
