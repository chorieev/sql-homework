--In this puzzle you have to extract the month from the dt column and then append zero single digit month if any. 
--Please check out sample input and expected output.
select *,
case 
	when DATEPART(MONTH, Dt) < 10 then '0' + cast(DATEPART(MONTH, Dt) as varchar(20))
	else cast(DATEPART(MONTH, Dt) as varchar(20))
end MonthPrefWithZero
from Dates
--In this puzzle you have to find out the unique Ids present in the table. 
--You also have to find out the SUM of Max values of vals columns for each Id and RId. 
--For more details please see the sample input and expected output.
with cte as (
select distinct Id, rID, MaxValue from 
(
	select *, MAX(Vals) over(partition by id)MaxValue from MyTabel
) as mytable
)

select distinct COUNT(Id) over() as Distinct_Ids, rID, SUM(MaxValue) over() TotalOfMaxVals from cte
--In this puzzle you have to get records with at least 6 characters and maximum 10 characters. 
--Please see the sample input and expected output.
select * from TestFixLengths
where LEN(Vals) >=6 and LEN(Vals) <=10
--In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and Maximum value. 
--Please check out sample input and expected output.
select * from TestMaximum a
where exists (
select * from (select ID, MAX(Vals) MaxVals from TestMaximum 
group by ID
) as test 
where a.ID=test.ID and a.Vals=test.MaxVals
)
--In this puzzle you have to first find the maximum value for each Id and DetailedNumber, 
--and then Sum the data using Id only. 
--Please check out sample input and expected output.

select Id, SUM(MaxValue) SumofMax from (
select Id,DetailedNumber, MAX(Vals) MaxValue from SumOfMax
group by Id,DetailedNumber
) as sumofmax
group by Id

--In this puzzle you have to find difference between a and b column between each row 
--and if the difference is not equal to 0 then show the difference i.e. a – b otherwise 0. 
--Now you need to replace this zero with blank.Please check the sample input and the expected output.


select *,
case
	when a-b=0 then ''
	else cast(a-b as varchar(max))
	end OUTPUT
from TheZeroPuzzle


--What is the total revenue generated from all sales?

select SUM(QuantitySold*UnitPrice) TotalRevenue from Sales

--What is the average unit price of products?

select AVG(UnitPrice) AvgUnitPrice from Sales

--How many sales transactions were recorded?

select COUNT(SaleID) Num0fRecord from Sales

--What is the highest number of units sold in a single transaction?

select MAX(QuantitySold) from Sales

--How many products were sold in each category?

select *, COUNT(Product) over(partition by category) NumPerCateg from Sales

--What is the total revenue for each region?

select *, SUM(QuantitySold*UnitPrice) over(partition by region) from Sales

--Which product generated the highest total revenue?

select *, MAX(TotRev) over() HighestTotRev from (
select *, SUM(QuantitySold*UnitPrice) over(partition by product) TotRev from Sales
) as sales

--Compute the running total of revenue ordered by sale date.

select *, SUM(QuantitySold*UnitPrice) over(order by saledate) from Sales

--How much does each category contribute to total sales revenue?

select *, SUM(QuantitySold*UnitPrice) over(partition by category) Contribution from Sales
--Show all sales along with the corresponding customer names

select s.*, c.CustomerName from Customers c
join Sales s on c.CustomerID=s.CustomerID

--List customers who have not made any purchases

select * from Customers 
where CustomerID not in (
select CustomerID from Sales
)

--Compute total revenue generated from each customer

select s.*, SUM(QuantitySold*UnitPrice) over(partition by s.customerid) TotRev, c.CustomerName from Customers c
join Sales s on c.CustomerID = s.CustomerID

--Find the customer who has contributed the most revenue
select distinct CustomerName from (
select s.*, SUM(QuantitySold*UnitPrice) over(partition by s.customerid) TotRev, c.CustomerName from Customers c
join Sales s on c.CustomerID = s.CustomerID
) as sales1 
where TotRev = (
select MAX(TotRev) from (
select s.*, SUM(QuantitySold*UnitPrice) over(partition by s.customerid) TotRev, c.CustomerName from Customers c
join Sales s on c.CustomerID = s.CustomerID
) as sales
)

--Calculate the total sales per customer

select *, SUM(UnitPrice) over(partition by customerid) from Sales

--List all products that have been sold at least once

select * from (
select *, COUNT(SellingPrice) over(partition by productid) Num from Products
)as prod
where Num>=1

--Find the most expensive product in the Products table

select * from Products
where SellingPrice = (
select max(SellingPrice)  from Products
)

--Find all products where the selling price is higher than the average selling price in their category

select * from Products a
where SellingPrice>(
select AVG(SellingPrice) from Products b
where a.Category = b.Category
)

