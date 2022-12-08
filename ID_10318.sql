-- New Products
-- Problem Statement:
	-- You are given a table of product launches by company by year. 
	-- Write a query to count the net difference between the number of products companies launched in 2020 with the number of products companies launched in the previous year. 
	-- Output the name of the companies and a net difference of net products released for 2020 compared to the previous year.
-- ID 10318

-- Tables: 
	-- Table Name: amazon_transactions

		-- Columns Name: Data Type
		-- year: int
		-- company_name: varchar
		-- product_name: varchar
		
SELECT
    a.company_name,
    (a.net_products_2020 - b.net_products_2019) AS net_products
FROM
(
    (
        SELECT
            DISTINCT company_name,
            COUNT(product_name) OVER(PARTITION BY company_name) AS net_products_2020
        FROM car_launches
        WHERE year = 2020
    ) a
    JOIN 
    (
        SELECT
            DISTINCT company_name,
            COUNT(product_name) OVER(PARTITION BY company_name) AS net_products_2019
        FROM car_launches
        WHERE year = 2019
    ) b
    ON a.company_name = b.company_name
)
ORDER BY a.company_name