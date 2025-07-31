--1
select a.Region,b.Distributor, isnull(c.Sales, 0) Sales from Regionsales a
cross join RegionsalesDis b
left join #RegionSales c on a.Region=c.Region and b.Distributor=c.Distributor
--2
select b.name from Employee a
join Employee b on a.managerId = b.id
group by b.name
having  COUNT(b.id) >=5
--3
select p.product_name, SUM(unit) Unit from Orders o
join Products p on o.product_id = p.product_id
where datepart(month,order_date) = 2 and datepart(YEAR,order_date) = 2020
group by p.product_name
having SUM(unit)>=100 
--4
;with cte_orders as (
select CustomerID, Vendor, SUM(Count) TotalCount from Orders
group by CustomerID, Vendor	)

select b.CustomerID,b.Vendor from cte_orders b
where TotalCount = (
select MAX(TotalCount) from cte_orders a
where b.CustomerID=a.CustomerID
group by CustomerID )
order by b.CustomerID
--5
DECLARE @Check_Prime INT = 91;
declare @tbl table (num int)
declare @num int = 1

while (@num <= 100)
	begin 
		insert into @tbl values (@num)
		set @num = @num + 1
	end
select b.num from @tbl a
join @tbl b on a.num <= b.num
where b.num%a.num = 0
group by b.num
having count(*)=2

if exists 
(
	select 1 from 
	(
		select b.num from @tbl a
		join @tbl b on a.num <= b.num
		where b.num%a.num = 0
		group by b.num
		having count(*)=2
	) ab
	where ab.num = @Check_Prime
) 
	select 'number is prime'
else 
	select 'number is not prime'
--6
;with cte1 as 
(
	select Device_id, COUNT(Locations) no_of_signals from Device
	group by Device_id
),
cte2 as 
(
	select Device_id, COUNT(distinct Locations) no_of_locations from Device
	group by Device_id
),
cte3 as 
(
	select Device_id, Locations max_signal_location from Device
	group by Device_id,Locations
	having COUNT(Locations) in 
	(
		select MAX(Num_of_l) from 
		(
			select Device_id, Locations, COUNT(Locations) Num_of_l from Device
			group by Device_id,Locations
		) dvc
		group by Device_id 
	)
)

select cte1.Device_id, 
	cte2.no_of_locations, 
	cte3.max_signal_location, 
	cte1.no_of_signals 
from cte1
join cte2 on cte1.Device_id=cte2.Device_id
join cte3 on cte2.Device_id=cte3.Device_id
--7
select * from Employee
where Salary > (
select AVG(Salary) from Employee emp
where emp.DeptID=Employee.DeptID
)

--8
select t.TicketID, COUNT(n.Number) NumOfWinNum, 
case 
	when COUNT(n.Number) = 
	(
		select MAX(CountNum) from 
		(
			select COUNT(n.Number) CountNum
			from Tickets t
			join Numbers n on t.Number=n.Number
			group by t.TicketID
		) Num1
	)
	then '110$'
	else '10$'
	end LotteryAmount
from Tickets t
join Numbers n on t.Number=n.Number
group by t.TicketID

--9 not complete
;with cte_spending as (
select Spend.User_id,Spend.Spend_date,Spend.TotalAmount,
case when cnt = 2 then 'Both'
when MAX(sp.Platform) = 'Mobile' then 'Mobile'
else 'Desktop'
end Platform
from (
select User_id,Spend_date,SUM(Amount) TotalAmount, COUNT(distinct Platform) cnt from Spending
group by User_id,Spend_date ) Spend
join Spending sp on sp.User_id=Spend.User_id and sp.Spend_date=Spend.Spend_date
group by Spend.User_id,Spend.Spend_date,Spend.TotalAmount,Spend.cnt
)

select sp.Spend_date, sp.Platform,SUM(sp1.Amount) Total_Amount,count(distinct sp.User_id) Total_Users from cte_spending sp
join Spending sp1 on sp.User_id = sp1.User_id and sp.Spend_date = sp1.Spend_date --and sp.Platform = sp1.Platform
group by sp.Spend_date, sp.Platform
--group by User_id, Spend_date, TotalAmount,Platform


--10
declare @max int
select @max = MAX(quantity) from grouped
;with cte_num as (
select 1 as  number
union all
select number + 1 from cte_num
where number < @max )
--select * from cte_num

select g.Product,replace(g.Quantity,SUBSTRING(cast(g.quantity as varchar(50)), 1, 1), 1) Quantity from Grouped g
join cte_num ct on number <=Quantity
order by g.Product

