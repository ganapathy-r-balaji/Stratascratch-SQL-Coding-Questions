-- Customer Tracking
-- Problem Statement:
	-- Given the users' sessions logs on a particular day, calculate how many hours each user was active that day.
	-- Note: The session starts when state=1 and ends when state=0. 
-- ID 2136

-- Tables: 
	-- Table Name: cust_tracking
		-- Columns Name: Data Type
		-- cust_id: varchar
		-- state: int
		-- timestamp: datetime
		
WITH cte AS (
    SELECT
        *,
        CASE WHEN (state = 0) THEN LAG(timestamp, 1) OVER (PARTITION BY cust_id ORDER BY timestamp ASC) ELSE NULL END AS lagged_timestamp
    FROM cust_tracking
)

SELECT 
    cust_id, 
    SUM(timestamp::TIME - lagged_timestamp::TIME)/3600 AS total_hours
FROM cte
WHERE state = 0
GROUP BY cust_id