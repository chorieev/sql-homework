create database F32_class3_hw
use F32_class3_hw

--Easy-Level Tasks

/*
1.
The purpose of BULK INSERT is to get database from computer files/memory.
Let me explain it through example: 
bulk insert [F32_class3].[dbo].[Emails]
from 'C:\Users\westm\Downloads\Telegram Desktop\Emails.csv'
with (
firstrow=2,
fieldterminator=',',
rowterminator='\n'
)

The 1 row tells where to insert the database(we can specify name of database and which table to insert), 
here in example we'r inserting it to F32_class3 database to Emails table.
The 2 row tells where to get the database from(there we copy the path of that file), 
here in example we copied the path of csv file.
Starting from 3 row, we enter the conditions using command WITH (there we can enter setting the first row, how to read the file(using what) or how to seperate each row),
here in example we used 'firstrow=2' which means to start first row from second row in the file, we used 'fieldterminator=','' which tells the program that each data is seperated by comma, lastly we used 'rowterminator='\n'' which tells how to seperate each row.

2.
4 file formats that can be imported into sql server:
csv -- comma seperated values
txt -- text file
xls/xlsx -- excel file
xml -- extensible markup language
*/

--3
create table Products (
ProductID int primary key, 
ProductName varchar(50),
Price decimal(10,2)
)

--4
insert into Products values 
(101, 'cola', 11000),
(102, 'pepsi', 12000),
(103, 'fanta', 13000)

--5
/*
difference between NULL and NOT NULL
NULL--> means no value, column can be empty, it does not require any value when inserting which we can skip that column.
NOL NULL--> is opposite of the previous, we must enter a value to it, column can not be left empty, like ID we cannot skip it.
*/

--6
alter table Products
add constraint u_pname unique (ProductName)

--7
/*
so the purpose of UNIQUE constraint here is that none of the data we are inserting must be the same, all data must different.
*/

--8
alter table Products 
add CategoryID int

--9
create table Categories (
CategoryID int primary key,
CategoryName varchar(50) unique
)

--10
/*
so the purpose of IDENTITY is to set increment specifying certain numbers, 
ex: create table Orders (Orderid int primary key identity(1,1))
here we'r creating table and column OrderID and setting this column an increment which starts from 1 and increases by 1 when we insert record into it , and we dont need to write data for this column when inserting.
*/


truncate table Products

--Medium-Level Tasks

--11
bulk insert [F32_class3_hw].[dbo].[Products]
from 'C:\Users\westm\Desktop\1\Book1.txt'
with (
firstrow = 2,
fieldterminator='	',
rowterminator='\n'
)

insert into Categories values 
(201, 'liquid'),
(202, 'soda'),
(203, 'caffeine'),
(204, 'coffee'),
(205, 'vegetable')

--12
alter table Products 
add constraint fk_Products_Categories
foreign key (CategoryID) references Categories(CategoryID)

select * from Products p join
Categories c on p.CategoryID = c.CategoryID

--13
/*
the difference between PRIMARY KEY and UNIQUE KEY
PRIMARY KEY --> unique and not null, which means each data we insert must be different from the other and we cant left the column empty.
UNIQUE KEY --> we can leave the coulmn empty and none of the data can be the same.
*/

--14
alter table Products
add constraint chk_price check (Price>0)

--15
alter table Products 
add Stock int not null identity (1000,50)

--16
update Products
set Price=NULL
where ProductID=102 or ProductID=104

select ProductName, ISNULL(Price,0) as Price
from Products

--17
/*
The purpose of a foreign key is to create a relationship between two tables. 
The parent table contains a primary key, and the child table contains a foreign key that references the primary key of the parent table. 
This ensures that the data in the child table corresponds to valid data in the parent table, 
maintaining referential integrity. 
You cannot delete a record from the parent table if related records exist in the child table, 
unless you use options like ON DELETE CASCADE or ON UPDATE CASCADE.
*/

--Hard-Level Tasks

--18
create table Customers (
CustomerName varchar(50),
Age int check(Age>=18)
)

--19
create table Partners (
PartnerID int identity(100,5),
PartnerName varchar(50)
)

--20
create table OrderDetails (
OrderID int,
OrderName varchar(50),
ProductID int,
primary key (OrderID, ProductID)
)

--21
/*
we use COALESCE to get the first non-null value. 
we use ISNULL to get null values as specifiec value (0) to console.
*/

--22
create table Employees (
EmpID int primary key,
Email varchar(50) unique
)

--23
create table Orders (
OrderID int,
OrderName varchar(50),
ProductID int,
	constraint fk_product
	foreign key (ProductID)
	references Products (ProductID)
	on delete cascade
	on update cascade
)

select * from Orders
select * from Categories
