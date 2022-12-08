-- Popularity Percentage
-- Problem Statement:
	-- Find the popularity percentage for each user on Meta/Facebook. The popularity percentage is defined as the total number of friends the user has divided by the total number of users on the platform, then converted into a percentage by multiplying by 100.
	-- Output each user along with their popularity percentage. Order records in ascending order by user id.
	-- The 'user1' and 'user2' column are pairs of friends.
-- ID 10284

-- Tables: 
	-- Table Name: cust_tracking
		-- Columns Name: Data Type
		-- user1: int
		-- user2: int



WITH cte AS(
    SELECT user1, user2 from facebook_friends
    UNION ALL
    SELECT user2, user1 from facebook_friends
)

SELECT 
    user1,
    100 * COUNT(*) / SUM(COUNT(DISTINCT user1)) OVER () AS popularity_percent
FROM cte
GROUP BY user1
