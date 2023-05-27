-- creating a database for museum
create database Met_Museum;
-- use the database to create the table inside met_museum
use Met_Museum;
-- create a new table inside the given database
create table museum(
ID INT PRIMARY KEY,
Department varchar(100),
Category varchar(100),
Title varchar(100),
Artist varchar(100),
Date datetime,
Medium varchar(100),
Country varchar(100)
);
-- to know about the data type of the table
desc museum;
-- to see whether the columns names were added inside the table
select * from museum;

-- *-------Complete the following Questions---

-- 1. Select the top 10 rows in the met table.--
select * from museum limit 10;

-- 2. How many pieces are in the American Metropolitan Art collection?--
select * from museum where department = 'American Metropolitan Arts';
select count(*) from museum where department = 'American Metropolitan Arts';

-- 3. Count the number of pieces where the category includes ‘celery’.--
select * from museum where category like '%celery%';
select count(*) from museum where category like '%celery%';

-- 4. Find the title and medium of the oldest piece(s) in the collection.--  [ W R O N G ] --> use datetime
select title, medium from museum where 'Object Date' = (select min('Object Date')from museum);

select title , medium from museum where 'Object Date' = min('Object Date');

-- 5. Find the top 10 countries with the most pieces in the collection.--
select country as collection from museum group by country order by collection  limit 10;
select country, count(*) as collection from museum group by country order by collection limit 10;

-- 6. Find the categories which are having more than 100 pieces.---
select category as collection from museum group by category having collection > 100; 
select category, count(*) as collection from museum group by category having collection > 100; 

-- 7. Count the number of pieces where the medium contains ‘gold’ or ‘silver’ and sort in descending order.----*/
select medium as count from museum where medium like '%gold%' or medium like '%silver%' group by medium order by count desc;






