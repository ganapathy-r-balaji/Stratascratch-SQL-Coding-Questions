'''
	City With The Highest and Lowest Income Variance
	ID 2015

	PROBLEM STATEMENT:
		What cities recorded the largest growth and biggest drop in order amount between March 11, 2019, and April 11, 2019. 
		Just compare order amounts on those two dates. Your output should include the names of the cities and the amount of growth/drop.

	Table: postmates_orders												Table: postmates_markets
	Data Dictionary                                                     Data Dictionary
		id: int																id: int
		customer_id: int                                                    name: varchar
		courier_id: int                                                     timezone: varchar
		seller_id: int                                                      
		order_timestamp_utc: datetime
		amount: float
		city_id: int
	
	First 5 rows of the "postmates_orders" table:
	---------------------------
	id	customer_id	courier_id	seller_id	order_timestamp_utc	amount	city_id
	1	102		224		79		3/11/2019 23:27		155.73	47
	2	104		224		75		4/11/2019 4:24		216.6	44
	3	100		239		79		3/11/2019 21:17		168.69	47
	4	101		205		79		3/11/2019 2:34		210.84	43
	5	103		218		71		4/11/2019 0:15		212.6	47

	Rows of the "postmates_markets" table:
	---------------------------
	id	name	timezone
	43	Boston	EST
	44	Seattle	PST
	47	Denver	MST
	49	Chicago	CST
'''

WITH march AS (
    SELECT
        po.order_timestamp_utc::date AS order_date,
        pm.name,
        SUM(po.amount) AS march_order_value
    FROM postmates_orders po
    JOIN postmates_markets pm ON po.city_id = pm.id
    WHERE EXTRACT(month from po.order_timestamp_utc) = 3
    GROUP BY 1, 2
),
april AS (
    SELECT
        po.order_timestamp_utc::date AS order_date,
        pm.name,
        SUM(po.amount) AS april_order_value
    FROM postmates_orders po
    JOIN postmates_markets pm ON po.city_id = pm.id
    WHERE EXTRACT(month from po.order_timestamp_utc) = 4
    GROUP BY 1, 2
),
cte AS (
    SELECT
        city,
        monthly_variance,
        DENSE_RANK() OVER(ORDER BY monthly_variance DESC) AS d_rnk
    FROM (
        SELECT 
            march.name AS city,
            march.march_order_value,
            april.april_order_value,
            (april.april_order_value - march.march_order_value) AS monthly_variance
        FROM march
        JOIN april
        ON march.name = april.name
        ) a
)
SELECT city, monthly_variance from cte where d_rnk = (SELECT MAX(d_rnk) FROM cte)
UNION ALL
SELECT city, monthly_variance from cte where d_rnk = (SELECT MIN(d_rnk) FROM cte)
