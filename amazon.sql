--Data Modeling and Basic Queries
-- TASK 1
Create table customers(CustomerID text primary key, Name text, Age int, Gender text, 
City text, State text,	Country text, SignupDate date,	PrimeMember text)

Select * from customers

create table order_details(
OrderID text ,ProductID text, Quantity int,	UnitPrice int,Discount int)
 
Select * from order_details

create table orders(OrderID text primary key,CustomerID text,OrderDate date,OrderAmount int,	
DeliveryFee int,	DiscountApplied int)

Select * from orders

create table products (ProductID text,	ProductName text,	Category text,	SubCategory	text, 
PricePerUnit int,	StockQuantity int,	SupplierID text)

select * from products

create table reviews(ReviewID text,	ProductID text,	CustomerID text,
Rating int,ReviewText text)

select *from reviews

create table suppliers(SupplierID text,SupplierName text,	ContactPerson text,	
Phone text,	City text,	State text)

select * from suppliers

-- TASK 3 Write a query to:
--			Retrieve all customers from a specific city.

Select * from customers
Select name,city,state,country from customers 

--			Fetch all products under the "Fruits" category 

Select * from products

select productname, category, subcategory from products where category like 'Fruits'
--Data Definition Language (DDL) and Constraints
-- TASK 4  Write DDL statements to recreate the Customers table with the following constraints:
-- CustomerID as the primary key. (customers, orders, reviews)
select * from reviews
ALTER TABLE orders DROP CONSTRAINT orders_pkey;

select customerid, count(*)
from reviews
group by customerid
having count(*) > 1;

delete from reviews
where ctid not in (
  select min(ctid)
  from reviews
  group by customerid
);

add primary key (customerid);
-- Ensure Age cannot be null and must be greater than 18.
Select age from customers where age is not null and age>18

-- Add a unique constraint for Name.
select name, count(*) from customers group by name having count(*)>1;

delete from customers
where ctid not in(select min(ctid) from customers group by name);
--Data Manipulation Language (DML)
-- Task 5: Insert 3 new rows into the Products table using INSERT statements.
Insert into products(productid) values(''),(''),('')
 Select * from productS
-- Task 6: Update the stock quantity of a product where ProductID matches a specific ID.

update products
set quantity = 259+1
where productid='e9282403-e234-4e35-a711-50acb03bbecc';
Select * from products where ProductID= 'e9282403-e234-4e35-a711-50acb03bbecc'

--Task 7: Delete a supplier from the Suppliers table where their city matches a specific value.
delete from suppliers
where supplierid='158ae598-5c95-4dd7-b714-1f24332ddf9c'
Select * from suppliers 
Select * from suppliers where supplierid='158ae598-5c95-4dd7-b714-1f24332ddf9c'

--SQL Constraints and Operators
--Task 8: Use SQL constraints to:
--Add a CHECK constraint to ensure that ratings in the Reviews table are between 1 and 5.
select* from reviews

alter table reviews
add constraint rating_Condition CHECK(rating >=1 and rating<=5)
-- for verification 
insert into reviews(reviewid,productid,customerid,rating,reviewtext) 
values('','','a',1,''),('','','b',2,'')
update reviews 
set rating = 2 
where customerid= 'a'
delete from reviews 
where customerid = 'b' 
select* from reviews where customerid = 'b'

--Add a DEFAULT constraint for the PrimeMember column in the Customers table (default value: "No").
SELECT * FROM CUSTOMERS

alter table customers
alter column primemember set default 'NO';
--Clauses and Aggregations
--Task 9: Write queries using:
--WHERE clause to find orders placed after 2024-01-01.
select * from orders 
where orderdate > '2024-01-01'

--HAVING clause to list products with average ratings greater than 4.
select * FROM REVIEWS

select
products.productid AS productid,
products.productname as productname, reviews.rating
from products
full join reviews 
	on products.productid=reviews.productid
group by 
products.productid, products.productname, reviews.rating
Having avg(reviews.rating)>4 ;
--GROUP BY and ORDER BY clauses to rank products by total sales.


