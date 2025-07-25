--the start point of hw

--easy level tasks
--You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.

select concat(EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME) from Employees

--Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
update Employees
set PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999')
where PHONE_NUMBER like '%124%'

--That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. 
--Give each column an appropriate label. Sort the results by the employees' first names.(Employees)
select FIRST_NAME, LEN(FIRST_NAME) Len_FirstName from Employees
where FIRST_NAME like '[A,J,M]%'
order by FIRST_NAME

--Write an SQL query to find the total salary for each manager ID.(Employees table)
select manager_id, SUM(salary) Total_salary from Employees
group by MANAGER_ID

--Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
select Year1, Max_n, value_n 
into TestMax1
from TestMax
unpivot
(
	value_n for Max_n in (Max1, Max2, Max3)
) as unpvt

select year1, max(value_n) from testMax1
group by year1

--Find me odd numbered movies and description is not boring.(cinema)
select * from cinema
where id%2!=0 and description <> 'boring'

--You have to sort data based on the Id but Id with 0 should always be the last row. 
--Now the question is can you do that with a single order by column.(SingleOrder)
select * from SingleOrder
order by Id desc

--Write an SQL query to select the first non-null value from a set of columns. 
--If the first column is null, move to the next, and so on. If all columns are null, return null.(person)
select coalesce(ssn, passportid, itin) non_null from person

--Medium Tasks

--Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
select SUBSTRING(
	FullName, 
	1, 
	CHARINDEX(' ', fullname)-1) FirstName, 

SUBSTRING(
	FullName, 
	CHARINDEX(' ', fullname)+1, 
	CHARINDEX(' ', fullname, CHARINDEX(' ', fullname)+1)-CHARINDEX(' ', fullname)) MiddleName,

SUBSTRING(
	FullName,
	CHARINDEX(' ', fullname, CHARINDEX(' ', fullname)+1)+1,
	LEN(fullname) - CHARINDEX(' ', FullName, CHARINDEX(' ', FullName)+1)
) LastName
from Students

--For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)

select o.CustomerID, o.OrderID,o.DeliveryState,o.Amount from Orders o
join (
select distinct customerid from Orders
where DeliveryState = 'CA') b on o.CustomerID=b.CustomerID
where DeliveryState='TX'

--Write an SQL statement that can group concatenate the following values.(DMLTable)
select STRING_AGG(String, ' ') from DMLTable

--Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
select lower(CONCAT_WS(' ', FIRST_NAME, LAST_NAME)) from Employees
where lower(CONCAT_WS(' ', FIRST_NAME, LAST_NAME)) like '%a%a%a%'

--The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
select DEPARTMENT_ID, 
	COUNT(EMPLOYEE_ID) total_employees,
	count(case when datediff(year, HIRE_DATE, GETDATE()) > 3 then 1 end) as [employees over 3 years exp],
	cast(count(case when datediff(year, HIRE_DATE, GETDATE()) > 3 then 1 end) as float) / count(EMPLOYEE_ID) * 100 as [percentage]
from Employees
group by DEPARTMENT_ID


--Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
--need window function!!


--Difficult Tasks

--Write an SQL query that separates the uppercase letters, lowercase letters, numbers, 
--and other characters from the given string 'tf56sd#%OqH' into separate columns.

declare @string varchar(50) = 'tf56sd#%OqH'
--select @string

declare @upper1 varchar(50) = substring(@string, charindex('O', @string), 1)
declare @upper2 varchar(50) = substring(@string, len(@string), 1)
--select @upper1
--select @upper2
declare @upper3 varchar(50) = concat(@upper1, @upper2)
select @upper3 as UPPERCASE

declare @lower1 varchar(50) = substring(@string, 1,2)
declare @lower2 varchar(50) = substring(@string, charindex('s', @string), 2)
declare @lower3 varchar(50) = substring(@string, charindex('q', @string), 1)
--select @lower3
declare @lower4 varchar(50) = concat(@lower1,@lower2,@lower3)
select @lower4 as LOWERCASE

declare @int varchar(50) = substring(@string, 3, 2)
declare @other varchar(50) = substring(@string, charindex('#', @string), 2)
select @int as INTEGER
select @other as OTHER


--Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)

--window function!!

--You are given the following table, which contains a VARCHAR column that contains mathematical equations. 
--Sum the equations and provide the answers in the output.(Equations)

--need stored procedures!!


--Given the following dataset, find the students that share the same birthday.(Student Table)
select distinct * from Student a
join Student b on a.Birthday=b.Birthday and a.StudentName<>b.StudentName


--You have a table with two players (Player A and Player B) and their scores. 
--If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. 
--Write an SQL query to calculate the total score for each unique player pair(PlayerScores)

select LEAST(PlayerA,PlayerB) PlayerA, GREATEST(PlayerA, PlayerB) PlayerB, sum(Score) TotalScores from PlayerScores
group by LEAST(PlayerA,PlayerB), GREATEST(PlayerA, PlayerB)
