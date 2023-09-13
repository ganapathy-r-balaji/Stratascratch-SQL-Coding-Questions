'''
	Bottom 2 Companies By Mobile Usage
	ID 2026

	PROBLEM STATEMENT:
		Write a query that returns a list of the bottom 2 companies by mobile usage. Company is defined in the customer_id column. 
		Mobile usage is defined as the number of events registered on a client_id == 'mobile'. Order the result by the number of events ascending.
		In the case where there are multiple companies tied for the bottom ranks (rank 1 or 2), return all the companies. Output the customer_id and number of events.

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
WITH cte AS (
    SELECT 
        customer_id,
        client_count AS events,
        DENSE_RANK() OVER(ORDER BY client_count) AS d_rnk
    FROM (
        SELECT 
            customer_id,
            COUNT(client_id) AS client_count
        FROM fact_events
        WHERE client_id = 'mobile'
        GROUP BY customer_id
    ) a
)

SELECT 
    customer_id,
    events
FROM cte
WHERE d_rnk <= 2
