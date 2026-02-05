                                --DATABASE SETUP--

--Create sales table

CREATE TABLE sales (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR,
    age INT,
    category VARCHAR(20),
    quantiy INT(10),
    price_per_unit INT,
    cogs Decimal (10,2),
    total_sale INT

--Insert data in sales table

FROM 'H:\Data Analyst\SQL\Retail Sales Analysis\Retail Sales Analysis_utf.csv' 
	DELIMITER ',' 
	CSV HEADER





                                -- DATA ANALYSIS AND FINDNGS--

-- Write a SQL query to retrieve all columns for sales made on 2022-11-05

select * 
from sales
where sale_date= '2022-11-05'


--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * 
from sales
where category = 'Clothing' and
quantity >=4 and
sale_date >='2022-11-01' and
sale_date < '2022-12-01'

--Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as net_Sales
from sales
group by category


--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

select category, cast(avg(age) as decimal(10,2))as Average_Age
from sales
where category= 'Beauty'
group by category

--Write a SQL query to find all transactions where the total_sale is greater than 1000

select * 
from sales
where total_sale >1000


--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

select gender, category, count(transactions_id) as total_transactions
from sales
group by gender, category
order by category


--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select Years, Months, average_sales
from(

select 
       extract(YEAR FROM sale_date) as Years, 
       extract(MONTH from sale_date) as Months,
	   avg(total_sale) as average_sales,
	   rank() over(partition by extract(YEAR FROM sale_date) order by avg(total_sale) desc) as rank
from sales
group by Years, Months
)
where rank=1

--Write a SQL query to find the top 5 customers based on the highest total sales

select customer_id, sum(total_sale) as total_sales
from sales
group by customer_id
order by total_sales desc
limit  5


--Write a SQL query to find the number of unique customers who purchased items from each category

select category, count(distinct customer_id) as customer_count
from sales
group by category


--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift



                                         --END OF PROJECT--






















