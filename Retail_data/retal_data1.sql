use retail;

-- select orderdetails
select * from orderdetails;
select * from payments;


-- in payments table, get the customer number, year of payment date and sum of ammount, do group by with rollup.
select customerNumber, sum(amount) 
from payments 
group by customerNumber with rollup;





/*############# 
order in sql
#############*/
/*
select
from
where
group by
having
order by
limit;

-- join

select
from
join
on
where
group by
having
order by
limit;
*/

/*##########
    joins
##########*/

#### Inner join #### customer x orders

-- select customernumber, customerName from customers table, 
-- ordernumber,orderdate, status and customerNumber from orders table 
-- put order by customer number.
select c.customerNumber,c.customerName,o.orderNumber,o.orderDate,o.status 
from customers as c 
inner join orders as o
on c.customerNumber=o.customerNumber 
order by c.customerNumber;




#### left join ####

-- left join the above query
select c.customerNumber,c.customerName,o.orderNumber,o.orderDate,o.status 
from customers as c 
left outer join orders as o
on c.customerNumber=o.customerNumber 
order by c.customerNumber;



-- count the null values in left join
select count(*)
from customers as c 
left outer join orders as o
on c.customerNumber=o.customerNumber 
where o.orderNumber is null;



##### right join #####
-- right join the above querry

select c.customerNumber,c.customerName,o.orderNumber,o.orderDate,o.status 
from customers as c 
right join orders as o
on c.customerNumber=o.customerNumber 
order by c.customerNumber;



#### cross join ####

select o1.city, o2.city 
from offices o1
cross join offices o2;


-- cross join with where behaves like inner join
select o1.city, o2.city from offices o1
cross join offices o2
where o1.city = o2.city;

#### self join ####

-- select all from employees;
select * from employees;


-- slef join using inner join
select e1.employeeNumber, e1.firstName, e2.reportsTo
from employees e1
inner join employees e2
on e1.employeeNumber = e2.reportsTo;



-- retrieve two columns, 1st column show the every employee name , 2nd columns shows the name of employee that person have to reports to.
select e1.employeeNumber, e1.firstName, e2.reportsTo
from employees e1
left join employees e2
on e1.employeeNumber = e2.reportsTo;




select e1.employeeNumber, e1.firstName, e2.reportsTo
from employees e1
right join employees e2
on e1.employeeNumber = e2.reportsTo;


-- concat() , first name and last name

-- self join using left join



-- self join using right join






/* ################
  generated columns
  ################ */ 
-- select ordernumber, sum of quantity ordered and sum of total ordered quantity into price of prod. where total is greater than 50000 and item count greater than 600, put total in heighest to lowest





-- with rollup : to get the grand total in the end.

-- select product code, sum of total quantity ordered, from orderdetail table, where price each greater than 100, group by with rollup.



-- sql generated columns (change in database)
-- create a table called 
-- product_motorcycle where it contains only motorcycle from products table. 
-- add same column as product and a new column called stockValue(qunatity * buyprice)





/* Alter table
alter table table_name
add column col_name data_type
generated always as (col_name * col_name) Stored;
*/






-- =============derived tables===========

##### A derived table is a virtual table returned from a select statement. #####  
### (query) AS table_name

-- get the top 5 products by sales revenue in 2003 from the orders and orderdetails tables.
-- retrieve product code and revenue(qty*price) columns
-- instead of on you can use USING (col_name) when the common column in both the tables have same name.





-- using a derived table: name above query top5 and join top5 to products table to retrieve product code, productName from product and revenue column from top5






/*=====================================
   Section 10: Temporary tables & CTEs   
=======================================*/

/*
**********MySQL temporary tables************
- A temporary table is created by using CREATE TEMPORARY TABLE statement. 
Notice that the keyword TEMPORARY is added between the CREATE and TABLE keywords.

- MySQL removes the temporary table automatically when the session ends or the connection is terminated. 
Of course, you can use the  DROP TABLE statement to remove a temporary table explicitly when you are no longer use it.
*/

-- create a temporary table called products_planes


-- insert data from products where product line is plances.


-- DROP TEMPORARY TABLE products_planes;

-- **********Common Table Expression or CTE**********

-- A common table expression is a named temporary result set that exists only within the execution scope of a single SQL statement e.g.,SELECT, INSERT, UPDATE, or DELETE.

-- Similar to a derived table, a CTE is not stored as an object and last only during the execution of a query.

/*
SYNTAX
------
WITH cte_name (column_list) AS (
    query
) 
SELECT * FROM cte_name;

*/


-- copy the top5 querry and make a CTE called cte1 then do inner join with products, retrieve productcode, product name and revenue



-- NESTED CTE
/*
1st cte: retrieve employees who are'Sales Rep' title 
get the employee number and employee name from employees table. 
name this cte 'salesrep'.

2nd cte: do the inner join of salesrep[cte1] and customers on employeenumber
retrieve customerName and salesrepName 
name this cte 'customer_salesrep'

then select all the columns from customer_salesrep
order by name
*/







-- ===============VIEW======================
-- CREATE View 
/*
CREATE VIEW name
AS
*QUERY*;

select * from view_name
*/ 

