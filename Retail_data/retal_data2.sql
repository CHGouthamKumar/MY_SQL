USE retail;

/*===============================================
   Section 12: Stored Procedures 
=================================================*/
-- Change of Delimiter

--  MySQL Workbench or mysql program uses the delimiter (;) to separate statements and executes each statement separately.
-- If you use a MySQL client program to define a stored procedure that contains semicolon characters, the MySQL client program will not treat the whole stored procedure as a single statement, but many statements.
-- Therefore, you must redefine the delimiter temporarily so that you can pass the whole stored procedure to the server as a single statement.

-- The delimiter_character may consist of a single character or multiple characters e.g., // or $$

/*
SYNTAX
--------

DELIMITER $$ 
CREATE PROCEDURE sp_name([param1, param2...])
BEGIN
	statement1;
    statement2;
    ......
END $$
DELIMITER ;
*/


-- create a stored procedure where it will return all the rows from the customer table.
select * from customers;


delimiter $$
create procedure cust_sp()
begin
	select * from customers;
end $$
delimiter ;

-- calling the stored procedure : CALL sp_name;
call cust_sp;


-- DROP PROCEDURE [IF EXISTS] GetAllCustomers;

-- Using parameters for Stored procedures with the keyword IN


-- create a stored procedure name OfficebyCountry where it will ask for the country name as in input and gives data of that country from offices table.
-- parameter syntax : IN col_name Datatype
select * from offices where country = 'USA';



delimiter $$
create procedure office_by_country(
	IN country_name varchar(50))

begin
	select * from offices where country = country_name;
end $$
delimiter ;

-- call OfficebyCountry('UK')
call office_by_country('usa');


-- OUT parameter to store the value returned by the store procedure
-- create procedure called OrderCountByStatus with input parameter called orderStatus varchar, and output parameter called total INT.
-- query : get the count of ordernumber where the status = orderstatus. save output in total.
/*
syntax for out:
CREATE PROCEDURE sp_name (
	IN  param datatype,
	OUT param datatype)
begin
select
INTO out_param_name
from
....
*/

delimiter $$
create procedure order_count(
	IN orderstatus varchar(40),
    out total int)
    
begin
	select count(*) into total from orders where status = orderstatus;
end $$
delimiter ;

-- calling a stored precedure with out paramter
-- CALL sp_name ('',@total)
call order_count ('shipped', @total);

-- select @total
select @total;

-- User-defined variable
-- you can give variable in input parameter.

select * from orders;
set @i = 'Disputed';
select @i;

call order_count(@i,@total);
select @total;
#### Stored Procedure Variables ####
-- DECLARE variable_name datatype(size) [DEFAULT default_value];


-- ALter the Store Proc
-- Right click and Alter, change the code and Apply.

DELIMITER $$
CREATE PROCEDURE GetOrderCountByStatus (
	IN  orderStatus VARCHAR(25),
	OUT total INT
)
BEGIN
	DECLARE OrderYear INT DEFAULT 2003;
	SET OrderYear = 2004;
	
	SELECT COUNT(orderNumber)
	INTO total
	FROM orders
	WHERE status = orderStatus AND YEAR(orderDate) = OrderYear;
END$$
DELIMITER ;

SET @i = 'Shipped';
SELECT @i;
CALL GetOrderCountByStatus(@i,@total);
SELECT @total;


-- triggers

/* SYNTAX
CREATE TRIGGER trigger_name
[Before|After]
[INSERT | UPDATE | DELETE]
ON table_name
[for each row | for each column]
[trigger body]
*/
-- trigger body : set new.col_name = new.col_name

-- create table name sales, with column , id, name, ammount

-- insert some data

select * from sales;
insert into sales(sales_employee, fiscal_year, sale)
values
('vijit', 2019, 100);

create table backup_table(
sales_employee varchar(50),
fiscal_year int,
sale double);

-- select all from sales.




-- create a before insert trigger on sales table, for each row has been added, add 100 extra in ammount column



-- insert one row in sales table.




-- create table sales_backup same as the sales column.  



-- create after delete trigger called back_up on sales table for each row , 
-- whenver row gets deleted from sales, gets inserted into sales_backup table, sytax : [insert into table_name values (old.col_name, old.col_name, old.col_name)]


-- delete data from sales table



-- check both the tables.


-- drop trigger trigger_name;





