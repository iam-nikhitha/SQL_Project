# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner to Intermediate  
**Database**: `sales_db`  

This project involves analyzing retail sales data using SQL. The dataset contains transactions including sales date, time, customer information, product category, quantity, price, and total sales. The goal is to perform data cleaning, exploratory data analysis (EDA), and generate business insights using SQL queries.

## Objectives

1. **Database Setup**: Create and populate a structured retail sales database.
2. **Data Cleaning**: Identify and remove null or incorrect records.
3. **Exploratory Data Analysis**: Perform summary statistics and trend analysis.
4. **Business Insights**: Extract meaningful insights such as top-selling products, customer demographics, and revenue trends.

## Project Structure

### 1. Database Setup

- **Table Creation**: The database includes a `Sales_Tb` table with structured columns:

```sql
CREATE TABLE Sales_Tb (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Cleaning

- **Check for Missing Values**:
```sql
SELECT * FROM Sales_Tb WHERE transactions_id IS NULL;
```
- **Remove Null Records**:
```sql
DELETE FROM Sales_Tb
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;
```

### 3. Exploratory Data Analysis (EDA)

- **Count Total Records**:
```sql
SELECT COUNT(*) FROM Sales_Tb;
```
- **Get Unique Customer Count**:
```sql
SELECT COUNT(DISTINCT customer_id) FROM Sales_Tb;
```
- **List Unique Product Categories**:
```sql
SELECT DISTINCT category FROM Sales_Tb;
```

### 4. Business Insights & Queries

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM sales_Tb
WHERE sale_date = '2022-11-05'
```

2.**Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:**
```sql
SELECT * FROM sales_Tb
where category = 'Clothing' AND TO_CHAR(sale_date,'YYYY-DD')='2022-11' AND QUANTIY>=4
```

3.**Write a SQL query to calculate the total sales (total_sale) for each category:**
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM sales_Tb
GROUP BY 1
```

4.**Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:**
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM sales_Tb
WHERE category = 'Beauty'
```


5.**Write a SQL query to find all transactions where the total_sale is greater than 1000:**
```sql
SELECT * FROM sales_Tb
WHERE total_sale > 1000
```

6.**Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:**
```sql
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM sales_Tb
GROUP 
    BY 
    category,
    gender
ORDER BY 2
```

7.**Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:**
```sql
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
```


8.**Write a SQL query to find the top 5 customers based on the highest total sales:**
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM SALES_Tb
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```



9.**Write a SQL query to find the number of unique customers who purchased items from each category:**
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM sales_tb
GROUP BY category
```


10.**Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):**
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM sales_tb
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
```
## Findings & Insights

- **Peak Sales Periods**: The analysis highlights which months and time shifts drive the highest revenue.
- **Customer Spending Patterns**: Identification of top customers and their purchasing behavior.
- **Product Performance**: Understanding which product categories generate the most sales.
- **High-Value Transactions**: Spotting premium purchases and customer preferences.




