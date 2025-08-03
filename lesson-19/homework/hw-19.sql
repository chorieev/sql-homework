
--1
create proc sp_EmployeeBonus
as 
begin
	create table #EmployeeBonus (EmployeeID int, FullName varchar(50), Department varchar(50), Salary decimal(10,2), BonusAmount decimal(10,2))

	insert into #EmployeeBonus
	select EmployeeID, FirstName + ' ' + LastName as FullName, e.Department, Salary, Salary*BonusPercentage/100 as BonusAmount from Employees e
	join DepartmentBonus d on e.Department = d.Department

	select * from #EmployeeBonus
end

exec sp_EmployeeBonus

--2
create proc sp_Salary
@DepName varchar(50),
@IncPer int
as 
begin
	update Employees
	set Salary = Salary + @IncPer*Salary/100
	where Department = @DepName

	select * from Employees
	where Department = @DepName
end

exec sp_Salary 'IT', 10 

--3
merge Products_Current c
using Products_new n 
on c.productid = n.productid

when matched then
	update set c.productname = n.productname,
				c.price = n.price

when not matched then
	insert (ProductID, ProductName, Price)
	values (n.ProductID, n.ProductName, n.Price)

when not matched by source then
	delete;

select * from Products_Current

--4
with cte_tree as (
select id from Tree
union all
select p_id from Tree
)
select t1.id, --COUNT(t2.id),
case 
	when COUNT(t2.p_id) = 0 then 'Root'
	when COUNT(t2.p_id) = 3 then 'Inner'
	else 'Leaf'
	end type
from cte_tree t1
left join Tree t2 on t1.id=t2.id
group by t1.id
having COUNT(t2.id) <> 0

--different approach
select id,
case when p_id is null then 'Root'
when id in (select p_id from Tree) then 'Inner'
else 'Leaf'
end type
from Tree
--5	

select user_id, action from Confirmations
select s.user_id, 
CAST
	(
	coalesce
		(
		AVG(case when action = 'confirmed' then 1.0 else 0.0 end), 0  --THE IMPORTANT POINT
		)
		--sum(case when action = 'confirmed' then 1 else 0 end)*1.0/COUNT(s.user_id)
		as decimal(10,2)
	) as confirmation_rate
from Signups s
left join Confirmations c on s.user_id=c.user_id	
group by s.user_id

--6
select * from employees
where salary = (
select MIN(salary) from employees)

--7
create proc GetProductSalesSummary
@ProductID int
as 
begin
	select p.ProductName, SUM(s.Quantity) TotalQuantity, SUM(Quantity*Price) TotalAmount, MIN(SaleDate) FirstDate, MAX(SaleDate) LastDate from Products p
	left join Sales s on p.ProductID = s.ProductID
	where p.ProductID = @ProductID
	group by p.ProductName

end
;

exec GetProductSalesSummary 19
