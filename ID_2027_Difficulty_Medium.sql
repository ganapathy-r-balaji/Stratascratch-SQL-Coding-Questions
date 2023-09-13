'''
	Company With Most Desktop Only Users
	ID 2027

	PROBLEM STATEMENT:
		Write a query that returns the company (customer id column) with highest number of users that use desktop only.

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
	id	  time_id	  user_id	customer_id	    client_id	  event_type		  event_id
	1	  2/28/2020	  3668-QPYBK	Sendit		    desktop	  message sent		  3  
	2	  2/28/2020	  7892-POOKP	Connectix	    mobile	  file received		  2
	3	  4/3/2020	  9763-GRSKD	Zoomit		    desktop	  video call received	  7
	4	  4/2/2020	  9763-GRSKD	Connectix	    desktop	  video call received	  7
	5	  2/6/2020	  9237-HQITU	Sendit		    desktop	  video call received	  7
'''
SELECT customer_id
FROM
  (SELECT customer_id,
          rank() OVER (
                       ORDER BY count(DISTINCT user_id) DESC)
   FROM fact_events
   WHERE user_id in
       (SELECT user_id
        FROM fact_events
        GROUP BY user_id
        HAVING count(DISTINCT client_id) = 1) AND client_id = 'desktop'
   GROUP BY customer_id) sq
WHERE rank = 1
