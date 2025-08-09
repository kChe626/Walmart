# **Walmart Sales Analysis — Python Cleaning, SQL Analysis & Power BI Dashboard**  
![Python](https://img.shields.io/badge/Python-3776AB.svg?style=for-the-badge&logo=Python&logoColor=white)
![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/power_bi-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
---

## **Overview**  
This project demonstrates a complete data pipeline for Walmart sales data using **Python**, **MySQL**, and **Power BI**.  
The process covers data cleaning in Python, SQL-based business analysis, and an interactive Power BI dashboard to visualize sales performance.

---

## **Dataset**
- **Source:** [Walmart.csv](https://github.com/kChe626/Walmart/blob/main/Walmart.csv)  
- **Columns:** city, branch, category, quantity, unit_price, total, payment_method, date, and other transaction details

---

## **Objectives**
- Clean and standardize sales data using Python  
- Run SQL queries for business insights on categories, branches, revenue trends, and payment methods  
- Visualize performance metrics in Power BI for interactive exploration

---

## **Data Cleaning Process (Python)**
**Key Steps:**
- Standardized column names for easier handling  
- Cleaned text fields (lowercase, trimmed spaces)  
- Converted `date` to proper datetime format  
- Cleaned numeric fields and computed `total` column  
- Removed duplicates and validated dataset

**Example Snippets:**  
```python
# Standardize column names
df.columns = df.columns.str.strip().str.lower().str.replace(' ', '_')

# Clean unit_price
df['unit_price'] = (
    df['unit_price'].astype(str)
    .str.replace(r'[\$,]', '', regex=True)
    .str.strip()
)
df['unit_price'] = pd.to_numeric(df['unit_price'], errors='coerce').fillna(0)

# Compute total
df['total'] = df['quantity'] * df['unit_price']
```

 **Full Cleaning Script:** [Walmart_clean_python.ipynb](https://github.com/kChe626/Walmart/blob/main/Walmart_clean_python.ipynb)  
 **Cleaned Dataset:** [walmart_cleaned.csv](https://github.com/kChe626/Walmart/blob/main/walmart_cleaned.csv)

---

## **SQL Analysis**
**Objectives:**
- Identify top-selling categories  
- Track monthly revenue trends  
- Compare branch performance  
- Analyze payment method contributions  

**Example Queries:**
```sql
-- Top 5 product categories by units sold
SELECT category, SUM(quantity) AS total_units_sold
FROM walmart_cleaned
GROUP BY category
ORDER BY total_units_sold DESC
LIMIT 5;

-- Monthly sales trend
SELECT YEAR(date) AS sale_year, MONTH(date) AS sale_month, SUM(total) AS monthly_revenue
FROM walmart_cleaned
GROUP BY sale_year, sale_month
ORDER BY sale_year, sale_month;
```

 **Full Analysis Script:** [walmart_sql_analysis.sql](https://github.com/kChe626/Walmart/blob/main/walmart_sql_analysis.sql)

---

## **Key Insights**
- Certain product categories drive the majority of unit sales  
- Revenue trends reveal seasonal peaks and slow periods  
- Branch-level performance varies significantly across locations  
- Payment preferences differ by customer segment

---

## **Preview**
![Walmart Power BI Dashboard](https://github.com/kChe626/Walmart/blob/main/Walmart%20Power%20Bi%20Dashboard.gif)

---

## **How to Open**
1. Download the Power BI dashboard: [Walmart_Dashboard.pbix](https://github.com/kChe626/Walmart/blob/main/Walmart_Dashboard.pbix)  
2. Open in Power BI Desktop  
3. Refresh the data connection to use `walmart_cleaned.csv`  

---

## **Use Cases**
- **Retail Performance Monitoring:** Track sales and revenue over time  
- **Product Strategy:** Identify high-demand categories  
- **Branch Optimization:** Compare branch performance to reallocate resources  
- **Customer Insights:** Understand payment method trends

---

## **Business Relevance**
The dashboard delivers actionable insights for retail operations teams to monitor branch performance, manage inventory levels, and optimize product assortment. Identifying peak sales periods and high-margin categories helps improve stock allocation and supply chain efficiency.

---

## **Files**
- [Python Cleaning Script](https://github.com/kChe626/Walmart/blob/main/Walmart_clean_python.ipynb)
- [Cleaned Dataset](https://github.com/kChe626/Walmart/blob/main/walmart_cleaned.csv)  
- [SQL Analysis Script](https://github.com/kChe626/Walmart/blob/main/walmart_sql_analysis.sql)  
- [Power BI Dashboard](https://github.com/kChe626/Walmart/blob/main/Walmart_Dashboard.pbix)  

