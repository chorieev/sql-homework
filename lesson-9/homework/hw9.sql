
--the start point of hw

--Easy-Level Tasks

select p.ProductName, s.SupplierName from Products p
join Suppliers s on p.SupplierID = s.SupplierID

select * from Departments d 
cross join Employees e --on d.DepartmentID = e.DepartmentID

select p.ProductName, s.SupplierName from Products p
join Suppliers s on p.SupplierID = s.SupplierID

select c.FirstName, c.LastName, o.OrderID from Orders o
join Customers c on o.CustomerID= c.CustomerID

select * from Courses
cross join Students

select p.ProductName, o.OrderID from Products p
join Orders o on p.ProductID = o.ProductID

select e.EmployeeID, e.Name, d.DepartmentName from Employees e
join Departments d on e.DepartmentID= d.DepartmentID

select s.Name, e1.CourseID from Students s 
join Enrollments e1 on s.StudentID = e1.StudentID

select o.* from Orders o
join Payments p1 on o.OrderID= p1.OrderID

select o.* from Orders o
join Products p on p.ProductID = o.ProductID
where p.Price > 100

--Medium 

select e.Name, d.DepartmentName from Employees e
join Departments d on d.DepartmentID!=e.DepartmentID

select o.* from Orders o 
join Products p on o.ProductID = p.ProductID
where o.Quantity>p.StockQuantity

--Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
select c2.FirstName, c2.LastName, s1.ProductID from Customers c2
join Sales s1 on c2.CustomerID=s1.CustomerID
where s1.SaleAmount > 500

--Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
select s1.Name,c1.CourseName from Courses c1
join Enrollments e1 on c1.CourseID=e1.CourseID
join Students s1 on s1.StudentID=e1.StudentID

--Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
select p.ProductName, s.SupplierName from Products p 
join Suppliers s on p.SupplierID = s.SupplierID
where s.SupplierName like '%Tech%'

--Using Orders, Payments table Show orders where payment amount is less than total amount.
select o.* from Orders o
join Payments p on o.OrderID=p.OrderID
where p.Amount<o.TotalAmount

--Using Employees and Departments tables, get the Department Name for each employee.
select e.*, d.DepartmentName from Employees e
join Departments d on e.DepartmentID=d.DepartmentID

--Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
select p.* from Products p 
join Categories c3 on p.Category=c3.CategoryID
where c3.CategoryName in ('Electronics', 'Furniture')

--Using Sales, Customers table Show all sales from customers who are from 'USA'.
select s1.* from Sales s1
join Customers c on s1.CustomerID=c.CustomerID
where c.Country = 'USA'

--Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.

select o.* from Orders o
join Customers c on o.CustomerID = c.CustomerID
where c.Country = 'Germany' and o.TotalAmount > 100

--Hard 

--Using Employees table List all pairs of employees from different departments.
select e.Name,e.DepartmentID,e2.Name,e2.DepartmentID from Employees e
join Employees e2 on e.DepartmentID<>e2.DepartmentID
where e.DepartmentID>e2.DepartmentID

--Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).

select p1.* from Payments p1
join Orders o on p1.OrderID=o.OrderID
join Products p on o.ProductID=p.ProductID
where p1.Amount<>o.Quantity*p.Price

--Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
select s1.* from Students s1
left join Enrollments e1 on s1.StudentID=e1.StudentID
where e1.StudentID is null

--Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
select e2.* from Employees e1
join Employees e2 on e1.EmployeeID=e2.ManagerID
where e2.Salary <= e1.Salary

--Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.

select c.* from Payments p
join Orders o on p.OrderID = o.OrderID
join Customers c on o.CustomerID=c.CustomerID


select * from Payments
select * from Orders
select * from Customers
select * from Products
select * from Categories
select * from Suppliers
select * from Departments
select * from Employees
select * from Sales
select * from Students
select * from Enrollments
order by StudentID
select * from Courses
