use zepto_project;

-- (Q1)- Data exploration
-- Count of rows

Select count(*) from zepto;

-- (Q2)- Sample data

select * from zepto;

-- (Q3)- Find out if there any null values

select *
from zepto
where name is null
   or mrp is null
   or discountPercent is null
   or availableQuantity is null
   or discountedsellingPrice is null
   or weightInGms is null
   or outOfstock is null
   or quantity is null;
   
-- (Q3)- Different product categories
 
 Select distinct(category)
 from zepto
 order by category;
 
 -- (Q4)- Product instock vs outofstock
 
select outofstock, count(outofstock) as count from zepto
group by outofstock;

-- (Q5)- Poduct names present multiple times

select name, count(name) as count
from zepto
group by name
having count(name)>1
order by count(name) desc;

-- Data cleaning

-- (Q6)- Product with MRP = 0

Delete from zepto
where MRP = 0;

select * from zepto
where MRP = 0;

-- (Q7)- The current MRP is not in correct form its in paise instead of ruppees, will convert in ruppees

update zepto
set MRP = MRP/100,
discountedsellingprice = discountedsellingprice/100;

Select * from zepto;

-- (Q8) Find the top 10 best-value products based on the discount percentage

select distinct(name), MRP, discountPercent from zepto
order by discountPercent desc
limit 10;

-- (Q9) What are the products with MRP > 300 but outofstock

select distinct name, MRP, outofstock from zepto
where outofstock = 'true' and MRP > 300
order by MRP desc;

-- (Q10) Calculate estimate revenue for each category

select category, sum(discountedSellingPrice*availableQuantity) as Revenue
from zepto
group by category
order by revenue desc;

-- (Q11) Find all products where MRP is greater than 500 and discount is less than 10%

Select category, name from zepto
where MRP > 500 and discountPercent < 10;

-- (Q12) Identify the top 5 categories offering the highest avearage discount percentage

select category, round(avg(discountPercent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;

-- (Q13) Find the price per gram for products above 100g and sort by best value.

select distinct name, round(sum(weightInGms/discountedSellingPrice),2) as Price_per_gm
from zepto
where weightInGms >=100
group by name
order by price_per_gm;

-- (Q14) Group the products into categories like low, Medium, Bluk

select distinct name, category, weightInGms,
case when weightInGms <1000 then 'Low'
     when weightInGms <5000 then 'Medium'
     else 'Bluk' end as category_rank
     from zepto;
     
-- (Q16) What is the total inventoy weight per category

select category, sum(weightInGms*availableQuantity) as Total_weight
from zepto
group by category
order by total_weight;















