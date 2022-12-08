-- Finding User Purchases
-- Problem Statement:
	-- Write a query that'll identify returning active users. 
	-- A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. 
	-- Output a list of user_ids of these returning active users.
-- ID 10322

-- Tables: 
	-- Table Name: amazon_transactions

		-- Columns Name: Data Type
		-- id: int
		-- user_id: int
		-- item: varchar
		-- created_at: datetime
		-- revenue: int
		
SELECT 
    DISTINCT user_id
FROM 
(
    SELECT 
        user_id,
        (created_at - LAG(created_at) OVER(PARTITION BY user_id ORDER BY created_at)) as date_diff
    FROM amazon_transactions
) a
WHERE date_diff <= 7