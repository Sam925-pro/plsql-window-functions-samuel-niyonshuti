# plsql-window-functions-samuel-niyonshuti
## Step 1: Problem Definition 
  ## Business Context: 
  
  A leading automotive manufacturer's customization department 
wants to analyze customer preferences and buying patterns to improve their 
personalized vehicle offerings. 
  
  ## Data Challenge: 
  
The department needs to identify the most popular customization 
options by vehicle model(e.g., interior upgrades, exterior paint, performance 
enhancements), understand how frequently customers make additional 
modifications, and segment customers based on their customization behavior. 

  ## Expected Outcome: 

The analysis should provide insights to help the department 
optimize their customization packages, target marketing campaigns, and enhance 
the overall customer experience. 
The analysis should provide actionable insights to: 
1. Identify the top customization options by vehicle type and customer 
demographic. 
2. Analyze customer return frequency for additional modifications. 
3. Segment customers based on their customization preferences to create 
targeted marketing campaigns.

# Step 2: Success Criteria 
To measure the success of the vehicle customization business, the company has 
defined the following 5 key goals: 
  ## 1. Top Customization Products per Region/Quarter: 
  Rank the top most 
popular customization products: 
• high-performance tires 
• Carbon fiber trim 
• Custom paint 
• Premium interiors 

  ## 2. Running Monthly Sales Totals: 
  
  Track the sum of monthly sales for 
customized vehicles to monitor overall revenue and growth. 

  ## 3. Month-over-Month Growth: 
  
  Analyze the percentage change in sales from 
one month to the next to assess whether demand for customization services 
is increasing or decreasing over time.

  ## 4. Customer Quartiles: 
  
  Segment customers into quartiles based on the number 
of customisation purchases to understand the distribution of high-value, 
repeat customers and target them with personalized marketing campaigns. 

  ## 5. 3-Month Moving Averages: 
  
  Calculate the 3-month moving average of 
customization sales to smooth out any short-term fluctuations and identify 
longer-term trends in customization demand.

# Step 3: Database Schema 
## 📊 Database Schema  

### 🧑 Customer_info
| Column      | Type        | Example   |
|-------------|-------------|-----------|
| customer_id | VARCHAR(20) | c001      |
| name        | VARCHAR(50) | Darius    |
| region      | VARCHAR(50) | Kigali    |

---

### 📦 Product_catalog
| Column       | Type        | Example                |
|--------------|-------------|------------------------|
| product_id   | VARCHAR(20) | 001                    |
| product_name | VARCHAR(50) | Exhaust systems        |
| category     | VARCHAR(50) | Performance enhancement|

---

### 💰 Sales
| Column      | Type        | Example        |
|-------------|-------------|----------------|
| sales_id    | VARCHAR(20) | 010101         |
| customer_id | VARCHAR(20) | c001           |
| product_id  | VARCHAR(20) | 001            |
| sales_date  | VARCHAR(50) | 21st Sept 2025 |
| amount      | INTEGER     | 1000           |


The following is **ER Diagram**
![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/ER%20diagram.png?raw=true)

## Table creation and insertion of data
  ### 1.Creation of Customers table
  CREATE TABLE Customer (
  Customer_id VARCHAR(20) PRIMARY KEY,
  Name VARCHAR(50) NOT NULL,
  Region VARCHAR(20)
  );

  ### Insertion of data IN Customers table
INSERT INTO Customer (Customer_id, Name, Region) 
VALUES ('c001', 'Darius', 'Gahanga');

INSERT INTO Customer (Customer_id, Name, Region)
VALUES ('c002', 'Musa', 'Kacyiru');

INSERT INTO Customer (Customer_id, Name, Region)
VALUES ('c003', 'Remy', 'Remera');

INSERT INTO Customer (Customer_id, Name, Region)
VALUES ('c004', 'Juste', 'Gisozi');

![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23Customer.png?raw=true)

  ### 2.Creation of Products table
