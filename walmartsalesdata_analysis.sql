create database if not exists WalmartSalesData;

use WalmartSalesData;

CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6 , 4 ) NOT NULL,
    total DECIMAL(12 , 4 ) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_methode VARCHAR(5) NOT NULL,
    cogs DECIMAL(10 , 2 ) NOT NULL,
    gross_margin_pct FLOAT(11 , 9 ) NOT NULL,
    gross_income DECIMAL(12 , 4 ) NOT NULL,
    rating FLOAT(2 , 1 ) NOT NULL
);

select * from sales;


------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------- Feature Engineering -------------------------------------------------------------------

-- time of day
select 
	time,
    (case
		when time between "00:00:00" and "12:00:00" then "Morning"
        when time between "12:01:00" and "16:00:00" then "Afternoon"
        else "Evening"
	end 
    ) as time_of_day
from sales;

alter table sales add column time_of_day varchar(20);

UPDATE sales 
SET 
    time_of_day = (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END);

-- days name

select date,dayname(date)
from sales;

alter table sales add column day_name varchar(10);

update sales
set day_name=dayname(date);


-- month_name

select date,monthname(date)
from sales;

alter table sales add column  month_name varchar(10);

update sales
set month_name=monthname(date);



-------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------- Exploratory Data Analysis ---------------------------------------------------------

--------------- Business Questions to Answer ----------------

------------ Generic Question -------------

-- 1.	How many unique cities does the data have?
select distinct city
from sales;


select distinct branch
from sales;

-- 2.	In which city is each branch?
select distinct city,branch
from sales;


--------------- Product -------------------

-- 1.	How many unique product lines does the data have?
select distinct product_line from sales;

-- 2.	What is the most common payment method?
SELECT 
    payment_methode,
    COUNT(payment_methode) AS count_payment_methode
FROM
    sales
GROUP BY payment_methode
ORDER BY count_payment_methode DESC;

-- 3.	What is the most selling product line?
select product_line,
	count(product_line) as count_product_line
from sales
group by product_line
order by count_product_line desc;

-- 4.	What is the total revenue by month?
SELECT 
    month_name, SUM(total) AS total_revenue
FROM
    sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- January	41770.0815
-- February	35746.3365
-- March	34690.1520

-- 5.	What month had the largest COGS?
SELECT 
    month_name AS month, SUM(cogs) AS cogs
FROM
    sales
GROUP BY month
ORDER BY cogs DESC;

-- January	39781.03
-- February	34044.13
-- March	33038.24

-- 6.	What product line had the largest revenue?
SELECT 
    product_line, SUM(total) AS total_revenue
FROM
    sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- Electronic accessories	20729.9820
-- Food and beverages	19210.8735
-- Sports and travel	18873.8130
-- Home and lifestyle	18589.0005
-- Fashion accessories	17613.7920
-- Health and beauty	17189.1090

-- 7.	What is the city with the largest revenue?
SELECT 
    city, branch, SUM(total) AS total_revenue
FROM
    sales
GROUP BY city , branch
ORDER BY total_revenue;

-- Yangon	A	33781.2510
-- Mandalay	B	35339.4615
-- Naypyitaw	C	43085.8575


SELECT 
    product_line, AVG(VAT) AS avg_tax
FROM
    sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Home and lifestyle	17.35667652
-- Health and beauty	16.70467346
-- Food and beverages	16.04918416
-- Sports and travel	15.23310174
-- Fashion accessories	14.71494728
-- Electronic accessories	13.90340836


-- 10.	Which branch sold more products than average product sold?
SELECT 
    branch, SUM(quantity), AVG(quantity)
FROM
    sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT 
        AVG(quantity)
    FROM
        sales);

-- C	696	5.6129
-- A	572	5.2000
-- B	628	5.7091


-- 11.	What is the most common product line by gender?
select gender,
	product_line,
    count(gender) as count_by_gender
from sales
group by gender,product_line
order by count_by_gender desc;

