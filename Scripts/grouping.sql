-- how many cars were sold by each employee

select e.employeeid, count(*)
from employee e
INNER join sales s
on e.employeeId = s.employeeId
-- where title = 'Sales Person'
group by e.employeeid
order by count(s.salesId) DESC

-- find the least and most expensive car sold by each employee

select e.employeeid, 
  max(s.salesAmount),
  min(s.salesAmount)
from employee e
INNER join sales s
on e.employeeId = s.employeeId
where strftime('%Y', s.soldDate) = '2023'
group by e.employeeid
order by e.employeeid

-- display the report for employees who have sold more than 5 cars

select e.employeeId, count(*)
from employee e
INNER join sales s
on e.employeeId = s.employeeId
where strftime('%Y', s.soldDate) = '2023'
group by e.employeeid
having count(*) >= 5
order by e.employeeId