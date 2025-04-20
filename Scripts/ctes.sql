with cte as (
SELECT strftime('%Y', solddate) as soldyear, salesamount 
from sales
)
select soldyear, round(sum(salesamount),2) as total_Sales
from cte
group by 1
order by 1

-- create a report that shows the amount of sales per employee for each month 
-- in year 2021

with cte as (
select e.firstName, e.lastName, s.soldDate, s.salesAmount
from sales s
inner join (select * from employee
where title = 'Sales Person') e
on s.employeeId = e.employeeId
where strftime('%Y', solddate) = '2021'
)
select firstName, lastName,
  sum(CASE WHEN strftime('%m', solddate) = '01' then salesAmount end )as JanSales,
  sum(CASE WHEN strftime('%m', solddate) = '02' then salesAmount end ) as FebSales,
  sum(CASE WHEN strftime('%m', solddate) = '03' then salesAmount end ) as MarSales,
  sum(CASE WHEN strftime('%m', solddate) = '04' then salesAmount end ) as AprSales,
  sum(CASE WHEN strftime('%m', solddate) = '05' then salesAmount end ) as MaySales,
  sum(CASE WHEN strftime('%m', solddate) = '06' then salesAmount end ) as JunSales,
  sum(CASE WHEN strftime('%m', solddate) = '07' then salesAmount end ) as JulSales,
  sum(CASE WHEN strftime('%m', solddate) = '08' then salesAmount end ) as AugSales,
  sum(CASE WHEN strftime('%m', solddate) = '09' then salesAmount end ) as SepSales,
  sum(CASE WHEN strftime('%m', solddate) = '10' then salesAmount end ) as OctSales,
  sum(CASE WHEN strftime('%m', solddate) = '11' then salesAmount end ) as NovSales,
  sum(CASE WHEN strftime('%m', solddate) = '12' then salesAmount end ) as DecSales
from cte
group by firstName,lastName


-- find all sales where the car purchased was electric
select s.soldDate, s.salesAmount, i.colour, i.year 
from sales s
join inventory i
on s.inventoryId = i.inventoryId
join model m
on i.modelId = m.modelId
where m.EngineType = 'Electric'

select * from model limit 10

