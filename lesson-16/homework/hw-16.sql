--the start point of hw

--Create a numbers table using a recursive query from 1 to 1000.

with cte as (
select cast(1 as bigint)  as numbers
union all
select numbers + 1 from cte
where numbers < 1000
)
select * from cte
option (maxrecursion 999);

--Write a query to find the total sales per employee using a derived table.(Sales, Employees)


select b.FirstName,b.LastName,a.TotalSales from (
select EmployeeID, SUM(SalesAmount) TotalSales from Sales
group by EmployeeID) as a 
join Employees b on a.EmployeeID=b.EmployeeID

--Create a CTE to find the average salary of employees.(Employees)

with cte_avg as (
select AVG(salary) AvgSalary from Employees
)
select * from cte_avg


--Write a query using a derived table to find the highest sales for each product.(Sales, Products)

select b.ProductID,b.ProductName, a.HighestSales from (
select ProductID, MAX(SalesAmount) HighestSales from Sales
group by ProductID) a 
join Products b on a.ProductID = b.ProductID

--Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.

with cte_num as (
select cast(1 as bigint) as number
union all
select number * 2 from cte_num
where number * 2 < 1000000
)
select * from cte_num

--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
;with cte_sales as (
select EmployeeID, COUNT(SalesID) SalesCount from Sales
group by EmployeeID)

select b.FirstName,b.LastName, a.SalesCount from cte_sales a
join Employees b on a.EmployeeID = b.EmployeeID
where a.SalesCount>5

--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
;with cte_sales as (
select ProductID, sum(SalesAmount) Sales from Sales
group by ProductID)
select p.ProductName, p.ProductID, c.Sales from cte_sales c
join Products p on c.ProductID = p.ProductID
where c.Sales > 500

--Create a CTE to find employees with salaries above the average salary.(Employees)
;with cte_employees as (
select AVG(salary) avgSalary from Employees
)
select FirstName, LastName, Salary from Employees, cte_employees
where Salary > cte_employees.avgSalary


--Medium Tasks

--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)

select top 5 FirstName,LastName, OrderCount from (
select EmployeeID, COUNT(SalesID) OrderCount from Sales
group by EmployeeID) a 
join Employees b on a.EmployeeID= b.EmployeeID
order by OrderCount desc

--Write a query using a derived table to find the sales per product category.(Sales, Products)

select CategoryID, SUM(SalesAmount) TotalSales from (
select ProductID, SalesAmount from Sales )a
join Products p on a.ProductID=p.ProductID
group by CategoryID


--Write a script to return the factorial of each value next to it.(Numbers1)

declare @maxNum int ;
select @maxNum = max(number) from numbers1

;with Factorial_cte as (
select 1 as number, 1 as Factor
union all
select 
	number + 1, 
	factor * (number + 1) 
from Factorial_cte
where number < @maxNum
)
select b.Number, a.Factor from Numbers1 b
join Factorial_cte a on a.number = b.Number
order by b.Number

--This script uses recursion to split a string into rows of substrings for each character in the string.(Example)


declare @int varchar(50);
select @int = string from Example where Id= 1

declare @string varchar(50);
select @string = string from Example where Id = 2


;with cte_em as (
select 1 as position,
SUBSTRING(@string, 1, 1) as char1,
SUBSTRING(@int, 1,1 ) as char2
--LEN(@string) as length

union all

select position + 1 ,
SUBSTRING(@string, position + 1, 1),
SUBSTRING(@int, position + 1, 1)
--length
from cte_em

where position + 1 <= LEN(@string)
)
select char1,char2 from cte_em

--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)


;with cte_july1 as (
select MONTH(SaleDate) [Month],SUM(SalesAmount) TotalSales from Sales
where MONTH(SaleDate) = MONTH(GETDATE())
group by MONTH(SaleDate)
), cte_june1 as (
select MONTH(SaleDate) [Month],SUM(SalesAmount) TotalSales from Sales
where MONTH(SaleDate) = MONTH(GETDATE()) - 1
group by MONTH(SaleDate)
)
select c.TotalSales as JulySales,
	c1.TotalSales as JuneSales,
	c.TotalSales-c1.TotalSales as Diff from cte_july1 c
join cte_june1 c1 on 1=1


--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)

select emp.EmployeeID, FirstName,LastName from Employees emp
join (
select employeeId from (
select EmployeeID,DATEPART(QUARTER, saledate) DatePart, SUM(salesamount) TotalSales from Sales
group by DATEPART(QUARTER, saledate),EmployeeID
having SUM(SalesAmount) > 45000 ) as qwerty
group by EmployeeID
having COUNT(distinct DatePart) = 4
) as qwerty1 on emp.EmployeeID = qwerty1.EmployeeID


--Difficult tasks

--This script uses recursion to calculate Fibonacci numbers

with fibonacci as (
select 0 as fibocanni_n0, 1 as fibocanni_n1, 0+1 as result
union all
select fibocanni_n1, fibocanni_n1+fibocanni_n0, fibocanni_n1+(fibocanni_n1+fibocanni_n0) from fibonacci
where fibocanni_n1 <= 100
)
select * from fibonacci

--Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)

select * from FindSameCharacters
where LEN(Vals) > 1 
and Vals = REPLICATE(LEFT(vals,1), LEN(vals))

--Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)

;with numbers as (
select cast(1 as bigint) as number, cast(0 as varchar(max)) as String
union all
select cast(number + 1 as bigint), CONCAT(String,cast(number as varchar(max)) )  from numbers
where number + 1 <= 10
)
select * from numbers

--Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)

select sal.EmployeeID, emp.FirstName, emp.LastName, SUM(SalesAmount) MostSales from Sales sal
join Employees emp on emp.EmployeeID = sal.EmployeeID
group by sal.EmployeeID, emp.FirstName, emp.LastName
having SUM(SalesAmount) = (
select MAX(TotalSales) from (
select EmployeeID, SUM(SalesAmount) TotalSales from Sales
where DATEDIFF(MONTH, SaleDate,GETDATE())<= 6
group by EmployeeID ) tbl)

--Write a T-SQL query to remove the duplicate integer values present in the string column. 
--Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

select *,
case
	when SUBSTRING(Pawan_slug_name, charindex('-',Pawan_slug_name)+1,LEN(Pawan_slug_name)-charindex('-',Pawan_slug_name)) = 
		REPLICATE(SUBSTRING(Pawan_slug_name, charindex('-',Pawan_slug_name)+1,1), LEN(Pawan_slug_name)-charindex('-',Pawan_slug_name)) 
		then REPLACE(Pawan_slug_name, SUBSTRING(Pawan_slug_name, charindex('-',Pawan_slug_name)+1,LEN(Pawan_slug_name)-charindex('-',Pawan_slug_name)), '' )
	when LEN(SUBSTRING(Pawan_slug_name, charindex('-',Pawan_slug_name)+1,LEN(Pawan_slug_name)-charindex('-',Pawan_slug_name))) = 1 
		then REPLACE(Pawan_slug_name, SUBSTRING(Pawan_slug_name, charindex('-',Pawan_slug_name)+1,LEN(Pawan_slug_name)-charindex('-',Pawan_slug_name)), '' )
	else Pawan_slug_name
end Replaced_Pawan_slug_name
from RemoveDuplicateIntsFromNames
