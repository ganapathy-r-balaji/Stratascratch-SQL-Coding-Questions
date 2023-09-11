'''
	New And Existing Users

	ID 2028

	Problem Statement:
		Calculate the share of new and existing users for each month in the table. Output the month, share of new users, and share of existing users as a ratio.
		New users are defined as users who started using services in the current month (there is no usage history in previous months). Existing users are users who used services in current month, but they also used services in any previous month.
		Assume that the dates are all from the year 2020.
		HINT: Users are contained in user_id column

	Table: fact_events
	Data Dictionary
		id: int
		time_id: datetime
		user_id: varchar
		customer_id: varchar
		client_id: varchar
		event_type: varchar
		event_id: int

	First five rows of the table:
	------------------------------
	id	time_id		user_id		customer_id		client_id	event_type			event_id
	1	2/28/2020	3668-QPYBK	Sendit			desktop		message sent			3
	2	2/28/2020	7892-POOKP	Connectix		mobile		file received			2
	3	4/3/2020	9763-GRSKD	Zoomit			desktop		video call received		7
	4	4/2/2020	9763-GRSKD	Connectix		desktop		video call received		7
	5	2/6/2020	9237-HQITU	Sendit			desktop		video call received		7
'''

WITH all_users AS (
    SELECT 
        EXTRACT(MONTH FROM time_id) AS month,
        COUNT(DISTINCT user_id) AS all_users
    FROM fact_events
    GROUP BY month
),
new_users AS (
    SELECT 
        EXTRACT(MONTH FROM min_month) AS month,
        count(DISTINCT user_id) as new_users
    FROM
         (
            SELECT 
                user_id,
                min(time_id) as min_month
            FROM fact_events
            GROUP BY user_id
        ) sq
    GROUP BY month
)
SELECT 
    a.month,
    n.new_users/a.all_users::decimal AS new_users_share,
    1 - (n.new_users/a.all_users::decimal) AS existing_users_share
FROM all_users a
JOIN new_users n on a.month = n.month
