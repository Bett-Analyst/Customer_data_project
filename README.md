# Customer Retention Analysis

## Overview
This project showcases an in-depth analysis of customer demographics, financial attributes, and behavioral patterns using SQL, Excel, and Power BI. The dataset is designed to facilitate predictive modeling for customer retention, exploratory data analysis (EDA), feature engineering, and visualization. The final interactive Power BI dashboard provides insights into key customer trends, financial behaviors, and retention rates.

This project demonstrates my expertise in:
- Data Cleaning (SQL)
- Data Analysis (SQL & Excel)
- Data Visualization (Power BI)
- Feature Engineering (SQL & DAX)

**View the Dashboard | Download customer_data_dashboard.pbix**

## Project Type
- Data Analysis

## Tools Used
- **PostgreSQL**: For data cleaning and transformation.
- **Excel**: For pivot tables and additional analysis.
- **Power BI**: For interactive dashboard creation and visualization.

## Project Details

### 1. Data Cleaning (Using SQL)
Before analysis, the dataset was cleaned and standardized in PostgreSQL. The following steps were taken:

#### i. Load Data into PostgreSQL
- The dataset was imported into a PostgreSQL database for structured querying and transformations.

#### ii. Check for Missing Values
```sql
SELECT Customer_ID, COUNT(*)
FROM customer_data
WHERE Age IS NULL OR Annual_Income IS NULL OR Target IS NULL
GROUP BY Customer_ID;
```
- No missing values were found.

#### iii. Check for Duplicates
```sql
SELECT Customer_ID, COUNT(*)
FROM customer_data
GROUP BY Customer_ID
HAVING COUNT(*) > 1;
```
- No duplicate entries were found.

#### iv. Check for Outliers
```sql
SELECT *
FROM customer_data
WHERE Age > 100 OR Credit_Score > 850;
```
- No significant outliers were found.

#### v. Standardization
```sql
UPDATE customers
SET Region = UPPER(Region);
```
- Ensured consistent casing for categorical data.

- **Final cleaned SQL file:** `Customer_Data_File.sql`

### 2. Data Analysis

#### a. SQL Analysis
##### i. Summary Statistics
```sql
SELECT
    Employment_Status,
    AVG(Annual_Income) as Avg_Income,
    AVG(Spending_Score) as Avg_Spending,
    AVG(Online_Shopping_Frequency) as Avg_Shopping_Freq,
    COUNT(*) as Customer_Count,
    SUM(Target) as Retained_Count
FROM customers
GROUP BY Employment_Status
ORDER BY Avg_Income DESC;
```
- **Downloaded file:** `Averages_and_counts_by_key_variables.csv`

##### ii. Customer Retention by Category
```sql
SELECT
    Marital_Status,
    COUNT(*) as Total_Customers,
    SUM(Target) as Retained_Customers,
    ROUND((SUM(Target) * 100.0 / COUNT(*)), 2) as Retention_Rate
FROM customer_data
GROUP BY Marital_Status;
```
- **Downloaded file:** `Customer_retention_by_category.csv`

##### iii. Correlation Insights
```sql
SELECT
    ROUND(AVG(CASE WHEN Target = 1 THEN Credit_Score ELSE 0 END), 2) as Retained_Credit,
    ROUND(AVG(CASE WHEN Target = 0 THEN Credit_Score ELSE 0 END), 2) as Non_Retained_Credit
FROM customer_data;
```
- **Downloaded file:** `correlation_insights.csv`

#### b. Excel Analysis
- Created Pivot Tables:
  - Rows: `Employment_Status`
  - Columns: `Target`
  - Values: Count of `Customer_ID`
- **File saved as:** `pivot_table.csv`

### 3. Data Visualization (Power BI)

#### Steps
##### i. Load customer_data.csv into Power BI
##### ii. Create an Income Bin Column (DAX)
```DAX
Income_Bin =
SWITCH(
    TRUE(),
    [Annual_Income] <= 25000, "0-25K",
    [Annual_Income] <= 50000, "25K-50K",
    [Annual_Income] <= 75000, "50K-75K",
    "75K+"
)
```
##### iii. Create Income Bin Table (SQL)
```sql
SELECT
    CASE
        WHEN Annual_Income BETWEEN 0 AND 25000 THEN '0-25K'
        WHEN Annual_Income BETWEEN 25001 AND 50000 THEN '25K-50K'
        WHEN Annual_Income BETWEEN 50001 AND 75000 THEN '50K-75K'
        ELSE '75K+'
    END AS Income_Bin,
    ROUND(AVG(Spending_Score)::NUMERIC, 2) AS Avg_Spending_Score,
    ROUND(AVG(Online_Shopping_Frequency)::NUMERIC, 2) AS Avg_Shopping_Freq,
    ROUND(AVG(Target)::NUMERIC, 2)::FLOAT AS Retention_Rate,
    COUNT(*) AS Customer_Count
FROM customers
GROUP BY
    CASE
        WHEN Annual_Income BETWEEN 0 AND 25000 THEN '0-25K'
        WHEN Annual_Income BETWEEN 25001 AND 50000 THEN '25K-50K'
        WHEN Annual_Income BETWEEN 50001 AND 75000 THEN '50K-75K'
        ELSE '75K+'
    END;
```
- **File downloaded as:** `income_bin.csv`
##### iv. Connect Tables in Power BI
- Linked `income_bin` table to `customer_data` table via `Income_Bin` column.

##### v. Create New Measure for Customer Count
```DAX
Count_of_Customer_ID = COUNT(Customer_Data[Customer_ID])
```
##### vi. Visualizations
- **Bar Chart:**
  - X-Axis: `Employment_Status`
  - Y-Axis: `Count of Customer_ID`
  - Legend: `Target`
- **Pie Chart:**
  - Values: `Count of Customer_ID`
  - Legend: `Marital_Status`
- **Scatter Plot:**
  - X-Axis: `Annual_Income`
  - Y-Axis: `Spending_Score`
  - Color: `Target`
  - Size: `Online_Shopping_Frequency`
- **Donut Chart:**
  - Category: `Region`
  - Values: `Customer_ID`

- **Final Power BI Dashboard:** `Customer_data_dashboard.pbix`

## Key Skills Demonstrated
- **Data Cleaning:** Standardizing and validating data in SQL.
- **SQL Analysis:** Extracting insights through queries and calculations.
- **Excel Pivot Tables:** Summarizing and analyzing customer trends.
- **Power BI Visualization:** Creating interactive dashboards.
- **DAX & SQL Feature Engineering:** Binning income levels and analyzing retention.

## Usage
- **Explore the Dashboard:** Open `customer_data_dashboard.pbix` in Power BI Desktop.
- **View the Dataset:** `customer_data.csv` (raw) and `Customer_Data_File.sql` (cleaned SQL dataset).

## About This Project
This project is part of my data analysis portfolio and demonstrates my ability to transform raw customer data into meaningful insights using SQL, Excel, and Power BI. It highlights my expertise in data cleaning, analysis, and visualization for customer retention and business intelligence.

**Contributors:**
Emmanuel kipkurui- Data Analyst & Project Lead

