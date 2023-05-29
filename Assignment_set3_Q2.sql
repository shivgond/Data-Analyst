-- 2. a. Write function that takes the customernumber as input and returns the purchase_status based on the following criteria . [table:Payments]

-- if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold
-- if amount > 50000 Platinum

use assignment;

  SELECT *,
CASE
    WHEN amount > 50000 THEN 'Platinum'
    WHEN amount > 25000 and amount <=50000 THEN 'Gold'
    ELSE 'Silver'
END AS Status
FROM payments;