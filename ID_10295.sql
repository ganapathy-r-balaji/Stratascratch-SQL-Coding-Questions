-- Most Active Users On Messenger
-- Problem Statement:
	-- Meta/Facebook Messenger stores the number of messages between users in a table named 'fb_messages'. In this table 'user1' is the sender, 'user2' is the receiver, and 'msg_count' is the number of messages exchanged between them.
	-- Find the top 10 most active users on Meta/Facebook Messenger by counting their total number of messages sent and received. Your solution should output usernames and the count of the total messages they sent or received
-- ID 10295


WITH cte1 AS (
    SELECT 
        user1 as username, 
        msg_count
    FROM fb_messages
    UNION ALL
    SELECT 
        user2 as username, 
        msg_count
    FROM fb_messages
)

SELECT 
    username,
    SUM(msg_count) as total_msg_count
FROM cte1
GROUP BY username
ORDER BY total_msg_count DESC
LIMIT 10