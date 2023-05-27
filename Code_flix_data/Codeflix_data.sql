-- droping database churn if it is already exists
drop database if exists churn;
-- creating a new database churn
create database churn;
-- using the current datase to create table
use churn;
-- creating table inside the existing database
create table codeflix(
id int, 
subscription_start date, 
subscription_end date,
segment int
);
-- to check wether the table is created or not
select * from codeflix;

-- --------------xx Questions xx--------------------

-- 1. Select the first 100 rows of the data in the codebytes table.
select * from codeflix limit 100;

-- 2. Which months will you be able to calculate churn for? Check the range of months of data provided on subscription start.
select min(subscription_start), max(subscription_start) from codeflix;
select distinct month(subscription_start) as month_range from codeflix where month(subscription_start) between 1 and 12 order by month_range asc;

/* 3. You’ll be calculating the churn rate for both segments (87 and 30) over the first 3 months of 2017
 (you can’t calculate it for December, since there are no subscription_end values yet).
 To get started, create a temporary table of months that contains two columns: first-day and last-day
 values containing the first day and last day of the month.
 */
 create temporary table months(first_day date , last_day date);
 insert into months(first_day , last_day) values
 ('2017-01-01', '2017-01-31'),
('2017-02-01', '2017-02-28'),
('2017-03-01', '2017-03-31');


-- 4. Create a temporary table called cross_join, from table codebytes and your months. Be sure to SELECT every column.
 create temporary table cross_join(
 select * from codeflix cross join months
 );
 
 -- to check the cross join
 select * from cross_join;
 
 
 /*5. Create a temporary table, status, from the cross_join table you created. This table should contain:
id selected from cross_join
month as an alias of first_day
is_active_87 created using a CASE WHEN to find any users from segment 87 who existed prior to the beginning of the month. 
This is 1 if true and 0 otherwise.
is_active_30 created using a CASE WHEN to find any users from segment 30 who existed prior to the beginning of the month. 
This is 1 if true and 0 otherwise.
*/
 create temporary table status as
 select id, first_day as month, case when segment = 87 and subscription_start < first_day then 1 else 0 end as is_active_87,
 case when segment = 30 and subscription_start < first_day then 1 else 0 end as is_active_30
 from cross_join;
 
 select * from status;
 
 /* 6. Add an is_canceled_87 and an is_canceled_30 column to the status temporary table. This should be 1 if the subscription is canceled 
 during the month and 0 otherwise.
 */
alter table status 
add is_canceled_87 int default 0,
add is_canceled_30 int default 0;

update status set is_canceled_87 = 1 where id in(
select id from cross_join where segment = 87 and month(month) = month(subscription_end));

update status set is_canceled_30 = 1 where id in(
select id from cross_join where segment = 30 and month(month) = month(subscription_end));

/* 7. Create a status_aggregate temporary table that is a SUM of the active and canceled subscriptions for each segment, for each month.
The resulting columns should be:
sum_active_87
sum_active_30
sum_canceled_87
Sum_canceled_30
*/
create temporary table status_aggregate as
select month,
sum(is_active_87) as sum_active_87, 
sum(is_active_30) as sum_active_30, 
sum(is_canceled_87) as sum_canceled_87, 
sum(is_canceled_30) as sum_canceled_30
from status group by month;

select * from status_aggregate;

-- 8. Calculate the churn rates for the two segments over the three month period. Which segment has a lower churn rate?
select avg(sum_canceled_87) as segment_87_churn_rate, avg(sum_canceled_30) as segment_30_churn_rate from status_aggregate;


-- Segment 30 has a lower churn rate of 48.00 when compared to segment 87 which has a churn rate of 206.66 over the three month period.

