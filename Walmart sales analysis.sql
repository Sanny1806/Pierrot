-- Create data base
create database if not exists WalmartSales;

use WalmartSales;
select * from sales;


-- Data Cleaning / creating new columns
-- Add time_of_day column

alter table sales
add column time_of_day varchar(20) not null;

describe sales;

update sales
SET time_of_day = (CASE
		when Time between '00:00:00' and '12:00:00' then "Morning"
        when Time between '12:01:00' and '16:00:00' then "Afternoon"
		else "Evening"
        end
);
        
select * from sales;

-- Add day name

alter table sales
add column day_name varchar(20) not null;

update sales
set day_name = dayname(date);

select * from sales;


-- Add month name

alter table sales
add month_name varchar(10) not null;

update sales
set month_name = monthname(date);


-- 1. How many unique cities does the data have?

select count(distinct city) from sales;


-- 2. How many unique product lines does the data have?

select distinct Product_line from sales;

select * from sales;

-- 3. What is the most selling product line

select * from sales;

select product_line, sum(quantity) as qty from sales
group by product_line
order by qty desc
limit 1;



-- 4. What is the total revenue by month

select * from sales;

select month_name, round(sum(total),2) as total_sales_by_month
from sales
group by month_name
order by total_sales_by_month desc;


-- 5. What month had the largest COGS?

select month_name, sum(cogs) as co from sales
group by month_name
order by co desc
limit 1;



-- 6. What product line had the largest revenue?

select * from sales;

select product_line, round(sum(total),2) as tot from sales
group by product_line
order by tot desc
limit 1;



-- 7. What product line had the largest VAT?

select * from sales;

select Product_line, round(sum(`Tax_5%`)) as tax
from sales 
group by product_line
order by tax desc
limit 1;



/* 8. Fetch each product line and add a column to those product line showing 
"Good", "Bad". Good if its greater than average sales */

use walmartsales;
select * from sales;

select *, case
			when total > avg(total) then "Good"
            else "Bad"
            end as remark
from sales;




-- 9. Which branch sold more products than average product sold?

select * from sales;

select Branch, sum(quantity) as total_qty from sales 
group by Branch
having sum(quantity) > ( select avg(quantity) from sales)
order by total_qty desc;

select distinct branch from sales;

-- 11. What is the most common product line by gender?

select * from sales;

select product_line, Gender, count(gender) as cnt from sales
group by product_line, gender
order by cnt desc;

-- 12. What is the average rating of each product line?

select * from sales;

select product_line, round(avg(rating),2) as avg from sales
group by product_line
order by avg desc;

-- 13. 



