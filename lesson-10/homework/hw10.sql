--the start point of hw

--Easy-Level Tasks

--Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
--🔁 Expected Columns: EmployeeName, Salary, DepartmentName
select e.Name EmployeeName, e.Salary,d.DepartmentName from Employees e 
join Departments d on e.DepartmentID=d.DepartmentID
where e.Salary> 50000

--Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
--🔁 Expected Columns: FirstName, LastName, OrderDate

select c.FirstName, c.LastName, o.OrderDate from Customers c 
join Orders o on c.CustomerID=o.CustomerID
and  year(o.OrderDate) = '2023'

--Using the Employees and Departments tables, write a query to show all employees along with their department names. 
--Include employees who do not belong to any department.
--🔁 Expected Columns: EmployeeName, DepartmentName

select e.Name EmployeeName, d.DepartmentName from Employees e 
left join Departments d on e.DepartmentID=d.DepartmentID

--Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
--🔁 Expected Columns: SupplierName, ProductName

select s.SupplierName, p.ProductName from Suppliers s
left join Products p on s.SupplierID=p.SupplierID

--Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. 
--Include orders without payments and payments not linked to any order.
--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount

select o.OrderID,o.OrderDate, p.PaymentDate, p.Amount from Orders o
full join Payments p on o.OrderID=p.OrderID

--Using the Employees table, write a query to show each employee's name along with the name of their manager.
--🔁 Expected Columns: EmployeeName, ManagerName

select e.Name EmployeeName, e1.Name ManagerName from Employees e 
join Employees e1 on e.EmployeeID=e1.ManagerID

--Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
--🔁 Expected Columns: StudentName, CourseName

select s.Name Studentname, c.CourseName from Students s
join Enrollments e on s.StudentID=e.StudentID
join Courses c on e.CourseID=c.CourseID
where c.CourseName = 'Math 101'

--Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. 
--Return their name and the quantity they ordered.
--🔁 Expected Columns: FirstName, LastName, Quantity

select c.FirstName, c.LastName, o.Quantity from Customers c 
join Orders o on c.CustomerID = o.CustomerID
where o.Quantity > 3

--Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
--🔁 Expected Columns: EmployeeName, DepartmentName

select e.Name EmployeeName, d.DepartmentName from Employees e 
join Departments d on e.DepartmentID=d.DepartmentID 
and d.DepartmentName='Human Resources'


--Medium-Level Tasks

--Using the Employees and Departments tables, write a query to return department names that have more than 5 employees.
--🔁 Expected Columns: DepartmentName, EmployeeCount

select d.DepartmentName, count(e.Name) EmployeeCount from Employees e 
join Departments d on e.DepartmentID=d.DepartmentID
group by d.DepartmentName
having count(e.Name) > 5

--Using the Products and Sales tables, write a query to find products that have never been sold.
--🔁 Expected Columns: ProductID, ProductName

select s.ProductID, p.ProductName from Products p 
left join Sales s on p.ProductID=s.ProductID
where s.ProductID is null

--Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
--🔁 Expected Columns: FirstName, LastName, TotalOrders

select c.FirstName, c.LastName, count(o.OrderID) TotalOrders from Customers c
join Orders o on c.CustomerID=o.CustomerID
group by c.FirstName, c.LastName
having count(o.OrderID) >= 1

--Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
--🔁 Expected Columns: EmployeeName, DepartmentName

select e.Name EmployeeName, d.DepartmentName from Employees e 
INNER join  Departments d on e.DepartmentID=d.DepartmentID

--Using the Employees table, write a query to find pairs of employees who report to the same manager.
--🔁 Expected Columns: Employee1, Employee2, ManagerID

select e1.EmployeeID Employee1, e2.EmployeeID Employee2, e1.ManagerID from Employees e1 
join Employees e2 on e1.ManagerID=e2.ManagerID and e1.EmployeeID<e2.EmployeeID

--Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
--🔁 Expected Columns: OrderID, OrderDate, FirstName, LastName

select o.OrderID,o.OrderDate,c.FirstName,c.LastName from Orders o
join Customers c on o.CustomerID=c.CustomerID
where YEAR(o.OrderDate) = '2022'

--Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
--🔁 Expected Columns: EmployeeName, Salary, DepartmentName

