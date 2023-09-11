'''
	Hour With The Highest Order Volume
	ID 2014

	PROBLEM STATEMENT:
		Which hour has the highest average order volume per day? Your output should have the hour which satisfies that condition, and average order volume.

	Table: postmates_orders
	Data Dictionary
		id: int
		customer_id: int
		courier_id: int
		seller_id: int
		order_timestamp_utc: datetime
		amount: float
		city_id: int
	
	First 5 rows of the table:
	---------------------------
	id		customer_id		courier_id		seller_id		order_timestamp_utc		amount		city_id
	1		102				224				79				2019-03-11 23:27:00		155.73		47
	2		104				224				75				2019-04-11 04:24:00		216.6		44
	3		100				239				79				2019-03-11 21:17:00		168.69		47
	4		101				205				79				2019-03-11 02:34:00		210.84		43
	5		103				218				71				2019-04-11 00:15:00		212.6		47

'''

WITH base AS (
    SELECT
        hour,
        AVG(order_count) AS avg_order_count
    FROM (
        SELECT
            hour,
            date,
            COUNT(id) AS order_count
        FROM
        (
            SELECT 
                id,
                order_timestamp_utc::date AS date,
                extract(hour from order_timestamp_utc) AS hour
            FROM postmates_orders
        ) a
        GROUP BY hour, date
    ) b
    GROUP BY hour
),
cte AS (
    SELECT 
        hour,
        avg_order_count,
        DENSE_RANK() OVER(ORDER BY avg_order_count DESC) AS drnk
    FROM base
)

SELECT
    hour,
    avg_order_count
FROM cte 
WHERE drnk = 1

