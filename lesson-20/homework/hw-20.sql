--Find customers who purchased at least one item in March 2024 using EXISTS
--1
select CustomerName from #Sales s
where exists (
select 1 from #Sales s1
where --Quantity >= 1 and 
MONTH(SaleDate) = 3 and YEAR(SaleDate) = 2024
and s.SaleID = s1.SaleID
)

--Find the product with the highest total sales revenue using a subquery.
--2
select Product from #Sales
group by Product
having SUM(Quantity * Price) = (
select MAX(TotalRevenue) from (
select SUM(Quantity * Price) TotalRevenue from #Sales
group by Product) sales
)

--Find the second highest sale amount using a subquery
--3
select max(Price) from #Sales
where Price < (
select max(Price) from #Sales
)

--Find the total quantity of products sold per month using a subquery
--4
select * from (
select  MONTH(SaleDate) as month , SUM(Quantity) TotalQuantity from #Sales
group by month(saledate) ) as sls

--Find customers who bought same products as another customer using EXISTS
--5
select * from #Sales s1
where exists (
select 1 from #Sales s2
where s1.Product = s2.Product
and s1.CustomerName<>s2.CustomerName
)
--6
;
with cte as (
select Name, COUNT(Fruit) Qty from Fruits
where Fruit = 'Apple'
group by Name
), cte1 as (
select Name, COUNT(Fruit) Qty from Fruits
where Fruit = 'Orange'
group by Name
), cte2 as (
select Name, COUNT(Fruit) Qty from Fruits
where Fruit = 'Banana'
group by Name
)

select a.Name, a.Qty Apple, o.Qty Orange, b.Qty Banana from cte a 
join cte1 o on a.Name=o.Name
join cte2 b on o.Name=b.Name


--7
select a.ParentId, b.ChildID from Family a
join Family b on a.ParentId < b.ChildID
order by a.ParentId


--8
select * from #Orders
where CustomerID in (
select CustomerID from #Orders
where DeliveryState = 'CA')
and DeliveryState = 'TX'


--9

select *, 
case 
	when address not like '%name%' then STUFF(address, CHARINDEX('age', address)-1, 1, ' name=' + fullname + ' ')
	else address
end new_address
from #residents

--10
select CONCAT_WS(' - ', a.DepartureCity,a.ArrivalCity,b.ArrivalCity) Route, a.Cost + b.Cost Cost from #Routes a
join #Routes b on a.ArrivalCity = b.DepartureCity
where a.Cost + b.Cost = 500 and a.DepartureCity = 'Tashkent'
union all
select concat_ws(' - ', a.departurecity,a.arrivalcity, b.arrivalcity, c.arrivalcity, d.arrivalcity) Route, a.Cost + b.Cost + c.Cost + d.Cost Cost from #routes a
join #routes b on a.arrivalcity = b.departurecity
join #routes c on b.arrivalcity = c.departurecity
join #routes d on c.arrivalcity = d.departurecity

--11
select *, ROW_NUMBER() over(order by id) Rank from #RankingPuzzle
where Vals = 'Product'

--12
select * from #EmployeeSales a
where SalesAmount>(
select AVG(SalesAmount) from #EmployeeSales b
where a.Department=b.Department
)

--Find employees who had the highest sales in any given month using EXISTS
--13
select * from #EmployeeSales c
where exists 
(
	select 1 from #EmployeeSales a
	where c.EmployeeID = a.EmployeeID
	and a.SalesMonth = c.SalesMonth
	and SalesAmount = 
		(
		select MAX(SalesAmount) from #EmployeeSales b
		where b.SalesMonth = a.SalesMonth
		--group by SalesMonth
		)
)


--14 
--given table does not support the question 


--15
select Name from Products
where Price > (select AVG(Price) from Products)

--16
select * from Products
where Stock < (
select max(Stock) from Products
)

--17
select name from Products
where Category = (
select Category from Products
where Name = 'Laptop'
)

--18
select * from Products
where Price > (select MIN(Price) from Products where Category = 'Electronics')

--19
select * from Products a
where Price > (
select AVG(Price) from Products b
where a.Category = b.Category
)

--Find the products that have been ordered at least once.
--20
select distinct ProductID from Orders
where Quantity >= 1

--Retrieve the names of products that have been ordered more than the average quantity ordered.
--21
with cte as (
select * from Orders
where Quantity > (select AVG(Quantity) from Orders))

select p.Name from cte o
join Products p on o.ProductID = p.ProductID

--Find the products that have never been ordered.
--22

select * from Products p
where not exists (
select 1 from Orders o
where p.ProductID = o.ProductID
)

--Retrieve the product with the highest total quantity ordered.
--23

select * from Products
where ProductID = (
select ProductID from Orders
where Quantity = (select MAX(Quantity) from Orders))
