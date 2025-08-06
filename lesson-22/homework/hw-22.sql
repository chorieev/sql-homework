--Compute Running Total Sales per Customer

select *, SUM(total_amount) over(partition by customer_id order by sale_id) from sales_data

--Count the Number of Orders per Product Category

select *, COUNT(*) over(partition by product_category) from sales_data

--Find the Maximum Total Amount per Product Category

select *, MAX(total_amount) over(partition by product_category) from sales_data

--Find the Minimum Price of Products per Product Category

select *, MIN(unit_price) over(partition by product_category) from sales_data

--Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)

select *, AVG(total_amount) over(order by order_date rows between 1 preceding and 1 following) from sales_data

--Find the Total Sales per Region

select *, SUM(total_amount) over(partition by customer_id) from sales_data

--Compute the Rank of Customers Based on Their Total Purchase Amount

select *, DENSE_RANK() over(order by  total_purchase desc
) from (
select *, SUM(total_amount) over(partition by customer_id) total_purchase from sales_data
) as sales

--Calculate the Difference Between Current and Previous Sale Amount per Customer

select *, total_amount - PrevSale as Diff from (
select *, LAG(total_amount) over(partition by customer_id order by order_date) PrevSale from sales_data
) as sales

--Find the Top 3 Most Expensive Products in Each Category

select product_name,product_category, total_amount, rank from (
select *, DENSE_RANK() over(partition by product_category order by total_amount desc) rank from sales_data
) as sales
where rank < 4

--Compute the Cumulative Sum of Sales Per Region by Order Date

select *, SUM(total_amount) over(partition by region order by order_date) from sales_data


--Medium Questions

--Compute Cumulative Revenue per Product Category

select *, SUM(total_amount) over(partition by product_category order by order_date) from sales_data

--12
select *, SUM(ID) over(order by id) SumPreValues from MyTable

--13
select *, SUM(Value) over(order by value rows between 1 preceding and current row) [Sum of Previous] from OneColumn
--Find customers who have purchased items from more than one product_category

select customer_id,customer_name from (
select *, DENSE_RANK() over(partition by customer_id order by product_category) rank from sales_data )
as sales
where rank > 1
  
--Find Customers with Above-Average Spending in Their Region

select * from (
select *, AVG(total_amount) over(partition by region) AvgSpending from sales_data
) as sales
where total_amount> AvgSpending

--Rank customers based on their total spending (total_amount) within each region. 
--If multiple customers have the same spending, they should receive the same rank.

select *, DENSE_RANK() over(partition by region order by total_amount) from sales_data

--Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.

select *, SUM(total_amount) over(partition by customer_id order by order_date) cumulative_sales from sales_data

--Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
--not complete 
select *, MONTH(order_date) from sales_data
order by MONTH(order_date)

select *,LAG(total_amount) over(order by month(order_date))  from sales_data

select *,sum(total_amount) over(partition by month(order_date))  from sales_data


--Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)

select * from (
select *
, LAST_VALUE(total_amount) over(partition by customer_id order by order_date rows between unbounded preceding and unbounded following) LastOrder
from sales_data
) as sales
where total_amount > LastOrder

--Hard Questions

--Identify Products that prices are above the average product price

select * from (
select *, AVG(unit_price) over() AvgProductPrice from sales_data
) as sales
where unit_price>AvgProductPrice

--In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. 
--The challenge here is to do this in a single select. For more details please see the sample input and expected output.
select *, 
case when id=Grp or Val1 = Val2 then 
SUM(Val1) over(partition by grp order by grp rows between current row and 2 following)+
SUM(Val2) over(partition by grp order by grp rows between current row and 2 following)
else null
end Tot
from MyData

--Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values.
--Please go through the sample input and expected output for details.
--22
select distinct ID, 
	SUM(Cost) over (partition by id) Cost, 
	case 
		when COUNT(Quantity) over(partition by quantity) = 2 then Quantity
		else SUM(Quantity) over(partition by id)
	end Quantity
from TheSumPuzzle
--From following set of integers, write an SQL statement to determine the expected outputs

--23
select 
case
	when SeatNumber - Prev <> 1 then Prev + 1 
end GapStart,
case
	when SeatNumber - Prev <> 1 then SeatNumber - 1
end GapEnd
from (
select *, LAG(SeatNumber,1,0) over(order by (select null)) Prev from Seats
) as sales
where SeatNumber - Prev <> 1


