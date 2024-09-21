-- DATA CLEANUP
ALTER TABLE `portfolio-projects-394614.nt.customers`
RENAME COLUMN string_field_0 TO customerID,
RENAME COLUMN string_field_1 TO companyName,
RENAME COLUMN string_field_2 TO contactName,
RENAME COLUMN string_field_3 TO contactTitle,
RENAME COLUMN string_field_4 TO city,
RENAME COLUMN string_field_5 TO country;

-- Are there any noticable sales trends over time?
SELECT
  DATE_TRUNC(orderDate, MONTH) AS month,
  SUM(od.unitprice * od.quantity * (1-od.discount)) AS total_sales
FROM
  `portfolio-projects-394614.nt.orders` o
JOIN
  `portfolio-projects-394614.nt.order_details` od ON o.orderID = od.orderID
GROUP BY
  month
ORDER BY
  month;

-- Which are the best and worst selling products?

SELECT
  p.productID,
  p.productName,
  SUM(od.quantity) AS total_quantity_sold
FROM
  `portfolio-projects-394614.nt.products` p
JOIN
  `portfolio-projects-394614.nt.order_details` od ON p.productID = od.productID
GROUP BY
  p.productID, p.productName
ORDER BY
  total_quantity_sold DESC
LIMIT 5;

-- Can you identify any key customers?
SELECT
  c.customerID,
  c.companyName,
  SUM(od.unitprice * od.quantity * (1-od.discount)) AS total_spent
FROM
  `portfolio-projects-394614.nt.customers` c
JOIN
  `portfolio-projects-394614.nt.orders` o ON c.customerID = o.customerID
JOIN
  `portfolio-projects-394614.nt.order_details` od ON o.orderID = od.orderID
GROUP BY
  c.customerID, c.companyName
ORDER BY
  total_spent DESC
LIMIT 5;

-- Are shipping costs consistent across providers?
SELECT 
  DATE_TRUNC(orderDate, MONTH) AS month,
  s.shipperID, s.companyName,
  SUM(o.freight) AS total_freight
FROM
  `portfolio-projects-394614.nt.orders` o
JOIN
  `portfolio-projects-394614.nt.shippers` s ON o.shipperID = s.shipperID
WHERE
  DATE_TRUNC(orderDate, MONTH) = "2014-11-01"
GROUP BY
  month, s.shipperID, s.companyName
ORDER BY
  s.companyName, month;


-- Monthly Sales
-- Monthly Shipping Cost per Order
-- Monthly # of Customers