-- 12.	What is the average rating of each product line?
select avg(rating) as avg_rating,
product_line
from sales
group by product_line
order by avg_rating desc;




-------------------------------------------------------------------------------------------
------------------------------------------ Sales ------------------------------------------

SELECT 
    time_of_day, COUNT(*) AS total_sales
FROM
    sales
WHERE
    day_name = 'Sunday'
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Evening	18
-- Afternoon	17
-- Morning	12

SELECT 
    customer_type, SUM(total) AS total_revenue
FROM
    sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- Normal	57545.5545
-- Member	54661.0155

SELECT 
    city, AVG(VAT) AS VAT
FROM
    sales
GROUP BY city
ORDER BY VAT DESC;

-- Naypyitaw	16.54602815
-- Mandalay	15.29846820
-- Yangon	14.62391815

SELECT 
    customer_type, AVG(VAT) AS VAT
FROM
    sales
GROUP BY customer_type
ORDER BY VAT DESC;

-- Normal	15.56968462
-- Member	15.49348510

----------------------------------------------------------------------------------------------------
------------------------------------------ Customer ------------------------------------------------

select distinct customer_type from sales;
-- Member
-- Normal

select distinct payment_methode from sales;

SELECT 
    customer_type, COUNT(*)
FROM
    sales
GROUP BY customer_type
ORDER BY COUNT(*);

-- Member	168
-- Normal	176

select gender,
count(*) as gender_count
from sales
group by gender
order by gender_count desc;

-- Female	178
-- Male	166

select branch,gender,
count(gender) as gender_count
from sales
group by branch,gender
order by gender_count desc;

select time_of_day,
avg(rating) as avg_rating
from sales
group by time_of_day
order by avg_rating desc;

-- Morning	7.13288
-- Afternoon	7.00229
-- Evening	6.85500

SELECT 
    time_of_day, branch, AVG(rating) AS avg_rating
FROM
    sales
GROUP BY time_of_day , branch
ORDER BY branch , avg_rating DESC;

select day_name,
avg(rating) as avg_rating
from sales
group by day_name
order by avg_rating desc;


SELECT 
    day_name, branch, AVG(rating) AS avg_rating
FROM
    sales
GROUP BY day_name , branch
ORDER BY avg_rating DESC;



-- Total sales by day of the week across different months
SELECT 
    day_name, 
    month_name, 
    SUM(total) as total_sales
FROM 
    sales
GROUP BY 
    day_name, 
    month_name
ORDER BY 
    total_sales desc
    ;


-- Example for frequency of purchases by customer type
SELECT 
    customer_type, 
    COUNT(*) as purchase_count, 
    SUM(total) as total_spent
FROM 
    sales
GROUP BY 
    customer_type
ORDER BY 
    total_spent DESC;


-- Example for identifying profitable product lines
SELECT 
    product_line, 
    SUM(total) as total_revenue, 
    SUM(cogs) as total_cogs, 
    (SUM(total) - SUM(cogs)) as profit
FROM 
    sales
GROUP BY 
    product_line
ORDER BY 
    profit DESC;


-- Example for branch performance comparison
SELECT 
    branch, 
    SUM(total) as total_sales, 
    AVG(rating) as avg_rating
FROM 
    sales
GROUP BY 
    branch
ORDER BY 
    total_sales DESC;


SELECT *,
       (unit_price * quantity) AS COGS,
       (0.05 * (unit_price * quantity)) AS VAT,
       ((unit_price * quantity) + (0.05 * (unit_price * quantity))) AS total,
       (((unit_price * quantity) + (0.05 * (unit_price * quantity))) - (unit_price * quantity)) AS gross_income,
       ((((unit_price * quantity) + (0.05 * (unit_price * quantity))) - (unit_price * quantity)) / ((unit_price * quantity) + (0.05 * (unit_price * quantity)))) AS gross_margin_percentage
FROM sales;


