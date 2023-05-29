use assignment;

-- 1. select all employees in department 10 whose salary is greater than 3000. [table: employee]

select * from emp where salary > 3000 and dept_no = 10;

select * from emp;

select *,
     CASE
      WHEN marks BETWEEN 40 AND 49.99 THEN 'Third Class'
            WHEN marks BETWEEN 50 AND 59.99 THEN 'First Class'
            WHEN marks BETWEEN 60 AND 79.99 THEN 'Second Class'
            WHEN marks BETWEEN 80 AND 100 THEN 'Distinction'
            ELSE 'Failed'
    END as Grade        
  from students;
  select * from students;
  
  -- 2 (a). How many students have graduated with first class?
  
  select count(marks) from students where marks between 50 and 59.99;
  
  -- 2 (b). How many students have obtained distinction? [table: students]
  
   select count(marks) from students where marks between 80 and 100;
   
  --  3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]
  
  select *  from station where id % 2 = 0 order by city;
--  4. Find the difference between the total number of city entries in the table and the number of distinct city entries in the table. In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, write a query to find the value of N-N1 from station.
-- [table: station]

select count(city) as Total_No_of_city from station;

select count(distinct(city)) as Total_No_of_distinct_city from station;

select count(city) - count(distinct(city)) as 'Difference Between Number of Distinct and All Cities' from station;

-- 5 (a) Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. 

select * from station where city like 'a%' order by city;
select * from station where city like 'e%' order by city;
select * from station where city like 'i%' order by city;
select * from station where city like 'o%' order by city;
select * from station where city like 'u%' order by city;

-- OR
select * from station where city regexp '^a|^e|^i|^o|^u' order by city;

--  5(b) Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

select * from station where city like 'a%a' order by city;
select * from station where city like 'e%e' order by city;
select * from station where city like 'i%i' order by city;
select * from station where city like 'o%o' order by city;
select * from station where city like 'u%u' order by city;

-- 5(c)Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

select distinct city FROM station where city Not regexp '^a|^e|^i|^o|^u'order by city;

-- 5(d)-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates. 

select distinct city FROM station where city Not regexp '^a|^e|^i|^o|^u' or city not regexp 'a$|e$|i$|o$|u$' order by city;

-- 6. Write a query that prints a list of employee names having a salary greater than $2000 per month,
--  who have been employed for less than 36 months. Sort your result by descending order of salary. 

select Concat(first_name, ' ', last_name) as Employee,
Concat(salary, '$') as 'Salary($)',
hire_date, timestampdiff(MONTH, hire_date, current_date()) as 'Total_Months_Joined'
from emp where salary > 2000
having Total_Months_Joined < 36
order by salary desc;

-- 7. How much money does the company spend every month on salaries for each department

select Deptno, sum(salary) as Total_salary from employee group by deptno;

-- 8. How many cities in the CITY table have a Population larger than 100000

select name as City_name,population from city where population > 100000;

-- 9 What is the total population of California? 

select district,sum(population) from city where district = 'California';

-- 10 What is the average population of the districts in each country

select district as District, AVG(population) as Average_Population
from city group by District;

--  11. Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers]

select o.ordernumber,o.status,o.customernumber,c.customername,o.comments
from customers c JOIN orders o USING (customernumber)
Where o.status = 'Disputed';




        

