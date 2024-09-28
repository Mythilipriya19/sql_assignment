--1create database ecommerce
create database ecommerce
use ecommerce
--2 create tables gold_member_users,users,sales,product

create table gold_member_users(userid VARCHAR(10),signup_date Date);
create table users(userid varchar(15),signup_date Date)
create table sales(userid varchar(10),created_date Date,product_id INT);
create table product(product_id INT,product_name varchar(15),price INT);

3--Insert the values above four tables
insert into gold_member_users values('John','2017-09-22'),('Mary','2017-04-21')
insert  into users values('John', '2014-09-02'),('Michel', '2015-01-15'),('Mary', '2014-04-11');
insert into sales values('John','04-19-2017',2),('Mary','12-18-2019',1),('Michel','07-20-2020',3),
('John','10-23-2019',2),('John','03-19-2018',3),('Mary','12-20-2016',2),
('John','11-09-2016',1),('John','05-20-2016',3),('Michel','09-24-2017',1),
('John','03-11-2017',2),('John','03-11-2016',1),('Mary','11-10-2016',1),
('Mary','12-07-2017',2);
insert into product values(1,'Mobile',980),(2,'Ipad',870),(3,'Laptop',330);

--4 SHOW ALL THE VALUES IN THE DATABASE
select * from INFORMATION_SCHEMA.tables;

--5 Count all the records of all four tables using single query select
SELECT
(SELECT COUNT(*) from gold_member_users) as gold_member_users_count,
(SELECT COUNT(*) FROM users)as users_count,
(SELECT COUNT(*) FROM sales)as sales_count,
(SELECT COUNT(*) FROM product)as product_count;
--6. Total amount each customer spent on ecommerce company
select
    sales.userid,
    SUM(product.price) AS total_amount_each_customer_spent
FROM
    sales
    JOIN product ON sales.product_id = product.product_id
GROUP BY
    sales.userid;
--7.distint date of each customer visited on website
select distinct created_date,userid from sales;
--8 find the first product purchased by each customer using three tables(users,sales,product)
select u.userid,MIN(s.created_date)As first_purchase_date,p.product_name
    FROM user u join sales s on u.userid = s.userid
    join product p on s.product_id = p.product_id GROUP BY u.userid,p.product_name;
--9 most purchased item of each customer in three count
select userid,count(product_name) as item_count
from sales
join product on sales.product_id=product.product_id
group by userid
ORDER by item_count desc;
 --10. customer who is not in the gold_member_user
 select userid from users where userid not in(select userid from gold_member_users)
--11. Amount spent by Gold members
select g.userid, SUM(price) AS total_amount_spent
FROM gold_member_users g
JOIN sales s ON g.userid = s.userid
JOIN product p ON s.product_id = p.product_id
GROUP BY g.userid;
--12 customers whoes name starts with M
select userid from users where userid like 'M%';
--13.select customer id for each customers
select distinct userid from users;
--14.change column name from product table as price_values from price
EXEC sp_rename  'product.price', 'price_value', 'COLUMN'
--15. Change the Column value product_name – Ipad to Iphone from product table
update product set product_name='Ipad' where product_name='Iphone';
--16.Change the table name of gold_member_users to gold_membership_users
EXEC sp_rename 'gold_member_users', 'gold_membership_users';
--17 Create a new column  as Status in the table crate above gold_membership_users  the Status values should be 2 Yes and No 
--if the user is gold member, then status should be Yes else No.
ALTER TABLE gold_membership_users add status varchar(3) default 'no'
--18 Delete the users_ids 1,2 from users table and roll the back changes once both the rows are deleted one by one mention the 
--result when performed roll back
BEGIN TRANSACTION;
delete from users where userid='John';
rollback
BEGIN TRANSACTION;
delete from users where userid='Mary'
rollback
--19  Insert one more record as same (3,'Laptop',330) as product table
insert into product values(3,'Laptop',330);
--20. Write a query to find the duplicates in product table
SELECT product_id, COUNT(*) AS duplicates
FROM product
GROUP BY product_id
HAVING COUNT(*) > 1; 
--assignment
