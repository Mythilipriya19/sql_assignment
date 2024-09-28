use ecommerce
--1.create a table named sales_data with columns: product_id, sale_date, and quantity_sold.
CREATE TABLE sales_data (product_id INT,sale_date DATE,quantity_sold INT );
--2.insert some sample data into the table:
INSERT INTO sales_data(product_id, sale_date, quantity_sold) VALUES
    (1, '2022-01-01', 20),
    (2, '2022-01-01', 15),
    (1, '2022-01-02', 10),
    (2, '2022-01-02', 25),
    (1, '2022-01-03', 30),
    (2, '2022-01-03', 18),
    (1, '2022-01-04', 12),
    (2, '2022-01-04', 22);
--3.assign rank by partition based on product_id and in each product id find the lowest sold quantity
SELECT product_id,
    sale_date,
    quantity_sold,
    RANK() OVER (PARTITION BY product_id ORDER BY quantity_sold) AS rank_within_product,
    MIN(quantity_sold) OVER (PARTITION BY product_id) AS lowest_sold_quantity
FROM sales_data
--4.retrieves the value from a previous row in the result set, retrieves the value from the next row.
SELECT
    product_id,
    sale_date,
    quantity_sold,
    LAG(quantity_sold) OVER (ORDER BY product_id, sale_date) AS prev_quantity,
    LEAD(quantity_sold) OVER (ORDER BY product_id, sale_date) AS next_quantity
FROM
	sales_data;
--5.return the first and last values in an ordered set, respectively.
SELECT
    product_id,
    FIRST_VALUE(quantity_sold) OVER (PARTITION BY product_id ORDER BY sale_date) AS first_quantity,
    LAST_VALUE(quantity_sold) OVER (PARTITION BY product_id ORDER BY sale_date) AS last_quantity
FROM
    sales_data;
