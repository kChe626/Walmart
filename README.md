## Walmart Sales Data Processing

This project demonstrates an end-to-end data processing pipeline for Walmart sales data, showcasing skills in data cleaning, transformation, and database integration. The workflow processes raw transactional data into analysis-ready insights stored in a MySQL database.

**Skills Demonstrated:**
- Real-world data cleaning (missing values, duplicates, type conversion)
- Currency handling and numerical transformation
- MySQL database integration


**Key Highlights:**
1. **Data Ingestion & Encoding Detection**  
   - Auto-detected file encoding using `chardet` to handle potential character issues
   - Loaded 10,051 records with 11 features from CSV

2. **Data Quality Management**  
   - Removed 51 duplicates and 31 incomplete records
   - Handled currency formatting in `unit_price` ($74.69 → 74.69 float)
   - Added data integrity checks with `df.info()`/`df.describe()`

3. **Feature Engineering**  
   - Created `total` sales column (unit_price × quantity)
   - Preserved profit margin calculations for business insights

4. **Database Integration**  
   - Established MySQL connection using `sqlalchemy`
   - Successfully exported 9,969 cleaned records to `walmart_db`
   - Demonstrated production-ready data pipeline capabilitie


**Outcome:** Clean, analysis-ready dataset stored in SQL format, enabling downstream business intelligence and sales performance analysis. The pipeline can process new Walmart transaction data with minimal modification.
