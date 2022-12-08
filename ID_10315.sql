-- Cities With The Most Expensive Homes
-- Problem Statement:
	-- Write a query that identifies cities with higher than average home prices when compared to the national average. Output the city names.
-- ID 10315

-- Tables: 
	-- Table Name: cust_tracking
		-- Columns Name: Data Type
		-- id: int
		-- state: varchar
		-- city: varchar
		-- street_address: varchar
		-- mkt_price: int

SELECT
    DISTINCT city
FROM
(
    SELECT 
        city,
        AVG(mkt_price) OVER(PARTITION BY city) as city_average,
        AVG(mkt_price) OVER() as national_average
    FROM zillow_transactions
) a
WHERE city_average > national_average