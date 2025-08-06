--Write a query to assign a row number to each sale based on the SaleDate.

select *, ROW_NUMBER() over(order by saledate) from ProductSales

--Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.

select *, DENSE_RANK() over(order by quantity) from ProductSales

--Write a query to identify the top sale for each customer based on the SaleAmount.

select * from (
select *, 
		ROW_NUMBER() over(partition by customerid order by saleamount desc) rank
		--RANK() over(partition by customerid order by saleamount) 
from ProductSales
) as TopSale
where rank = 1

--Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.
select SaleAmount, LEAD(SaleAmount) over(order by saledate) NextSaleAmount from ProductSales

--Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.
select saleamount, LAG(saleamount) over(order by saledate) PreviousSaleAmount from ProductSales

--Write a query to identify sales amounts that are greater than the previous sale's amount

select * from (
select SaleID,saleamount, LAG(saleamount) over(order by saledate) PreviousSaleAmount from ProductSales
) as sales 
where SaleAmount > PreviousSaleAmount

--Write a query to calculate the difference in sale amount from the previous sale for every product

select *, SaleAmount - PreviousSaleAmount as Difference from (
select saleamount, LAG(saleamount) over(order by saledate) PreviousSaleAmount from ProductSales ) as sales

--Write a query to compare the current sale amount with the next sale amount in terms of percentage change.

select *, cast((NextSaleAmount * 100 / SaleAmount) - 100 as int)as PercenChange from (
select SaleAmount, LEAD(SaleAmount) over(order by saledate) NextSaleAmount from ProductSales
) as diff

--Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.

select *, cast(SaleAmount/PreviousSaleAmount as decimal(10,2)) as ratio from (
select ProductName, SaleAmount, LAG(SaleAmount) over(partition by productname order by saledate) PreviousSaleAmount from ProductSales
) as sales

--Write a query to calculate the difference in sale amount from the very first sale of that product.

select *,
SaleAmount - FIRST_VALUE(SaleAmount) over(partition by productname order by saledate) as DiffFirstSale
from (
select *, ROW_NUMBER() over(partition by productname order by saledate) rank
from ProductSales) as sales 

--Write a query to find sales that have been increasing continuously for a product 
--(i.e., each sale amount is greater than the previous sale amount for that product).

with cte as (
select *,
case 
	when PrevSale is null then 'start'
	when SaleAmount - PrevSale > 0 then 'increasing'
	else 'decreasing'
	end condition
from (
select *, LAG(SaleAmount) over (partition by productname order by saledate) PrevSale from ProductSales
) as sales
)
select * from ProductSales 
where ProductName not in (
select ProductName
from cte
where condition = 'decreasing')

--Write a query to calculate a "closing balance"(running total) for sales amounts which adds the current sale amount to a running total of previous sales.

select *, 
SUM(SaleAmount) over(partition by productname order by saledate)
from ProductSales

--Write a query to calculate the moving average of sales amounts over the last 3 sales.
--13
select *,
AVG(SaleAmount) over(order by saledate rows between 2 preceding and current row) Last3Sales -- 
from ProductSales

--AVG(SaleAmount) over(order by saledate rows between current row and 2 following ) Following

--Write a query to show the difference between each sale amount and the average sale amount.
--14

select *, SaleAmount - AvgSaleAmount as Difference from (
select *, AVG(SaleAmount) over() as AvgSaleAmount from ProductSales ) as DiffAvg

--Find Employees Who Have the Same Salary Rank

select * from Employees1
where Salary in (
select Salary from (
select *, dense_rank() over(order by salary desc) as rank from Employees1
) as emp
group by Salary
having COUNT(rank) > 1)

--Identify the Top 2 Highest Salaries in Each Department

select * from (
select *, DENSE_RANK() over(partition by department order by salary desc) rank from Employees1
) as emp
where rank < 3

--Find the Lowest-Paid Employee in Each Department

select * from (
select *, DENSE_RANK() over(partition by department order by salary) rank from Employees1
) as emp
where rank = 1

--Calculate the Running Total of Salaries in Each Department

select *, 
SUM(Salary) over(partition by department order by hiredate)
from Employees1

--Find the Total Salary of Each Department Without GROUP BY

select *, 
SUM(Salary) over(partition by department)
from Employees1

--Calculate the Average Salary in Each Department Without GROUP BY

select *, AVG(Salary) over(partition by department) from Employees1

--Find the Difference Between an Employee’s Salary and Their Department’s Average

select *, Salary - AvgDepSalary as Difference from (
select *, AVG(Salary) over(partition by department) AvgDepSalary from Employees1
) as emp

--Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

select *, AVG(Salary) over(order by employeeid rows between 1 preceding and 1 following) from Employees1 --previous,current,next

--below explanatiton of ABOVE
--60
--50 -->61666
--75

--Find the Sum of Salaries for the Last 3 Hired Employees

select *, SUM(Salary) over(order by hiredate rows between 2 preceding and current row) from Employees1
