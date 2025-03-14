drop table customer_data;
CREATE TABLE customer_data (
	Customer_ID VARCHAR(30) PRIMARY KEY,
	Age INT,	
	Gender VARCHAR(30),
	Annual_Income INT,
	Spending_Score INT,
	Region VARCHAR(30),
	Marital_Status VARCHAR(30),
	Num_of_Children INT,
	Employment_Status VARCHAR(30),
	Credit_Score INT,
	Online_Shopping_Frequency INT,
	Target INT
);

-- Identify the missing values
SELECT Customer_ID, COUNT(*) 
FROM customer_data 
WHERE Age IS NULL OR Annual_Income IS NULL OR Target IS NULL 
GROUP BY Customer_ID;

-- Check for duplicates 
SELECT Customer_ID, COUNT(*) 
FROM customer_data 
GROUP BY Customer_ID 
HAVING COUNT(*) > 1;

-- Check for outliers
SELECT * 
FROM customer_data
WHERE Age > 100 OR Credit_Score > 850;


-- Calculate averages and counts by key variables
SELECT 
    Employment_Status,
    ROUND(AVG(Annual_Income), 2) as Avg_Income,
    ROUND(AVG(Spending_Score), 2) as Avg_Spending,
    ROUND(AVG(Online_Shopping_Frequency), 2) as Avg_Shopping_Freq,
    COUNT(*) as Customer_Count,
    SUM(Target) as Retained_Count
FROM customer_data
GROUP BY Employment_Status
ORDER BY Avg_Income DESC;

--Customer retention by category -Analyze Target (0 = not retained, 1 = retained) by Marital_Status
SELECT 
    Marital_Status,
    COUNT(*) as Total_Customers,
    SUM(Target) as Retained_Customers,
    ROUND((SUM(Target) * 100.0 / COUNT(*)), 2) as Retention_Rate
FROM customer_data
GROUP BY Marital_Status;

--Correlation Insights
SELECT 
    ROUND(AVG(CASE WHEN Target = 1 THEN Credit_Score ELSE 0 END), 2) as Retained_Credit,
    ROUND(AVG(CASE WHEN Target = 0 THEN Credit_Score ELSE 0 END), 2) as Non_Retained_Credit
FROM customer_data;
