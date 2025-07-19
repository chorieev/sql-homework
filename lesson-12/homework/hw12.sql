--1
select p.firstName, p.lastName, a.city, a.state from Person p
left join Address a on p.personId = a.personId
--
--2
select e1.name Empoyee from Employee e1
join Employee e2 on e1.managerId=e2.id
where e1.salary>e2.salary
--
--3
select email from Person_
group by email
having COUNT(email)>1
--
--4
delete b from Person_ a
join Person_ b on a.email=b.email and a.id<b.id
--
--5
select g.ParentName from girls g
left join boys b on g.ParentName=b.ParentName
where b.Id is null
--
--6
select custid,
sum(case when freight>50 then o2.qty * o2.unitprice
	else 0 end ) TotalSales,
	MIN(freight) MinWeight
from TSQL2012.Sales.Orders o1
join TSQL2012.Sales.OrderDetails o2 on o1.orderid=o2.orderid
group by custid
--
--7
select isnull(Cart1.Item, '') [Item Cart 1], isnull(Cart2.Item, '') [Item Cart 2] from Cart1
full join Cart2 on Cart1.Item=Cart2.Item
--
--8
select c.name from Customers c
left join Orders o on c.id=o.customerId
where o.id is null
--
--9
select s1.student_id,s1.student_name,s2.subject_name, COUNT(e1.subject_name) Attended_Exams from Students s1
cross join Subjects s2
left join Examinations e1 on e1.student_id=s1.student_id and e1.subject_name=s2.subject_name
group by s1.student_id,s1.student_name,s2.subject_name
order by s1.student_id, s2.subject_name
--
