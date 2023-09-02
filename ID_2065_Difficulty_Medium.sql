'''
	Time from 10th Runner

	ID 2065

	PROBLEM STATEMENT:
		In a marathon, gun time is counted from the moment of the formal start of the race while net time is counted from the moment a runner crosses a starting line. Both variables are in seconds.
		How much net time separates Chris Doe from the 10th best net time (in ascending order)? Avoid gaps in the ranking calculation. Output absolute net time difference.

	Table: marathon_male
	Data Dictionary:
		place: int
		div_tot: varchar
		num: int
		person_name: varchar
		age: int
		hometown: varchar
		pace: int
		gun_time: int
		net_time: int
'''

WITH 
chris_doe AS 
	(
	    SELECT 
	        net_time
	    FROM marathon_male
	    WHERE LOWER(person_NAME) LIKE '%chris%doe%'
	), 
	tenth_best AS
	(
	    SELECT
	        DISTINCT net_time
	    FROM
	        (
	            SELECT
	                net_time,
	                DENSE_RANK() OVER(ORDER BY net_time) AS rnk
	            FROM marathon_male
	        ) a
	    WHERE rnk = 10
	)

SELECT 
    ABS(tenth_best.net_time - chris_doe.net_time) 
FROM tenth_best, chris_doe
