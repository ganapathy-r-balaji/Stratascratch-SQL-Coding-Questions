-- Third Highest Total Transaction
-- Problem Statement:
	-- American Express is reviewing their customers' transactions, and you have been tasked with locating the customer who has the third highest total transaction amount.
	-- The output should include the customer's id, as well as their first name and last name. For ranking the customers, use type of ranking with no gaps between subsequent ranks.
-- ID 2140

-- Tables: 
	-- Table Name: customers
		-- Columns Name: Data Type
		-- id: int
		-- first_name: varchar
		-- last_name: varchar
		-- city: varchar
		-- address: varchar
		-- phone_number: varchar

	-- Table Name: card_orders
		-- Columns Name: Data Type
		-- order_id: int
		-- cust_id: int
		-- order_date: datetime
		-- order_details: varchar
		-- total_order_cost: int

WITH cte as(
    SELECT 
        c.id, 
        c.first_name, 
        c.last_name,
        DENSE_RANK() OVER(ORDER BY sum(co.total_order_cost) DESC) AS rnk
    FROM customers c 
    JOIN card_orders co 
    ON c.id = co.cust_id
    GROUP BY 1, 2, 3
)

SELECT 
    id, 
    first_name, 
    last_name 
FROM cte
WHERE rnk = 3


-- Alternate Solution
WITH cte AS (
SELECT 
        id,
        first_name,
        last_name,
        DENSE_RANK() OVER(ORDER BY sum_cost) AS rnk
    FROM
    (
        SELECT
            DISTINCT id,
            first_name,
            last_name,
            SUM(total_order_cost) OVER(PARTITION BY id) AS sum_cost
        FROM 
            (
                SELECT 
                    c.id,
                    c.first_name,
                    c.last_name,
                    co.total_order_cost
                FROM customers c
                JOIN card_orders co
                ON c.id = co.cust_id
            ) a
    ) b
)

SELECT 
    id,
    first_name,
    last_name
FROM cte
WHERE rnk = 3