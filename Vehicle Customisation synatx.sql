-- create customer info table
CREATE TABLE Customer (
  Customer_id VARCHAR(20) PRIMARY KEY,
  Name VARCHAR(50) NOT NULL,
  Region VARCHAR(20)
);

-- create Product catalog table
CREATE TABLE Product (
  Product_id VARCHAR(20) PRIMARY KEY,
  Product_name VARCHAR(50) NOT NULL,
  Category VARCHAR(20)
);

CREATE TABLE Sales (
  Sales_id VARCHAR(20) PRIMARY KEY,
  Customer_id VARCHAR(20) REFERENCES Customer(Customer_id),
  Product_id VARCHAR(20) REFERENCES Product(Product_id),
  Sales_date VARCHAR(50) NOT NULL,
  Amount INTEGER
);

INSERT INTO Customer (Customer_id, Name, Region) 
VALUES ('c001', 'Darius', 'Gahanga');

INSERT INTO Customer (Customer_id, Name, Region)
VALUES ('c002', 'Musa', 'Kacyiru');

INSERT INTO Customer (Customer_id, Name, Region)
VALUES ('c003', 'Remy', 'Remera');

INSERT INTO Customer (Customer_id, Name, Region)
VALUES ('c004', 'Juste', 'Gisozi');

SELECT*
From Customer;

INSERT INTO Product (Product_id, Product_name, Category)
VALUES ('p111', 'wheels and tires', 'Exterior mods');

INSERT INTO Product (Product_id, Product_name, Category)
VALUES ('p222', 'Sound systems', 'Interior mods');

INSERT INTO Product (Product_id, Product_name, Category)
VALUES ('p333', 'Exhaust systems', 'Performance enhance');

INSERT INTO Product (Product_id, Product_name, Category)
VALUES ('p444', 'Towing equip', 'Utility mods');

SELECT*
From Product;

INSERT INTO Sales (Sales_id, Customer_id, Product_id, Sales_date, Amount)
VALUES ('#1', 'c001', 'p444', '2025-07-20', 1000);

INSERT INTO Sales (Sales_id, Customer_id, Product_id, Sales_date, Amount)
VALUES ('#2', 'c002', 'p333', '2025-08-20', 4000);

INSERT INTO Sales (Sales_id, Customer_id, Product_id, Sales_date, Amount)
VALUES ('#3', 'c003', 'p222', '2025-09-10', 12000);

INSERT INTO Sales (Sales_id, Customer_id, Product_id, Sales_date, Amount)
VALUES ('#4', 'c004', 'p111', '2025-09-20', 7000);

SELECT*
From Sales;

-- Rank Customers by total revenue using ROW_NUMBER() from high to lower
SELECT
  Customer_id,
  SUM(Amount) As total_revenue,
  ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS row_num
FROM Sales
GROUP BY Customer_id;

-- Rank Customers by total revenue using RANK
SELECT
  Customer_id,
  SUM(Amount) As total_revenue,
  RANK() OVER (ORDER BY SUM(amount) DESC) AS rank_pos
FROM Sales
GROUP BY Customer_id;

-- Rank Customers by total revenue in PERCENT_RANK
SELECT
  Customer_id,
  SUM(Amount) As total_revenue,
  PERCENT_RANK() OVER (ORDER BY SUM(amount) DESC) AS percent_rank
FROM Sales
GROUP BY Customer_id;

-- Running total of sales ordered by date
SELECT
  sales_id,
  customer_id,
  sales_date,
  amount,
  SUM(amount) OVER (
    ORDER BY sales_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_total

SELECT
  customer_id,
  FLOOR(AVG(amount)) AS avg_sale
FROM sales
GROUP BY customer_id;

-- Calculating the minimum and maximum sales
SELECT
  MIN(amount) AS minimumsales,
  MAX(amount) AS maximumsales
FROM sales;

-- Compare each sale with the previous sale by periods
SELECT
  sales_id,
  customer_id,
  sales_date,
  amount,
  LAG(amount, 1) OVER (ORDER BY sales_date) AS previous_sale,
  amount - LAG(amount, 1) OVER (ORDER BY sales_date) AS difference
FROM sales;

-- compare each sale with the next sale by period
SELECT
  sales_id,
  customer_id,
  sales_date,
  amount,
  LEAD(amount, 1) OVER (ORDER BY sales_date) AS next_sale,
  LEAD(amount, 1) OVER (ORDER BY sales_date) - amount AS difference
FROM sales
ORDER BY sales_date;

-- segment customers into 4 groups (1/4) by amount
SELECT
  customer_id,
  SUM(amount) AS total_revenue,
  NTILE(4) OVER (ORDER BY SUM(amount) DESC) AS quartile
FROM sales
GROUP BY customer_id
ORDER BY total_revenue DESC;

 -- cumulative distribution of customers by revenue
SELECT
  customer_id,
  SUM(amount) AS total_revenue,
  CUME_DIST() OVER (ORDER BY SUM(amount) DESC) AS cum_dist
FROM sales
GROUP BY customer_id
ORDER BY total_revenue DESC;