select 
	products.productname,
	order_details.productid,
	order_details.quantity,
	rank() over(order by products.productname) as Rank_P
from 
	order_details
full join
	products
on 
	order_details.productid=products.productid
group by
	products.productname,
	order_details.productid,
	order_details.quantity

--Task 10: Write a transaction to:
--Deduct stock from the Products table when a product is sold.
--Insert a new row in the OrderDetails table for the sale.
--Rollback the transaction if the stock is insufficient.
--Commit changes otherwise.

do $$
begin
  
    if exists (
        select 1
        from Products
        where ProductID = '2aa28375-c563-41b5-aa33-8e2c2e0f4db9' 
          and StockQuantity >= 100 
    ) then
       
        update Products
        set StockQuantity = StockQuantity - 5 
        where ProductID = '2aa28375-c563-41b5-aa33-8e2c2e0f4db9';

      
        insert into Order_Details (OrderID, ProductID, Quantity, UnitPrice)
        values ('qqq', '2aa28375-c563-41b5-aa33-8e2c2e0f4db9', 5, 20.00); 

        raise notice 'Transaction completed successfully.';
    else
       
        raise exception 'Insufficient stock for ProductID %', '2aa28375-c563-41b5-aa33-8e2c2e0f4db9';
    end if;
	
end $$;

--Task 11: Use SQL to:
--Join the Orders and OrderDetails tables to calculate total revenue per order.
select      
	orders.orderid,
    orders.customerid,
    orders.orderdate,
    orders.orderamount,
    orders.deliveryfee,
    orders.discountapplied,
    order_details.quantity,
    order_details.unitprice,
    order_details.discount
from orders 
full join 
	order_details
on 
	orders.orderid=order_details.orderid
where 
	orders.orderid is not null and order_details.orderid is not null
--Identify customers who placed the most orders in a specific time period.
select 
customerid,
count(orderid) as totalorders
from orders
where orderdate between '2025-01-01' AND '2025-12-31' 
group by customerid
order by totalorders ASC;


--Find the supplier with the most products in stock.
select * from products

with supp as(
select products.supplierid,products.productname,suppliers.suppliername,products.stockquantity from products
join suppliers
on
products.supplierid =suppliers.supplierid
)
select supplierid,suppliername,sum(stockquantity) as count_s
from supp
group by supplierid,suppliername
order by count_s desc


--Task 12: Normalize the Products table to 3NF:
--Separate product categories and subcategories into a new table.

create table prod_cat(
catid serial primary key,
produtcat text,
subcat text
)
insert into prod_cat (produtcat, subcat)
select distinct category,subcategory
from products;

delete from prod_cat
where produtcat is null;
--Create foreign keys to maintain relationships.

alter table products
add column catid int;

alter table products
add constraint fk
foreign key (catid) references prod_cat(catid);

update Products
set catid = prod_cat.catid
from  prod_cat
where Products.Category = prod_cat.produtcat
  and Products.Subcategory = prod_cat.subcat;


--Task 13: Write a subquery to:
--Identify the top 3 products based on sales revenue.
select
    products.productid,
    products.productname,
    sum(order_details.quantity * order_details.unitprice) as SalesRevenue
from
    products 
join 
    order_details 
on
    products.productid = order_details.productis
group by
    products.productis, products.productname
order by
    SalesRevenue desc
limit 3;
--Find customers who haven’t placed any orders yet.

select customers.customerid,customers.name,orders.orderid,orders.orderamount
from customers
left join orders
on customers.customerid = orders.customerid
where orders.customerid is  null


--Task 14: Provide actionable insights:
--Which cities have the highest concentration of Prime members?
select customers.city, count(*) as prime_count
from customers
where primemember='Yes'
group by customers.city
order by prime_count DESC
limit 10;
--What are the top 3 most frequently ordered categories?
with f_order as(
select order_details.quantity,products.category
from order_details
join products
on order_details.productid=products.productid)
select category, sum (quantity) as h_quantity
from f_order
group by category
order by h_quantity DESC
limit 3;