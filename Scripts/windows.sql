-- get a list of sales people and rank the car models they've sold the most

with cte as (
select e.firstName, e.lastName, m.model, count(m.model) as model_count
from sales s
join employee e
on s.employeeId = e.employeeId
join inventory i
on s.inventoryId = i.inventoryId
join model m
on i.modelId = m.modelId
group by e.firstName, e.lastName, m.model
)
select *, rank() over(PARTITION by firstName, lastName order by model_count DESC) as ranking
from cte


-- generate a sales report showing a total sales per month and annual running 
-- total
with cte as (
select strftime('%Y', soldDate) as year, 
  strftime('%m', soldDate) as month, 
  sum(salesAmount) as total_sales
from sales
group by 1,2
order by 1,2
)
select *, sum(total_sales) over(partition by year order by year, month ) as running_total
from cte


-- create a report showing the number of cars sold this month and last month

with cte as (
select strftime('%Y', soldDate) as year, 
  strftime('%m', soldDate) as month,
  count(*) as cars_sold
from sales
group by 1,2
order by 1,2
)
select * , 
  lag(cars_sold, 1,0) over() as cars_sold_previous_month
 -- (lag(cars_sold) over() as cars_sold_previous_month - cars_sold) as difference
from cte
