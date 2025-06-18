![Python](https://img.shields.io/badge/Python-3776AB.svg?style=for-the-badge&logo=Python&logoColor=white)
![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/power_bi-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

#  Walmart Sales Data Cleaning & Analysis Project

This project demonstrates a complete data pipeline for Walmart sales data using **Python**, **SQL**, and **Power BI**. It covers everything from detecting encoding issues, cleaning raw data, exporting to MySQL, querying with SQL for insights, and finally visualizing the results using Power BI.

---

##  Dateset

Dataset Overview

The dataset contains:

    invoice_id — Unique ID for each transaction

    branch — Store branch code

    city — City location

    category — Product category

    unit_price — Price per item (originally string with $)

    quantity — Number of units purchased

    date — Date of transaction

    time — Time of transaction

    payment_method — Type of payment (cash, e-wallet, credit card)

    rating — Customer rating

    profit_margin — Store profit margin

---

##  Data Cleaning Process (Python)

- Removed duplicates: 51 duplicate records identified and removed to ensure data integrity.
  ```sql
  df.drop_duplicates(inplace=True)
  ```
- Handled missing values: Dropped 31 rows missing critical fields (unit_price, quantity).
  ```sql
  df.dropna(subset=['unit_price', 'quantity'], inplace=True)
  ```
- Cleaned and transformed fields:
  ```sql
  df['unit_price'] = df['unit_price'].str.replace('$', '', regex=False).astype(float)
  df['total'] = df['unit_price'] * df['quantity']
  ```
- Convert date
  ```sql
  df['date'] = pd.to_datetime(df['date'], format='%d/%m/%y')
  ```

- Saved cleaned data


  [See full cleaning code](https://github.com/kChe626/Walmart/blob/main/Walmart_clean_python.ipynb)

---

##  SQL Analysis & Business Insights
Below are example SQL queries used to analyze the Walmart dataset.

### Top-Selling Categories
Identify the most popular product categories by units sold.
```sql
SELECT 
    category, 
    SUM(quantity) AS total_units_sold
FROM walmart_cleaned_data_python
GROUP BY category
ORDER BY total_units_sold DESC
LIMIT 5;
```

### Revenue by Payment Method
See which payment methods generate the most revenue.
```sql
SELECT 
    payment_method, 
    ROUND(SUM(total), 2) AS total_revenue
FROM walmart_cleaned_data_python
GROUP BY payment_method
ORDER BY total_revenue DESC;
```

###  Monthly Revenue Trend
Track how revenue changes over time to identify seasonality.
```sql
SELECT 
    YEAR(date) AS sales_year, 
    MONTH(date) AS sales_month, 
    ROUND(SUM(total), 2) AS monthly_revenue
FROM walmart_cleaned_data_python
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;
```
- [See full analysis code SQL](https://github.com/kChe626/Walmart/blob/main/walmart_analysis_data_SQL.sql)
---

##  Power BI Dashboard

An interactive Power BI dashboard showcasing:

- **YTD vs PYTD Revenue**
- **Total Sales by Branch & Product Category**
- **Customer Behavior by Time of Day**
- **Branch-wise Comparison Metrics**

 **Dashboard Preview**:  
![Dashboard](https://github.com/kChe626/Walmart/blob/main/Walmart%20Power%20Bi%20Dashboard.gif)

---


## Files
- Python: [Python Cleaning Script](https://github.com/kChe626/Walmart/blob/main/Walmart_clean_python.ipynb)
- SQL: [SQL Analysis Script](https://github.com/kChe626/Walmart/blob/main/walmart_analysis_data_SQL.sql)
- PowerBi Dashboard: [Walmart Dashboard PowerBI](https://github.com/kChe626/Walmart/blob/main/Walmart_Dashboard.pbix)

---

## Datasource


- Walmart dataset from [https://www.kaggle.com/datasets/najir0123/walmart-10k-sales-datasets]
