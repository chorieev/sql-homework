--1
select * from employees
where salary = (select MIN(salary) from employees)
--2
select * from products
where price > (select AVG(price) from products)
--3
select * from employees
where department_id  = (select id from departments where department_name = 'Sales')
--4
select * from customers 
where customer_id not in (select 
customer_id from orders 
)
--5
select * from products a
where price = (
select MAX(price) Max_Price from products b
where a.category_id=b.category_id 
group by category_id 
)
--6
select * from employees
where department_id = (select top 1 department_id from employees
group by department_id
order by AVG(salary) desc
)
--7
select * from employees
where salary > (
select AVG(salary) from employees a
where a.department_id = employees.department_id
group by department_id)
--8
select student_id, name from students
where student_id in 
(
	select student_id from grades a
	where grade = 
		(
			select MAX(grade) from grades b 
			where a.course_id = b.course_id
			group by course_id 
		)
)
--9
select * from (
select product_name,price, category_id ,RANK() over (partition by category_id order by price desc) as rank from products) as tbl_products
where rank = 3
--10
select * from employees a
where salary < ( 
select MAX(salary) from employees b
where a.department_id = b.department_id
group by department_id)
and salary > (select AVG(salary) from employees)
