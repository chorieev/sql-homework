--the start point of hw

--Easy Tasks

--Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)

select SUBSTRING(Name, 1, CHARINDEX(',', name)-1) Name, 
SUBSTRING(Name, CHARINDEX(',', name)+1, len(name)-CHARINDEX(',', name)) Surname
from TestMultipleColumns

select * from TestMultipleColumns
--Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)

select * from TestPercent
where Strs like '%6%%' escape 6

--In this puzzle you will have to split a string based on dot(.).(Splitter)

select	
		SUBSTRING(Vals, 1,CHARINDEX('.', vals)-1) Val1,
		SUBSTRING(Vals, CHARINDEX('.', vals)+1, 1) Val2,
		case 
			when CHARINDEX('.', Vals, CHARINDEX('.', vals)+1)!=0  then SUBSTRING(Vals, CHARINDEX('.', vals, CHARINDEX('.', vals)+1)+1, 1)
			else null 
		end Val3
from Splitter

--Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)

declare @str1 varchar(50) = substring(STUFF('1234ABC123456XYZ1234567890ADS', 1, CHARINDEX('4', '1234ABC123456XYZ1234567890ADS'), 'XXXX'), 1, 7)
--select @str1

declare @str2 varchar(50) = substring(STUFF('1234ABC123456XYZ1234567890ADS', 
	CHARINDEX('1', '1234ABC123456XYZ1234567890ADS', charindex('1','1234ABC123456XYZ1234567890ADS')+1), 
	charindex('6', '1234ABC123456XYZ1234567890ADS')+1-charindex('1', '1234ABC123456XYZ1234567890ADS', charindex('1', '1234ABC123456XYZ1234567890ADS')+1), 'XXXXXX'), 8, 9)
--select @str2
	
declare @str3 varchar(50) = substring(
	STUFF(
	'1234ABC123456XYZ1234567890ADS',
	CHARINDEX('1', '1234ABC123456XYZ1234567890ADS', charindex('1', '1234ABC123456XYZ1234567890ADS', charindex('1','1234ABC123456XYZ1234567890ADS')+1)+1),
	CHARINDEX('0', '1234ABC123456XYZ1234567890ADS')+1-CHARINDEX('1', '1234ABC123456XYZ1234567890ADS', charindex('1', '1234ABC123456XYZ1234567890ADS', charindex('1','1234ABC123456XYZ1234567890ADS')+1)+1),
	'XXXXXXXXXX'
	), 17, 13)
--select @str3

declare @str4 varchar(50) = concat(@str1,@str2,@str3)
select @str4

--Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)

select * from testDots
where len(Vals)-len(REPLACE(vals, '.', '')) >2

--Write a SQL query to count the spaces present in the string.(CountSpaces)

select LEN(texts) - len(REPLACE(texts, ' ', '')) as SpaceCount from CountSpaces

--write a SQL query that finds out employees who earn more than their managers.(Employee)

select e1.* from Employee e1
join Employee e2 on e1.ManagerId=e2.Id and e1.Salary>e2.Salary

--Find the employees who have been with the company for more than 10 years, but less than 15 years. 
--Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service 
--(calculated as the number of years between the current date and the hire date).(Employees)

select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, datediff(YEAR, hire_date, GETDATE()) as Years_of_Service  from Employees
where datediff(YEAR, hire_date, GETDATE()) > 10 and  datediff(YEAR, hire_date, GETDATE()) < 15

--Medium Tasks

--Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
declare @input varchar(50) = 'rtcfvty34redt'

declare @int int = substring(@input, charindex('34', @input), 2)
select @int as INTEGER

declare @txt1 varchar(50) = substring(@input, 1, charindex('34', @input)-1)
--select @txt1

declare @txt2 varchar(50) = substring(@input, charindex('34', @input)+2, 4)
--select @txt2

declare @txt3 varchar(50) = concat(@txt1,@txt2)
select @txt3 as STRING

--write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)

select * from weather w1
join weather w2 on w1.Temperature>w2.Temperature
and DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1

--Write an SQL query that reports the first login date for each player.(Activity)

select player_id, MIN(event_date) [first login date] from Activity
group by player_id


--Your task is to return the third item from that list.(fruits)

select SUBSTRING(
			fruit_list, 
			CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list)+1)+1, 
			CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list, charindex(',', fruit_list)+1)+1)-CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list)+1)-1
			) as third_item 
from fruits

--Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)

create table canvertingRow (val varchar(50))

insert into canvertingRow values('s d g f h s d g f h s @ 1 2 1 3 1 3 1 3 1')

select value from canvertingRow
cross apply string_split(val, ' ')

--You are given two tables: p1 and p2. 
--Join these tables on the id column. 
--The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)

select *,
case 
	when p1.code = 0 then REPLACE(p1.code, 0, p2.code)
	else p1.code
	end [replaced_column(code)]
from p1
join p2 on p1.id = p2.id

/*
Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
If the employee has worked for less than 1 year → 'New Hire'
If the employee has worked for 1 to 5 years → 'Junior'
If the employee has worked for 5 to 10 years → 'Mid-Level'
If the employee has worked for 10 to 20 years → 'Senior'
If the employee has worked for more than 20 years → 'Veteran'(Employees)
*/

select 
	employee_id,
	FIRST_NAME,
	LAST_NAME,
	HIRE_DATE,
case 
	when DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 then 'New Hire'
	when DATEDIFF(YEAR, HIRE_DATE, GETDATE()) between 1 and 5 then 'Junior'
	when DATEDIFF(YEAR, HIRE_DATE, GETDATE()) between 5 and 10 then 'Mid-Level'
	when DATEDIFF(YEAR, HIRE_DATE, GETDATE()) between 10 and 20 then 'Senior'
	else 'Veteran'
	end EmploymentStage
from Employees


--Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)

select 
case 
when PATINDEX('%[^0-9]%', vals) <> 0 then SUBSTRING(VALS, 1, PATINDEX('%[^0-9]%', vals)-1)
when PATINDEX('%[^0-9]%', vals) = 0 then SUBSTRING(VALS, 1, LEN(vals))
end INTEGERS
from GetIntegers
select * from GetIntegers

--Difficult tasks

--In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
select 
	SUBSTRING(Vals, 1, CHARINDEX(',', vals)-1),
	SUBSTRING(Vals, CHARINDEX(',', vals)+1, CHARINDEX(',', vals, charindex(',', vals)+1)-CHARINDEX(',', vals)-1) 
from MultipleVals

--Write a SQL query that reports the device that is first logged in for each player.(Activity)

select a.player_id, a.device_id, a.event_date from Activity a
join (
select player_id, MIN(event_date) min_a from Activity
group by player_id) b on a.player_id= b.player_id and a.event_date = b.min_a


--You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. 
--For each week, the total sales will be considered 100%, 
--and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)


select 
	a.FinancialWeek,
	a.Area,
	a.DayName,
	round((SalesLocal+ SalesRemote) * 100 / b.weeklyTotalSales, 2) as PerWeekPercentage
from WeekPercentagePuzzle a
join ( select FinancialWeek,
	SUM(SalesLocal + SalesRemote) as weeklyTotalSales
from WeekPercentagePuzzle
group by FinancialWeek) b on a.FinancialWeek = b.FinancialWeek
