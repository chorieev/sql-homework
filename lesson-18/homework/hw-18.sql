--1
create table #MonthlySales (ProductID int, TotalQuantity int, TotalRevenue int)

insert into #MonthlySales 
select s.ProductID, SUM(Quantity) TotalQuantity, sum(Quantity*Price) TotalRevenue from Sales s
join Products p on s.ProductID=p.ProductID
group by s.ProductID

select * from #MonthlySales
--2
create view vw_ProductSalesSummary as 
select p.ProductID,p.ProductName,p.Category, sum(s.quantity) TotaQuantitySold from Products p
join Sales s on p.ProductID=s.ProductID
group by p.ProductID,p.ProductName,p.Category

select * from vw_ProductSalesSummary
--3
create function fn_GetTotalRevenueForProduct(@ProductID INT)
returns int
as 
begin
	declare @TotalRevenue int;
	select @TotalRevenue = sum(Quantity*Price) from Products p
	join Sales s on p.ProductID=s.ProductID and s.ProductID = @ProductID
	group by p.ProductID
	
	return @TotalRevenue
end

select dbo.fn_GetTotalRevenueForProduct(20) TotalRevenue
--4

Create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns @result table (
ProductName varchar(50),
TotalQuantity int,
TotalRevenue int
)
as
begin
	insert into @result
	select p.ProductName, SUM(Quantity) TotalQuantity, SUM(Quantity*Price) TotalRevenue from Products p
	join Sales s on p.ProductID=s.ProductID
	where Category = @Category
	group by p.ProductName, Category
	return;
end

select * from dbo.fn_GetSalesByCategory('Clothing')


--5
Create function dbo.fn_IsPrime (@Number INT)
returns varchar(50)
as

begin
	if @Number <= 1 
	return 'No'
	else 
	declare @i int = 2
	while @i*@i<=@Number
	begin
		if @number % @i = 0
		return 'No'
		
		set @i=@i + 1
	end
	return 'Yes'
end;

select dbo.fn_IsPrime(97)

--6
create function fn_GetNumbersBetween(@start int, @end int)
returns table as
return
	with cte12 as 
	(
	select @start as number
	union all
	select number + 1 
	from cte12
	where number + 1 <= @end
	)
select * from cte12

select * from fn_GetNumbersBetween(1,100)

--7
create function NthHighestSalary (@n int)
returns @result table (
	HighestNSalary int
)
as
begin
	insert into @result
	select salary 
	from (
	select *,
	RANK() over (order by salary desc) as rnk
	from Employees ) emp
	where rnk = @n
	
	if not exists (select 1 from @result)
	insert into @result values (null)

	return
end 
select * from NthHighestSalary(2)

--8
select requester_id id, COUNT(requester_id) num from 
(
	select requester_id from Friendships
	union all
	select accepter_id from Friendships
) frnd
	group by requester_id
	having COUNT(requester_id) = 
	(
		select MAX(NumOfFrnd) from 
		( 
			select requester_id, COUNT(requester_id) NumOfFrnd from 
			(
				select requester_id from Friendships
				union all
				select accepter_id from Friendships
			) frnd
			group by requester_id
		) frnd1
	)


--9
create view vw_CustomerOrderSummary as
select c.customer_id, c.name, COUNT(order_id) total_orders, SUM(amount) total_amount, MAX(o.order_date) last_order_date from Orders o
join Customers c on o.customer_id=c.customer_id
group by c.customer_id, c.name

select * from vw_CustomerOrderSummary


--10
declare @rownum int;
select @rownum = rownumber from Gaps
where RowNumber = 1

declare @testcase varchar(50);
select @testcase = testcase from Gaps
where RowNumber = 1

declare @rownum1 int;
select @rownum1 = rownumber from Gaps
where RowNumber = 5

declare @testcase1 varchar(50);
select @testcase1 = testcase from Gaps
where RowNumber = 5

declare @rownum2 int;
select @rownum2 = rownumber from Gaps
where RowNumber = 10

declare @testcase2 varchar(50);
select @testcase2 = testcase from Gaps
where RowNumber = 10


;with cte_gaps as (
select @rownum as RowNumber, @testcase as TestCase
union all
select rownumber + 1, testcase from cte_gaps
where rownumber + 1 <= 4
),
cte_gaps1 as (
select @rownum1 as RowNumber, @testcase1 as TestCase
union all
select rownumber + 1, testcase from cte_gaps1
where rownumber + 1 <= 9
),
cte_gaps2 as (
select @rownum2 as RowNumber, @testcase2 as TestCase
union all
select rownumber + 1, testcase from cte_gaps2
where rownumber + 1 <= 12
)

select * from cte_gaps
union all
select * from cte_gaps1
union all
select * from cte_gaps2
