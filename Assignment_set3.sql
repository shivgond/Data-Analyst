use assignment;
DELIMITER //
Create procedure order_status( IN t_year INT,
IN t_month INT )
  BEGIN 
select orderNumber,
orderdate,
status
from orders
where year(orderDate) = t_year AND month(orderDate) = t_month;
  END //
  
DELIMITER ;

call order_status(2005, 4);

-- 2. Write a stored procedure to insert a record into the cancellations table for all cancelled orders.

DELIMITER //
CREATE PROCEDURE cancelled_order( )
BEGIN
DROP TABLE IF EXISTS cancellation ;
CREATE TABLE cancellation(
id int primary key auto_increment,
customerNumber int,
orderNumber int,
comments text,
FOREIGN KEY (customerNumber)
REFERENCES customers(customerNumber)
ON DELETE CASCADE,
FOREIGN KEY (orderNumber)
REFERENCES orders(orderNumber)
ON DELETE CASCADE);
INSERT INTO cancellation ( customerNumber, orderNumber, comments)
SELECT   customerNumber, orderNumber, comments
FROM orders
WHERE status = 'Cancelled';
SELECT * FROM cancellation;
    END //
DELIMITER ;

CALL cancelled_order();
-- ANOTHER APPROACH

DROP PROCEDURE IF EXISTS cancelled_order;

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancelled_order`( )
BEGIN
CREATE TABLE IF NOT EXISTS cancellation(
id int primary key auto_increment,
customerNumber int,
orderNumber int,
comments text,
FOREIGN KEY (customerNumber)
REFERENCES customers(customerNumber)
ON DELETE CASCADE,
FOREIGN KEY (orderNumber)
REFERENCES orders(orderNumber)
ON DELETE CASCADE);
INSERT INTO cancellation ( customerNumber, orderNumber, comments)
SELECT   customerNumber, orderNumber, comments FROM orders WHERE status = 'Cancelled'
AND NOT EXISTS ( select customerNumber, orderNumber, comments from cancellation );
SELECT * FROM cancellation;		
    END //
DELIMITER ;


CALL cancelled_order();

-- 3. a. Write function that takes the customernumber as input and returns the purchase_status based on the following criteria

select *,
CASE
WHEN amount < 25000 THEN 'Silver'
WHEN amount BETWEEN 25000 AND 50000 THEN 'Gold'
ELSE 'Platinum'
END AS Status
from payments;

DELIMITER //

CREATE PROCEDURE customer_status( cust_No INT )    
    BEGIN
    SELECT CASE
         WHEN amount < 25000 THEN 'Silver'
         WHEN amount BETWEEN 25000 AND 50000 THEN 'Gold'
               ELSE 'Platinum'
               END AS Status
      from payments
        where customerNumber = cust_No;

  END //

DELIMITER ;

CALL customer_status( 103 );

-- b. Write a query that displays customerNumber, customername and purchase_status from customers table.

select c.customerNumber,
     c.customerName,
       o.status
  from customers c
    LEFT JOIN orders o
    USING (customerNumber);
    
  --   4. Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables.
  
  DELIMITER //
CREATE TRIGGER delete_cascade
  AFTER DELETE on movies
    FOR EACH ROW 
    BEGIN
      UPDATE rentals
        SET movieid = NULL
          WHERE movieid
                       NOT IN
            ( SELECT distinct id
              from movies );
    END //
DELIMITER ;

drop trigger if exists delete_cascade;

select * from movies;

INSERT INTO movies ( id,title,category ) Values ( 11, 'The Dark Knight', 'Action/Adventure');

INSERT INTO rentals ( memid, first_name, last_name, movieid ) Values (9,'Moin','Dalvi',11 );

delete from movies where id = 11;

SELECT id from movies;

SELECT * from rentals;

DELIMITER //
CREATE TRIGGER update_cascade
  AFTER UPDATE on movies
    FOR EACH ROW 
    BEGIN
      UPDATE rentals
        SET movieid = new.id
          WHERE movieid = old.id;
    END //
DELIMITER ;

DROP trigger if exists update_cascade;

INSERT INTO movies ( id,title,category ) Values ( 12,'The Dark Knight','Action/Adventure'); 

SET sql_safe_updates=0;

UPDATE rentals SET movieid = 12 WHERE memid = 9;

UPDATE movies SET id = 11 WHERE title regexp 'Dark Knight';


select * from movies;

select * from rentals;

-- 5. Select the first name of the employee who gets the third highest salary. [table: employee]

select * from employee order by salary desc limit 2,1;

-- 6. Assign a rank to each employee based on their salary. The person having the highest salary has rank 1.

select *,dense_rank () OVER (order by salary desc) as Rank_salary from employee;