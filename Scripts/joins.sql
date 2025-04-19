
-- Q1 provide the list of employees with their immediate manager names
select e1.firstName, e1.lastName, e2.firstName as Managerfirstname,
e2.lastName AS Managerlastname
from employee e1
join employee e2
on e1.managerId = e2.employeeId

-- Q2 list of salespeople with zero sales
select e.employeeId, sum(s.salesAmount) --  e.firstName, e.lastName,
from employee e
left join sales s
on e.employeeId = s.employeeId
where e.title = 'Sales Person'
-- and s.salesId is NULL
group by e.employeeId
having sum(s.salesAmount) is NULL

select employeeId from employee
where title = 'Sales Person' and employeeId not in (select DISTINCT employeeId from sales)


-- Q3. Get the list of all sales and all customers data even if some 
-- data has been removed
select c.firstName, c.lastName, c.email, s.salesAmount
from customer c
INNER join sales s
on c.customerId = s.customerId
UNION
-- union with customers who have no sales
select c.firstName, c.lastName, c.email, s.salesAmount
from customer c
left join sales s
on c.customerId = s.customerId
where s.salesId is NULL
union 
-- union with sales missing customer data
select c.firstName, c.lastName, c.email, s.salesAmount
from customer c
RIGHT join sales s
on c.customerId = s.customerId
where c.customerId is NULL