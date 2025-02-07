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

1. **Sales on a Specific Date**
```sql
SELECT * FROM Sales_Tb WHERE sale_date = '2022-11-05';
```

2. **Top-Selling Products by Category**
```sql
SELECT category, SUM(total_sale) AS total_sales FROM Sales_Tb GROUP BY category ORDER BY total_sales DESC;
```

3. **Customer Demographics Analysis**
```sql
SELECT gender, AVG(age) AS avg_age FROM Sales_Tb GROUP BY gender;
```

4. **High-Value Transactions**
```sql
SELECT * FROM Sales_Tb WHERE total_sale > 1000;
```

5. **Top 5 Customers by Total Sales**
```sql
SELECT customer_id, SUM(total_sale) AS total_sales FROM Sales_Tb GROUP BY customer_id ORDER BY total_sales DESC LIMIT 5;
```

6. **Transaction Count by Shift (Morning, Afternoon, Evening)**
```sql
SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening' 
    END AS shift,
    COUNT(*) AS total_orders 
FROM Sales_Tb 
GROUP BY shift;
```

## Findings & Insights

- **Peak Sales Periods**: The analysis highlights which months and time shifts drive the highest revenue.
- **Customer Spending Patterns**: Identification of top customers and their purchasing behavior.
- **Product Performance**: Understanding which product categories generate the most sales.
- **High-Value Transactions**: Spotting premium purchases and customer preferences.

## How to Use

1. **Clone the Repository**: Clone this project from GitHub.
2. **Set Up the Database**: Execute the SQL scripts to create and populate the database.
3. **Run Queries**: Use the provided SQL queries to analyze the dataset.
4. **Customize & Expand**: Modify queries or add new ones to explore different insights.

## Author

This project is a part of my SQL portfolio, demonstrating proficiency in data analysis and business intelligence. If you have any questions or feedback, feel free to reach out.

---

This **Retail Sales Analysis SQL Project** serves as an excellent foundation for learning SQL data analysis and gaining hands-on experience with real-world datasets.
