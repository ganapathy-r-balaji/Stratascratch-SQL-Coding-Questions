'''
	Top 2 Users With Most Calls

	ID 2019

	PROBLEM STATEMENT: 
		Return the top 2 users in each company that called the most. Output the company_id, user_id, and the users rank. If there are multiple users in the same rank, keep all of them.

	Table: rc_calls
	Data Dictionary:
		user_id: int
		date: datetime
		call_id: int
	
	Table: rc_users
	Data Dictionary:
		user_id: int
		status: varchar
		company_id: int
'''

WITH cte1 AS 
(
    SELECT
        DISTINCT user_id,
        company_id,
        COUNT(user_id) OVER(PARTITION BY company_id, user_id) AS user_count
    FROM
    (
        SELECT * FROM rc_calls JOIN rc_users USING (user_id)
    ) a
),
cte2 AS 
(
    SELECT
        user_id,
        company_id,
        DENSE_RANK() OVER(PARTITION BY company_id ORDER BY user_count DESC) AS rnk
    FROM cte1
)

SELECT * FROM cte2 WHERE rnk <= 2
