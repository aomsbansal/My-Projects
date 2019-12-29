# creating the schema named assignment
CREATE SCHEMA `assignment` ;
use assignment;
SET SQL_SAFE_UPDATES = 0;
# importing the tables using Mysql table import wizard
# we will import only date and closing price column as they are only significant to us in this assingment
# checking the tables imported tables in the database
show tables;

# checking the number of records in each table;
select count(*) from bajajauto; #output - 889
select count(*) from eichermotors; #output - 889
select count(*) from heromotocorp; #output - 889
select count(*) from infosys; #output - 889
select count(*) from tcs; #output - 889
select count(*) from tvsmotors; #output - 889

# As we have seen that all tables contains 889 rows that means data is imported correctly
#checking the datatypes of the columns
describe bajajauto;

# Date is imported as string, lets convert date column of each table to Date data type
update bajajauto
set date = str_to_date(date,'%d-%M-%Y'); #changing the values to date

alter table bajajauto
  modify date date; #chaging the datatype to date

#checking the datatype again
describe bajajauto;

# changing the date values to date and datatype to date for other tables as well
# eichermotors
update eichermotors set date = str_to_date(date,'%d-%M-%Y'); #changing the values to date
alter table eichermotors modify date date; #chaging the datatype to date

# heromotocorp
update heromotocorp set date = str_to_date(date,'%d-%M-%Y'); #changing the values to date
alter table heromotocorp modify date date; #chaging the datatype to date

# infosys
update infosys set date = str_to_date(date,'%d-%M-%Y'); #changing the values to date
alter table infosys modify date date; #chaging the datatype to date

# tcs
update tcs set date = str_to_date(date,'%d-%M-%Y'); #changing the values to date
alter table tcs modify date date; #chaging the datatype to date

# tvsmotors
update tvsmotors set date = str_to_date(date,'%d-%M-%Y'); #changing the values to date
alter table tvsmotors modify date date; #chaging the datatype to date

# checking the first 5 rows of bajajauto
select * from bajajauto limit 5;

# As we can see there is a space between name of Close Price column , so changing the column name
alter table bajajauto
  change `Close Price` ClosePrice double;
  
#changing for other tables as well
alter table eichermotors change `Close Price` ClosePrice double;
alter table heromotocorp change `Close Price` ClosePrice double;
alter table infosys change `Close Price` ClosePrice double;
alter table tcs change `Close Price` ClosePrice double;
alter table tvsmotors change `Close Price` ClosePrice double;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------  
# Task 1: Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)
# As the data is not sorted, lets sort the data according to date in ascending order
alter table bajajauto order by date asc;
alter table eichermotors order by date asc;
alter table heromotocorp order by date asc;
alter table infosys order by date asc;
alter table tcs order by date asc;
alter table tvsmotors order by date asc;

# 1.Creating bajaj1 table
create table bajaj1 as
WITH bajaj1 (date, ClosePrice, RowNumber, MA20, MA50)
AS ( SELECT date,
       Closeprice,
       ROW_NUMBER() OVER () RowNumber,
       AVG(ClosePrice) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(ClosePrice) OVER (ROWS 49 PRECEDING) AS MA50
FROM   bajajauto )
SELECT date as 'Date',
       ClosePrice 'Close Price',
       IF(RowNumber > 19, MA20, NULL) '20 Day MA',
       IF(RowNumber > 49, MA50, NULL) '50 Day MA' FROM bajaj1;
       
#checking the bajaj1 table
select * from bajaj1;
---------------------------------------------------------------------------------------------------------------------------------------------

# 2.Creating eichermotors1 table
create table eichermotors1 as
WITH eichermotors1 (date, ClosePrice, RowNumber, MA20, MA50)
AS ( SELECT date,
       Closeprice,
       ROW_NUMBER() OVER () RowNumber,
       AVG(ClosePrice) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(ClosePrice) OVER (ROWS 49 PRECEDING) AS MA50
FROM   eichermotors)
SELECT date as 'Date',
       ClosePrice 'Close Price',
       IF(RowNumber > 19, MA20, NULL) '20 Day MA',
       IF(RowNumber > 49, MA50, NULL) '50 Day MA' FROM eichermotors1;
       
#checking the eichermotors1 table
select * from eichermotors1;
---------------------------------------------------------------------------------------------------------------------------------------------
# 3.Creating heromotocorp1 table
create table heromotocorp1 as
WITH heromotocorp1 (date, ClosePrice, RowNumber, MA20, MA50)
AS ( SELECT date,
       Closeprice,
       ROW_NUMBER() OVER () RowNumber,
       AVG(ClosePrice) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(ClosePrice) OVER (ROWS 49 PRECEDING) AS MA50
FROM   heromotocorp)
SELECT date as 'Date',
       ClosePrice 'Close Price',
       IF(RowNumber > 19, MA20, NULL) '20 Day MA',
       IF(RowNumber > 49, MA50, NULL) '50 Day MA' FROM heromotocorp1;
       
#checking the heromotorp1 table
select * from heromotocorp1;
---------------------------------------------------------------------------------------------------------------------------------------------
# 4.Creating infosys1 table
create table infosys1 as
WITH infosys1 (date, ClosePrice, RowNumber, MA20, MA50)
AS ( SELECT date,
       Closeprice,
       ROW_NUMBER() OVER () RowNumber,
       AVG(ClosePrice) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(ClosePrice) OVER (ROWS 49 PRECEDING) AS MA50
FROM  infosys )
SELECT date as 'Date',
       ClosePrice 'Close Price',
       IF(RowNumber > 19, MA20, NULL) '20 Day MA',
       IF(RowNumber > 49, MA50, NULL) '50 Day MA' FROM infosys1;
       