CREATE TABLE Product (
  Product_id VARCHAR(20) PRIMARY KEY,
  Product_name VARCHAR(50) NOT NULL,
  Category VARCHAR(20)

  ### Insertion of data in Products table
  INSERT INTO Product (Product_id, Product_name, Category)
VALUES ('p111', 'wheels and tires', 'Exterior mods');

INSERT INTO Product (Product_id, Product_name, Category)
VALUES ('p222', 'Sound systems', 'Interior mods');

INSERT INTO Product (Product_id, Product_name, Category)
VALUES ('p333', 'Exhaust systems', 'Performance enhance');

INSERT INTO Product (Product_id, Product_name, Category)
VALUES ('p444', 'Towing equip', 'Utility mods');

![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23product.png?raw=true)


  ### 3.Creation of Sales table
  CREATE TABLE Sales (
  Sales_id VARCHAR(20) PRIMARY KEY,
  Customer_id VARCHAR(20) REFERENCES Customer(Customer_id),
  Product_id VARCHAR(20) REFERENCES Product(Product_id),
  Sales_date VARCHAR(50) NOT NULL,
  Amount INTEGER
);

  ### Insertion of data in Sales table
INSERT INTO Sales (Sales_id, Customer_id, Product_id, Sales_date, Amount)
VALUES ('#1', 'c001', 'p444', '2025-07-20', 1000);

INSERT INTO Sales (Sales_id, Customer_id, Product_id, Sales_date, Amount)
VALUES ('#2', 'c002', 'p333', '2025-08-20', 4000);

INSERT INTO Sales (Sales_id, Customer_id, Product_id, Sales_date, Amount)
VALUES ('#3', 'c003', 'p222', '2025-09-10', 12000);

INSERT INTO Sales (Sales_id, Customer_id, Product_id, Sales_date, Amount)
VALUES ('#4', 'c004', 'p111', '2025-09-20', 7000);

![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23sales.png?raw=true)

# STEP 4 : WINDOW FANCTIONS
Window functions are a type of SQL function that perform a calculation 
across a set of rows that are somehow related to the current row

  ## 1.Ranking 
Ranking is a way to assign numerical position to each rwo within a result se based 
on a specified ordering. 
  ### i. ROW_NUMBER () 
Input 
### -- Rank Customers by total revenue using ROW_NUMBER() from high to lower
  ### SELECT
  Customer_id,
  SUM(Amount) As total_revenue,
  ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS row_num
FROM Sales
GROUP BY Customer_id;

### Output
![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23row.png?raw=true).

  ### Interpretation 
The table shows customer revenue data, with the customer 'c003' generating the 
highest total revenue of 12,000, followed by 'c004' at 7,000 and 'c002' at 4,000. 
The data could be used to understand the relative importance of customers and 
inform business decisions. 

  ### ii. RANK () 
  ### Input 
  ### -- Rank Customers by total revenue using RANK
SELECT
  Customer_id,
  SUM(Amount) As total_revenue,
  RANK() OVER (ORDER BY SUM(amount) DESC) AS rank_pos
FROM Sales
GROUP BY Customer_id;

### Output
![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23rank.png?raw=true)

  ### Interpretation 
This function assigns a unique, sequential number to each row based on the total 
revenue in descending order.


  ### iii. PERCENT_RANK () 
  ### Input
  ### -- Rank Customers by total revenue in PERCENT_RANK
SELECT
  Customer_id,
  SUM(Amount) As total_revenue,
  PERCENT_RANK() OVER (ORDER BY SUM(amount) DESC) AS percent_rank
FROM Sales
GROUP BY Customer_id;

  ### Output 
  ![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23perc.png?raw=true)

  ### Interpretation 
The table shows the percent rank of each customer's total revenue, showing their 
relative positions in the customer revenue hierarchy. 


## 2.Aggregate 
Aggregation is the process of computing a single value from set of values.

  ### i. SUM () 
  ### Input 
  ### -- Running total of sales ordered by date
SELECT
  sales_id,
  customer_id,
  sales_date,
  amount,
  SUM(amount) OVER (
    ORDER BY sales_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_total
  
### Output 
![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23runn.png?raw=true)

### Interpretation 
The data indicates that customer 'c003' had the largest single sale of 12,000, while 
customer 'c004' had the highest running total sales of 24,000 by the end of the 
period shown. 


  ### ii. AVERAGE () 
  ### Input 
SELECT
  customer_id,
  FLOOR(AVG(amount)) AS avg_sale
FROM sales
GROUP BY customer_id;
  
### Output 
![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23avg.png?raw=true)

  ### Interpretation 
The table shows the average sale value for each customer. Customer 'c003' has the 
highest average sale of 12,000, followed by 'c004' at 7,000, 'c002' at 4,000, and 
'c001' at 1,000. This data could be used to understand the relative importance and 
purchasing power of each customer. 


  ### iii. MIN () & MAX () 
  ### Input 
-- Calculating the minimum and maximum sales
SELECT
  MIN(amount) AS minimumsales,
  MAX(amount) AS maximumsales
FROM sales;
  
  ### Output 
  ![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23minmax.png?raw=true).
  
  ### Interpretation 
This information can be useful for understanding the range of sales amounts and 
identifying any outliers or unusual transactions. 


## 3.Navigation 
Navigation is the process of traversing a database’s structure to locate and retrieve 
specific data

  ## i. LAG ()
  ### Input
  ### -- Compare each sale with the previous sale by periods
SELECT
  sales_id,
  customer_id,
  sales_date,
  amount,
  LAG(amount, 1) OVER (ORDER BY sales_date) AS previous_sale,
  amount - LAG(amount, 1) OVER (ORDER BY sales_date) AS difference
FROM sales;
  
  ### Output 
  ![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23prev.png?raw=true)
  
  #### Interpretation 
The data indicates that customer 'c003' had the largest single sale of 12,000, while 
customer 'c004' had the highest running total sales of 24,000 by the end of the 
period shown. 


  ### ii. LEAD () 
  ### Input 
### -- compare each sale with the next sale by period
SELECT
  sales_id,
  customer_id,
  sales_date,
  amount,
  LEAD(amount, 1) OVER (ORDER BY sales_date) AS next_sale,
  LEAD(amount, 1) OVER (ORDER BY sales_date) - amount AS difference
FROM sales
ORDER BY sales_date;
  
  ### Output 
![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23nxt.png?raw=true)

  ### Interpretation 
his provides additional context on the sales trends, indicating that customer 'c002' 
had the highest next sale of 12,000, while customer 'c003' had a negative difference 
between the current and next sale, suggesting a decrease in sales. 


  ## 4.Distribution 
involves splitting and storing data across multiple physical or logical locations to 
improve performance, scalability, and fault tolerance. 

  ### i.NTILE(4) 
  ### Input 
  ### -- segment customers into 4 groups (1/4) by amount
SELECT
  customer_id,
  SUM(amount) AS total_revenue,
  NTILE(4) OVER (ORDER BY SUM(amount) DESC) AS quartile
FROM sales
GROUP BY customer_id
ORDER BY total_revenue DESC;

  ### Output 
![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23quart.png?raw=true)

  ### Interpretation 
Customer 'c003' had the highest total revenue of 12,000, placing them in the top 
quartile. Customers 'c004', 'c002', and 'c001' are in the 2nd, 3rd, and 4th quartiles 
respectively, based on their total revenue amounts.

  ### ii. CUME_DIST () 
  ### Input
  ### -- cumulative distribution of customers by revenue
SELECT
  customer_id,
  SUM(amount) AS total_revenue,
  CUME_DIST() OVER (ORDER BY SUM(amount) DESC) AS cum_dist
FROM sales
GROUP BY customer_id
ORDER BY total_revenue DESC;
  
  ### Output
![image alt] (https://github.com/Sam925-pro/plsql-window-functions-samuel-niyonshuti/blob/main/%23Dist.png?raw=true)
  
  ### Interpretation 
Customer 'c001' has the highest cumulative distribution of 1.0, indicating they 
account for 100% of the total revenue. Customers 'c002' and 'c004' have 
cumulative distributions of 0.75 and 0.5 respectively, suggesting they account for 
75% and 50% of the total revenue.

# Step 6: Results analysis and interpretation 
  ## 1.Descriptive Layer 
• The data shows sales records for 4 customers (c001, c002, c003, c004) with 
different product IDs (p444, p333, p222, p111) and sales amounts ranging 
from 1000 to 12000. 
• Customer c003 had the highest single sale of 12000 on 2025-09-10, while 
customer c004 had the second highest sale of 7000 on 2025-09-20. 
• Customers c001 and c002 had lower sales amounts of 1000 and 4000 
respectively.

  ## 2. Diagnostic Layer 
• The varying sales amounts across customers suggest differences in their 
purchasing power, product preferences, or sales strategies. 
• The timing of the sales indicates potential seasonal or promotional factors 
influencing the purchase behavior. 
• The diverse product IDs imply the company may offer a wide range of 
products to cater to different customer needs.

## 3.Prescriptive Layer 
• Analyze the customer purchasing patterns and preferences to optimize 
product offerings and marketing strategies. 
• Investigate the factors driving the high sales for c003 and c004 to replicate 
the success with other customers. 
• Continuously monitor sales data to identify emerging trends and adjust 
business plans accordingly.


# References 
• TechTFQ. (2023). Advanced SQL Window Functions Explained [Video]. 
YouTube. https://www.youtube.com/watch?v=Ww71knvhQ-s 
• PostgreSQL.org. (2024). SQL Syntax: Window Functions. Retrieved from 
https://www.postgresql.org/about/news/postgresql-18-rc-1-released-3130/ 
• PostgreSQL.org. (2024). Window Functions Documentation. Retrieved from 
https://www.postgresql.org/docs/current/tutorial-window.html 
• Oracle Corporation. (2024). PL/SQL Language Reference. Oracle 
Documentation. 
• W3Schools. (2024). SQL Window Functions. Retrieved from 
https://www.w3schools.com/sql/sql_window%20functions.asp 
• Maniraguha, E. (2025). Database Development with PL/SQL - Lecture 02: 
Introduction to GitHubs. AUCA. 
• Maniraguha, E. (2025). Database Development with PL/SQL - Lecture 01: 
Introduction to SQL Command Basics (Recap). AUCA. 
• Githubs tutorial [video] on Youtube. 
https://www.youtube.com/watch?v=iv8rSLsi1xo&pp=ygUfaG93IHRvIHVz
 ZSBnaXRodWIgZm9yIGJlZ2lubmVycw%3D%3D 
• Window functions tutorial [video] on Youtube. 
https://www.youtube.com/watch?v=rIcB4zMYMas&pp=ygUUd2luZG93IG
 Z1bmN0aW9ucyBzcWw%3D 
• Window function in SQL on https://www.geeksforgeeks.org/sql/window
functions-in-sql/
