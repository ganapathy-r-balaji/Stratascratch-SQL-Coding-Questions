'''
	Date of Highest User Activity

	ID 2145

	PROBLEM STATEMENT:
		Tiktok want to find out what were the top two most active user days during an advertising campaign they ran in the first week of August 2022 (between the 1st to the 7th).
		Identify the two days with the highest user activity during the advertising campaign.
		They have also specified that user activity must be measured in terms of unique users.
	
		Output the day, date, and number of users. Be careful that some function can add a padding (whitespaces) around the string, for a solution to be correct you should trim the extra padding.

	Table: user_streaks
	Data Dictionary:
		user_id: varchar
		date_visited: datetime
'''

WITH 
cte1 AS (
    SELECT
        DISTINCT date_visited,
        day_of_week,
        SUM(cnt) OVER(PARTITION BY day_of_week) as n_users
    FROM
    (
        SELECT 
            DISTINCT user_id,
            date_visited,
            -- to_char(date_visited, 'DD') as date,
            to_char(date_visited, 'Day') AS day_of_week,
            COUNT(DISTINCT user_id) as cnt
        FROM user_streaks
        WHERE date_visited >= '2022-08-01' AND date_visited <= '2022-08-07'
        GROUP BY date_visited, user_id
        ORDER BY date_visited
    ) a
),
cte2 AS (
    SELECT 
        day_of_week,
        date_visited,
        n_users,
        DENSE_RANK() OVER(ORDER BY n_users DESC) AS users_rnk
    FROM cte1
    -- ORDER BY n_users DESC
)

SELECT
    day_of_week,
    date_visited,
    n_users
FROM cte2 
WHERE users_rnk < 3