#checking the infosys1 table
select * from infosys1;
---------------------------------------------------------------------------------------------------------------------------------------------

# 5.Creating tcs1 table
create table tcs1 as
WITH tcs1 (date, ClosePrice, RowNumber, MA20, MA50)
AS ( SELECT date,
       Closeprice,
       ROW_NUMBER() OVER () RowNumber,
       AVG(ClosePrice) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(ClosePrice) OVER (ROWS 49 PRECEDING) AS MA50
FROM  tcs )
SELECT date as 'Date',
       ClosePrice 'Close Price',
       IF(RowNumber > 19, MA20, NULL) '20 Day MA',
       IF(RowNumber > 49, MA50, NULL) '50 Day MA' FROM tcs1;
       
#checking the tcs1 table
select * from tcs1;
---------------------------------------------------------------------------------------------------------------------------------------------

# 6.Creating tvsmotors1 table
create table tvsmotors1 as
WITH tvsmotors1 (date, ClosePrice, RowNumber, MA20, MA50)
AS ( SELECT date,
       Closeprice,
       ROW_NUMBER() OVER () RowNumber,
       AVG(ClosePrice) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(ClosePrice) OVER (ROWS 49 PRECEDING) AS MA50
FROM  tvsmotors )
SELECT date as 'Date',
       ClosePrice 'Close Price',
       IF(RowNumber > 19, MA20, NULL) '20 Day MA',
       IF(RowNumber > 49, MA50, NULL) '50 Day MA' FROM tvsmotors1;
       
#checking the tvsmotors1 table
select * from tvsmotors1;
---------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------- 

# Task 2: Create a master table containing the date and close price of all the six stocks. 
# (Column header for the price is the name of the stock)

create table mastertable as
select b.date, b.closeprice 'Bajaj', tc.closeprice 'TCS', tv.closeprice 'TVS', 
i.closeprice 'Infosys', e.closeprice 'Eicher', h.closeprice 'Hero'
from bajajauto b inner join tcs tc on b.date = tc.date
inner join tvsmotors tv on tc.date = tv.date
inner join infosys i on tv.date = i.date
inner join eichermotors e on i.date = e.date
inner join heromotocorp h on e.date = h.date
order by b.date;
---------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------- 

# Task 3: Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. 
# Perform this operation for all stocks.
#since for the first 50 days we dont have proper moving averages data , so we will generate signal as hold for that period

#1. creating bajaj2 table
create table bajaj2 as
SELECT `Date`,`Close Price`,
CASE 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER() <= LAG(`50 Day MA`,1) OVER() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER() >= LAG(`50 Day MA`,1) OVER () THEN 'Sell'
ELSE 'Hold'
END AS "Signal"
FROM Bajaj1;

-----------------------------------------------------------------------------------------------------------------------------------------------

#2. creating eichermotors2 table
create table eichermotors2 as
SELECT `Date`,`Close Price`,
CASE 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER() <= LAG(`50 Day MA`,1) OVER() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER() >= LAG(`50 Day MA`,1) OVER () THEN 'Sell'
ELSE 'Hold'
END AS "Signal"
FROM eichermotors1;

-----------------------------------------------------------------------------------------------------------------------------------------------

#3. creating heromotocorp2 table
create table heromotocorp2 as
SELECT `Date`,`Close Price`,
CASE 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER() <= LAG(`50 Day MA`,1) OVER() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER() >= LAG(`50 Day MA`,1) OVER () THEN 'Sell'
ELSE 'Hold'
END AS "Signal"
FROM heromotocorp1;

-----------------------------------------------------------------------------------------------------------------------------------------------

#4. creating infosys2 table
create table infosys2 as
SELECT `Date`,`Close Price`,
CASE 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER() <= LAG(`50 Day MA`,1) OVER() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER() >= LAG(`50 Day MA`,1) OVER () THEN 'Sell'
ELSE 'Hold'
END AS "Signal"
FROM infosys1;

-----------------------------------------------------------------------------------------------------------------------------------------------

#5. creating tcs2 table
create table tcs2 as
SELECT `Date`,`Close Price`,
CASE 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER() <= LAG(`50 Day MA`,1) OVER() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER() >= LAG(`50 Day MA`,1) OVER () THEN 'Sell'
ELSE 'Hold'
END AS "Signal"
FROM tcs1;

-----------------------------------------------------------------------------------------------------------------------------------------------

#6. creating tvsmotors2 table
create table tvsmotors2 as
SELECT `Date`,`Close Price`,
CASE 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER() <= LAG(`50 Day MA`,1) OVER() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER() >= LAG(`50 Day MA`,1) OVER () THEN 'Sell'
ELSE 'Hold'
END AS "Signal"
FROM tvsmotors1;

-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
#Task 4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) 
#for the Bajaj stock.
drop function if exists signal_generator;

create function signal_generator (d date)
  returns varchar(4) deterministic
  
  return (select `Signal` from bajaj2 where date = d);

select signal_generator('2015-8-25') as 'Signal';
# we can enter any date in the select query of signal generator and it will give the signal for that particular day

# Assingment Complete
# Lot of Thanks to TAs and other members of group who helped on discussion forum :) 

select * from tvsmotors2;