select e.Name EmployeeName, e.Salary, d.DepartmentName from Employees e 
join Departments d on e.DepartmentID=d.DepartmentID where d.DepartmentName='Sales' and e.Salary>60000

--Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount

select o.OrderID,o.OrderDate,p.PaymentDate,p.Amount from Orders o
INNER join Payments p on o.OrderID=p.OrderID

--Using the Products and Orders tables, write a query to find products that were never ordered.
--🔁 Expected Columns: ProductID, ProductName

select o.ProductID, p.ProductName from Products p
left join Orders o on p.ProductID=o.ProductID
where o.ProductID is null

--Hard-Level Tasks

--Using the Employees table, write a query to find employees whose salary is greater than the average salary in their own departments.
--🔁 Expected Columns: EmployeeName, Salary

select e1.Name EmployeeName, e1.Salary from Employees e1
join ( select  d.DepartmentID ,AVG(e.salary) [avg salary per dep] 
from Employees e 
join Departments d on e.DepartmentID=d.DepartmentID
group by d.DepartmentID) avg_tbl on e1.DepartmentID=avg_tbl.DepartmentID
where e1.Salary > avg_tbl.[avg salary per dep]
/*
select * from (
select  d.DepartmentID ,AVG(e.salary) [avg salary per dep] 
from Employees e 
join Departments d on e.DepartmentID=d.DepartmentID
group by d.DepartmentID) avg_tbl
*/

--Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
--🔁 Expected Columns: OrderID, OrderDate

select o.OrderID, o.OrderDate from Orders o
left join Payments p on o.OrderID = p.OrderID
where year(o.OrderDate) < 2020 and p.OrderID is null


--Using the Products and Categories tables, write a query to return products that do not have a matching category.
--🔁 Expected Columns: ProductID, ProductName

select p.ProductID, p.ProductName from Products p
left join Categories c on p.Category=c.CategoryID
where c.CategoryID is null

--Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
--🔁 Expected Columns: Employee1, Employee2, ManagerID, Salary

select e1.EmployeeID Employee1, e2.EmployeeID Employee2, e1.ManagerID, e1.Salary /*Salary1, e2.Salary Salary2*/ from Employees e1
join Employees e2 on e1.ManagerID=e2.ManagerID and e1.EmployeeID<e2.EmployeeID
where e1.Salary>60000 and e2.Salary>60000


--Using the Employees and Departments tables, write a query to return employees who work in departments which name starts with the letter 'M'.
--🔁 Expected Columns: EmployeeName, DepartmentName

select e.Name EmployeeName, d.DepartmentName from Employees e 
join Departments d on e.DepartmentID=d.DepartmentID
where d.DepartmentName like 'M%'


--Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
--🔁 Expected Columns: SaleID, ProductName, SaleAmount


select s.SaleID, p.ProductName, s.SaleAmount from Products p
join Sales s on p.ProductID=s.ProductID
where s.SaleAmount > 500

--Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
--🔁 Expected Columns: StudentID, StudentName

select s.StudentID, s.Name StudentName from Students s 
left join Enrollments e on s.StudentID=e.StudentID
left join Courses c on e.CourseID=c.CourseID
and c.CourseName='Math 101'
where c.CourseName is null


--Using the Orders and Payments tables, write a query to return orders that are missing payment details.
--🔁 Expected Columns: OrderID, OrderDate, PaymentID

select o.OrderID, o.OrderDate, p.PaymentID from Orders o
left join Payments p on o.OrderID=p.OrderID
where p.PaymentID is null

--Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
--🔁 Expected Columns: ProductID, ProductName, CategoryName

select p.ProductID, p.ProductName, c.CategoryName from Products p
join Categories c on p.Category=c.CategoryID
where c.CategoryName='Electronics' or c.CategoryName = 'Furniture'

select * from Employees 
select * from Departments
select * from Customers
select * from Orders
select * from Products
select * from Suppliers
select * from Orders
select * from Payments
select * from Students
select * from Enrollments
select * from Courses
select * from Products
select * from Sales
select * from Orders
select * from Payments
select * from Products
select * from Orders
select * from Products
select * from Categories
select * from Orders
select * from Payments
