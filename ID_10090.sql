-- Find the percentage of shipable orders
-- Problem Statement:
	-- Find the percentage of shipable orders.
	-- Consider an order is shipable if the customer's address is known.
-- ID 10090

-- Tables: 
	-- Table Name: orders
		-- Columns Name: Data Type
		-- id: int
		-- cust_id: int
		-- order_date: datetime
		-- order_details: varchar
		-- total_order_cost: int
		
	-- Table Name: customers
		-- Columns Name: Data Type
		-- id: int
		-- first_name: varchar
		-- last_name: varchar
		-- city: varchar
		-- address: varchar
		-- phone_number: varchar


WITH cte AS (
    SELECT 
        c.address
    From orders o
    JOIN customers c
    ON o.cust_id = c.id
),

cte1 AS (
    SELECT 
        COUNT(*) OVER() AS address_cnt, 
        CASE WHEN address IS NOT NULL THEN 1 ELSE 0 END AS  not_null_address
    FROM cte
)

SELECT 
    100 * SUM(not_null_address)/address_cnt AS percent_shipable
FROM cte1
GROUP BY address_cnt