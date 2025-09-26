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
