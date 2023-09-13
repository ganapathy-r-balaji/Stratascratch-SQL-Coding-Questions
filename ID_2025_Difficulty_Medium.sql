'''
	Users Exclusive Per Client
	ID 2025

	PROBLEM STATEMENT:
		Write a query that returns a number of users who are exclusive to only one client. Output the client_id and number of exclusive users.

	Table: fact_events
	Data Dictionary
		id: int
		time_id: datetime
		user_id: varchar
		customer_id: varchar
		client_id: varchar
		event_type: varchar
		event_id: int
	
	First 5 rows of the table:
	---------------------------
	id	time_id		user_id		customer_id	client_id	event_type			event_id
	1	2/28/2020	3668-QPYBK	Sendit		desktop		message sent			3
	2	2/28/2020	7892-POOKP	Connectix	mobile		file received			2
	3	4/3/2020	9763-GRSKD	Zoomit		desktop		video call received		7
	4	4/2/2020	9763-GRSKD	Connectix	desktop		video call received		7
	5	2/6/2020	9237-HQITU	Sendit		desktop		video call received		7
'''

SELECT
    client_id,
    COUNT(DISTINCT user_id) AS user_count
FROM fact_events
WHERE user_id IN (
    SELECT 
        user_id
    FROM fact_events
    GROUP BY user_id
    HAVING COUNT(DISTINCT client_id) = 1
)
GROUP BY client_id

