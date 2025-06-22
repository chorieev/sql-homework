
/*
H/W --> class1
Easy-->
1. Data refers to figures that are raw. Different types: numbers, text, images and etc.
Database is the storage of data.
Relational database is basically includes multiple tables that consist of rows and columns.
Table is a structure that consists of rows and columns.
2. Using the feature SELECT we print the tables/data.
Using the feature CREATE, we can create databases or tables.
Using the feature INSERT we can insert data into tables.
There are the data types: 
		INT (used for integers), 
		VARCHAR/CHAR (used for string data types), 
		NVARCHAR/NCHAR(the same operation as varchar/char but more symbols and languages).
3. Windows Authentication and Sql Server Authentication
*/
--Medium-->
--4.
create database SchoolDB 
use SchoolDB
--5.
create table Students (StudentID int primary key, Name varchar(50), Age int)
select * from Students
/*
6. the differences between ssms, sql and sql server--> 
almost the same but there are some specific parts in each directed to specific purposes for organizations.
*/
--Hard-->
/*
7.
DDL - Data Definition Language.
Common features: CREATE, ALTER, DROP, TRUNCATE
Ex: create database SchoolDB ; truncate table Students;

DML - Data Manipulation Language.
Common features: INSERT, UPDATE, DELETE
Ex: insert into Students values (01, 'Behruz', 17); delete from Students where StudentID = 04;

DQL - Data Query Language.
Common features: SELECT
Ex: select * from Students;

DCL - Data Control Language.
Common features: GRANT, REVOKE
Ex: grant select on Employees to user1; revoke select on Employees from user1;

TCL -  Transaction control Language.
Common features: COMMIT, ROLLBACK
*/

--8.
insert into Students values (01, 'Behruz', 17),
(02, 'Davron', 18),
(03, 'O"ktam', 19)
--delete from Students where StudentID = 04
--truncate table Students

--9.
--restored.
