'''
	Fastest Hometowns

	ID 2066

	PROBLEM STATEMENT:
		Find the hometowns with the top 3 average net times. 
		Output the hometowns and their average net time. 
		In case there are ties in net time, return all unique hometowns.

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
cte AS (
    SELECT
        hometown,
        avg_time,
        DENSE_RANK() OVER(ORDER BY avg_time) AS rnk
    FROM
    (
    SELECT 
        DISTINCT hometown,
        AVG(net_time) OVER(PARTITION BY hometown) AS avg_time
    FROM marathon_male
    ) a
)

SELECT 
    hometown,
    avg_time
FROM cte
WHERE rnk <= 3
