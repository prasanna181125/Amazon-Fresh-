# Amazon-Fresh-


Tasks performed:
Data Modeling and Basic Queries
Task 1: Create an ER diagram for the Amazon Fresh database to understand the relationships between tables (e.g., Customers, Products, Orders).
Task 2: Identify the primary keys and foreign keys for each table and describe their relationships.
Task 3: Write a query to:
Retrieve all customers from a specific city.
Fetch all products under the "Fruits" category.

Data Definition Language (DDL) and Constraints
Task 4: Write DDL statements to recreate the Customers table with the following constraints:
CustomerID as the primary key.
Ensure Age cannot be null and must be greater than 18.
Add a unique constraint for Name.
Data Manipulation Language (DML)
Task 5: Insert 3 new rows into the Products table using INSERT statements.
Task 6: Update the stock quantity of a product where ProductID matches a specific ID.
Task 7: Delete a supplier from the Suppliers table where their city matches a specific value.


SQL Constraints and Operators
Task 8: Use SQL constraints to:
Add a CHECK constraint to ensure that ratings in the Reviews table are between 1 and 5.
Add a DEFAULT constraint for the PrimeMember column in the Customers table (default value: "No").
Clauses and Aggregations
Task 9: Write queries using:
WHERE clause to find orders placed after 2024-01-01.
HAVING clause to list products with average ratings greater than 4.
GROUP BY and ORDER BY clauses to rank products by total sales.

ACID Transactions and TCL
Task 10: Write a transaction to:
Deduct stock from the Products table when a product is sold.
Insert a new row in the OrderDetails table for the sale.
Rollback the transaction if the stock is insufficient.
Commit changes otherwise.
Complex Aggregations and Joins
Task 11: Use SQL to:
Join the Orders and OrderDetails tables to calculate total revenue per order.
Identify customers who placed the most orders in a specific time period.
Find the supplier with the most products in stock.

Normalization
Task 12: Normalize the Products table to 3NF:
Separate product categories and subcategories into a new table.
Create foreign keys to maintain relationships.
Subqueries and Nested Queries
Task 13: Write a subquery to:
Identify the top 3 products based on sales revenue.
Find customers who haven’t placed any orders yet.
Real-World Analysis
Task 14: Provide actionable insights:
Which cities have the highest concentration of Prime members?
What are the top 3 most frequently ordered categories?
