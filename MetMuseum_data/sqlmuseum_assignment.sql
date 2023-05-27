use museum;
create table met(
ID INT PRIMARY KEY,
Department varchar(100),
Category varchar(100),
Title varchar(100),
Artist varchar(100),
Date varchar(100),
Medium varchar(100),
Country varchar(100));


SELECT * FROM met;
/*-------Complete the following Questions---
-------1. Select the top 10 rows in the met table.--
-------2. How many pieces are in the American Metropolitan Art collection?--
-------3. Count the number of pieces where the category includes ‘celery’.--
-------4. Find the title and medium of the oldest piece(s) in the collection.--
-------5. Find the top 10 countries with the most pieces in the collection.--
-------6. Find the categories which are having more than 100 pieces.---
-------7. Count the number of pieces where the medium contains ‘gold’ or ‘silver’ and sort in descending order.----*/

/*1*/ SELECT * from met limit 10;

/*2*/
SELECT COUNT(*) 
FROM met 
WHERE department = 'American Metropolitan Arts';

/*3*/ select count(*) as 'celery vase' from met where category like "%celery%" ;

/*4*/ 
SELECT title, medium
FROM met
WHERE date = (
  SELECT MIN(date) 
  FROM met
);

/*5*/ 
SELECT 
    country, COUNT(*) AS num_pieces
FROM
    met
GROUP BY country
ORDER BY num_pieces DESC
LIMIT 10;


/*6*/
SELECT 
    category, COUNT(*) AS num_pieces
FROM
    met
GROUP BY category
HAVING num_pieces > 100;


/*7*/
SELECT 
    medium, COUNT(*) AS count
FROM
    met
WHERE
    medium LIKE '%gold%'
        OR medium LIKE '%silver%'
GROUP BY medium
ORDER BY count DESC;
