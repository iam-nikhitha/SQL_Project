--SQL Retail Sales Analysis
--Create Table
CREATE TABLE Sales_Tb
                 (
                    transactions_id INT PRIMARY KEY,
                    sale_date	     DATE,
                    sale_time	     TIME,
                    customer_id	 INT,
		    gender          VARCHAR(15),
		    age	         INT,
		    category	     VARCHAR(15),
		    quantiy	     INT,
		    price_per_unit	 FLOAT,
		    cogs	         FLOAT,
		    total_sale      FLOAT
				)


SELECT * FROM Sales_Tb
LIMIT 5


SELECT COUNT(*) FROM Sales_Tb

--DATA CLEANING
SELECT * FROM Sales_Tb
WHERE transactions_id is NULL




SELECT * FROM Sales_Tb
WHERE
transactions_id is NULL
OR
sale_date is NULL
OR
sale_time is NULL
OR
customer_id is NULL
OR
gender is NULL
OR
age is NULL
OR
category is NULL
OR
quantiy is NULL
OR
price_per_unit is NULL
OR
cogs is NULL
OR
total_sale is NULL




DELETE FROM sales_tb
WHERE
transactions_id is NULL
OR
sale_date is NULL
OR
sale_time is NULL
OR
customer_id is NULL
OR
gender is NULL
OR
age is NULL
OR
category is NULL
OR
quantiy is NULL
OR
price_per_unit is NULL
OR
cogs is NULL
OR
total_sale is NULL


--DATA EXPLORATION
--how many sales we have

SELECT COUNT(*) AS TOTAL_SALE FROM Sales_tb


--how many unique customers and catogeries we have

SELECT COUNT(DISTINCT customer_id) AS TOTAL_CUSTOMERS FROM sales_Tb

SELECT COUNT(DISTINCT category) AS TOTAL_Categories FROM sales_Tb





SELECT 
    (SELECT COUNT(DISTINCT customer_id) FROM Sales_tb) AS TOTAL_CUSTOMERS,
    (SELECT COUNT(DISTINCT category) FROM Sales_tb) AS TOTAL_CATEGORIES;


	

SELECT category, COUNT(DISTINCT customer_id) AS total_customers
FROM Sales_tb
GROUP BY category;


--DATA ANALYSIS & BUSINESS KEY PROBLEMS WITH SOLUTIONS


--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM sales_Tb
WHERE sale_date = '2022-11-05'

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM sales_Tb
where category = 'Clothing' AND TO_CHAR(sale_date,'YYYY-DD')='2022-11' AND QUANTIY>=4

--3.Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM sales_Tb
GROUP BY 1


--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM sales_Tb
WHERE category = 'Beauty'



--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM sales_Tb
WHERE total_sale > 1000


--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
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


--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
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



--8.**Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM SALES_Tb
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5



--9.Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM sales_tb
GROUP BY category



--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
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
