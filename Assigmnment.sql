-- 1. create a database called 'assignment' (Note please do the assignment tasks in this database)

create database assignment;
use assignment;
-- 2 Create the tables from ConsolidatedTables.sql and enter the records as specified in it.
create table  ConsolidatedTable(
Name varchar(50),
Population INT,
Capital varchar(50));

-- 3. Create a table called countries with the following columns
-- name, population, capital    


create table  countries(
Name varchar(50),
Population INT,
Capital varchar(50));

-- 3 a) Insert the following data into the table

insert  into countries values('China',1382,'Beijing');
insert  into countries values('India',1326,'Delhi');
insert  into countries values('United States',324,'Washington D.C.');
insert  into countries values('Indonesia',260,'Jakarta');
insert  into countries values('Brazil',209,'Brasilia');
insert  into countries values('Pakistan',193,'Islamabad');
insert  into countries values('Nigeria',187,'Abuja');
insert  into countries values('Bangladesh',163,'Dhaka');
insert  into countries values('Russia',143,'Moscow');
insert  into countries values('Mexico',128,'Mexico City');
insert  into countries values('Japan1',26,'Tokyo');
insert  into countries values('Philippines',102,'Manila');
insert  into countries values('Ethiopia',101,'Addis Ababa');
insert  into countries values('Vietnam',94,'Hanoi');
insert  into countries values('Egypt',93,'Cairo');
insert  into countries values('Germany',81,'Berlin');
insert  into countries values('Iran',80,'Tehran');
insert  into countries values('Turkey',79,'Ankara');
insert  into countries values('Congo',79,'Kinshasa');
insert  into countries values('France',64,'Paris');
insert  into countries values('United Kingdom',65,'London');
insert  into countries values('Italy',60,'Rome');
insert  into countries values('South Africa',55,'Pretoria');
insert  into countries values('Myanmar',54,'Naypyidaw');


-- 3 b) Add a couple of countries of your choice

insert  into countries values('Moracco',57,'Robat');
insert  into countries values('Greece',63,'Athense');

-- 3 c) Change ‘Delhi' to ‘New Delhi'
SET sql_safe_updates=0;
update countries set capital = 'New Delhi' where capital = 'Delhi';

select * from countries;

-- 4. Rename the table countries to big_countries .

alter table countries rename Big_countries;

-- 5. Create the following tables. Use auto increment wherever applicable

create table Product(
Product_id int primary key,
Product_name varchar(50) UNIQUE NOT NULL,
supplier_id INT,
foreign key (supplier_id) references suppliers(supplier_id)
);

create table suppliers(
supplier_id INT primary key,
supplier_name varchar(50),
location varchar(50));


create table stock(
id INT primary key,
product_id INT,
foreign key (product_id) references Product(product_id),
balance_stock INT);

select * from product;
-- 6) Enter some records into the three tables.

insert into product values(100,'Mobile',1000);
insert into product values(101,'TV',1001);
insert into product values(102,'Laptop',1002);
select * from product;

insert into suppliers values(1000,'Mobile',300);
insert into suppliers values(1001,'TV',301);
insert into suppliers values(1002,'Laptop',302);

select * from suppliers;

insert into stock values(10,100,500);
insert into stock values(11,101,501);
insert into stock values(12,102,602);

select * from stock;

-- 7. Modify the supplier table to make supplier name unique and not null.

ALTER table suppliers modify supplier_name varchar(50) unique NOT NULL;

-- 8. Modify the emp table as follows
select * from emp;
alter table emp add column dept_no int after hire_date;

ALTER TABLE emp RENAME COLUMN emp_no to emp_id;

SET sql_safe_updates=0;


UPDATE emp SET dept_no = 
    case
        when emp_id % 2 = 0 THEN 20
        when emp_id % 3 = 0 THEN 30
        when emp_id % 4 = 0 THEN 40
    when emp_id % 5 = 0 THEN 50
        ELSE  10
  END;
  
-- 9. Create a unique index on the emp_id column.
  select * from emp;
  
CREATE UNIQUE INDEX EMP_ID_UNIQ ON emp ( emp_id );

-- 10. Create a view called emp_sal on the emp table by selecting the following fields in the order of highest salary to the lowest salary.

ALTER TABLE emp RENAME COLUMN emp_id to emp_no;

CREATE VIEW emp_sal as select emp_no, 
CONCAT( first_name, ' ', last_name) as Employee,
salary from emp
order by salary desc;

select * from emp_sal;
