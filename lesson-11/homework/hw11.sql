--Easy-Level Tasks

--Return: OrderID, CustomerName, OrderDate
--Task: Show all orders placed after 2022 along with the names of the customers who placed them.
--Tables Used: Orders, Customers

select o.OrderID,c.FirstName + ' ' + c.LastName as CustomerName, o.OrderDate from Orders o
join Customers c on o.CustomerID=c.CustomerID
where year(o.OrderDate)>'2022'

--Return: EmployeeName, DepartmentName
--Task: Display the names of employees who work in either the Sales or Marketing department.
--Tables Used: Employees, Departments

select e.Name EmployeeName, D.DepartmentName from Employees e
join Departments d on e.DepartmentID=d.DepartmentID
where d.DepartmentName='Sales' or d.DepartmentName='Marketing'

--Return: DepartmentName, MaxSalary
--Task: Show the highest salary for each department.
--Tables Used: Departments, Employees

select d.DepartmentName, max(e.Salary) MaxSalary from Employees e
join Departments d on e.DepartmentID=d.DepartmentID
group by d.DepartmentName

--Return: CustomerName, OrderID, OrderDate
--Task: List all customers from the USA who placed orders in the year 2023.
--Tables Used: Customers, Orders

select c.FirstName + ' ' + c.LastName as CustomerName, o.OrderID, o.OrderDate from Customers c
join Orders o on c.CustomerID=o.CustomerID
where c.Country='USA' and YEAR(o.OrderDate)='2023'

--Return: CustomerName, TotalOrders
--Task: Show how many orders each customer has placed.
--Tables Used: Orders , Customers

select c.FirstName + ' ' + c.LastName as CustomerName, count(o.OrderID) TotalOrders from Orders o
join Customers c on o.CustomerID=c.CustomerID
group by c.FirstName + ' ' + c.LastName

--Return: ProductName, SupplierName
--Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
--Tables Used: Products, Suppliers

select p.ProductName, s.SupplierName from Products p
join Suppliers s on p.SupplierID=s.SupplierID
where s.SupplierName = 'Gadget Supplies' or s.SupplierName='Clothing Mart'


--Return: CustomerName, MostRecentOrderDate
--Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
--Tables Used: Customers, Orders

select c.FirstName + ' ' + c.LastName as CustomerName, max(o.OrderDate) MostRecentOrderDate from Customers c
left join Orders o on c.CustomerID=o.CustomerID
group by c.FirstName, c.LastName, c.CustomerID


--Medium-Level Tasks

--Return: CustomerName, OrderTotal
--Task: Show the customers who have placed an order where the total amount is greater than 500.
--Tables Used: Orders, Customers

select c.FirstName + ' ' + c.LastName as CustomerName, o.TotalAmount OrderTotal from Customers c 
join Orders o on c.CustomerID=o.CustomerID
where o.TotalAmount>500

--Return: ProductName, SaleDate, SaleAmount
--Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
--Tables Used: Products, Sales

select p.ProductName, s.SaleDate, s.SaleAmount from Products p
join Sales s on p.ProductID=s.ProductID
where year(SaleDate) = '2022' or s.SaleAmount>400

--Return: ProductName, TotalSalesAmount
--Task: Display each product along with the total amount it has been sold for.
--Tables Used: Sales, Products

select p.ProductName, sum(s.SaleAmount) TotalSalesAmount from Products p 
join Sales s on p.ProductID=s.ProductID
group by p.ProductName, p.ProductID

--Return: EmployeeName, DepartmentName, Salary
--Task: Show the employees who work in the HR department and earn a salary greater than 60000.
--Tables Used: Employees, Departments

select e.Name EmployeeName, d.DepartmentName, e.Salary from Employees e
join Departments d on e.DepartmentID=d.DepartmentID
where d.DepartmentName='Human Resources' and e.Salary>60000

--Return: ProductName, SaleDate, StockQuantity
--Task: List the products that were sold in 2023 and had more than 100 units in stock at the time.
--Tables Used: Products, Sales

select p.ProductName, s.SaleDate, p.StockQuantity from Products p
join Sales s on p.ProductID=s.ProductID
where year(s.SaleDate)='2023' and p.StockQuantity>100

--Return: EmployeeName, DepartmentName, HireDate
--Task: Show employees who either work in the Sales department or were hired after 2020.
--Tables Used: Employees, Departments

select e.Name EmployeeName, d.DepartmentName, e.HireDate from Employees e
join Departments d on e.DepartmentID=d.DepartmentID
where d.DepartmentName='Sales' or year(e.HireDate)>'2020'

--Hard-Level Tasks

--Return: CustomerName, OrderID, Address, OrderDate
--Task: List all orders made by customers in the USA whose address starts with 4 digits.
--Tables Used: Customers, Orders

select c.FirstName + ' ' + c.LastName as CustomerName, o.OrderID, c.Address,o.OrderDate from Customers c
join Orders o on c.CustomerID=o.CustomerID
where c.Country='USA' and c.Address like '[0-9][0-9][0-9][0-9]%'

--Return: ProductName, Category, SaleAmount
--Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
--Tables Used: Products, Sales

select p.ProductName, p.Category, s.SaleAmount from Products p
join Sales s on p.ProductID=s.ProductID
where p.Category=1 or s.SaleAmount>350

--Return: CategoryName, ProductCount
--Task: Show the number of products available in each category.
--Tables Used: Products, Categories

select c.CategoryName, count(p.ProductID) ProductCount from Products p
join Categories c on p.Category=c.CategoryID
group by c.CategoryName

--Return: CustomerName, City, OrderID, Amount
--Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
--Tables Used: Customers, Orders

select c.FirstName + ' ' + c.LastName as CustomerName, c.City, o.OrderID, o.TotalAmount Amount from Customers c
join Orders o on c.CustomerID=o.CustomerID
where c.City='Los Angeles' and o.TotalAmount>300

--Return: EmployeeName, DepartmentName
--Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
--Tables Used: Employees, Departments

select e.Name EmployeeName, d.DepartmentName from Employees	e 
join Departments d on e.DepartmentID=d.DepartmentID
where d.DepartmentName='Human Resources' or d.DepartmentName='Finance' or e.Name like '%[a,e,i,o,u,A,E,I,O,U]%[a,e,i,o,u,A,E,I,O,U]%[a,e,i,o,u,A,E,I,O,U]%[a,e,i,o,u,A,E,I,O,U]%'

--Return: EmployeeName, DepartmentName, Salary
--Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
--Tables Used: Employees, Departments

select e.Name EmployeeName, d.DepartmentName, e.Salary from Employees e 
join Departments d on e.DepartmentID=d.DepartmentID
where (d.DepartmentName='Sales' or d.DepartmentName='Marketing') and e.Salary > 60000

