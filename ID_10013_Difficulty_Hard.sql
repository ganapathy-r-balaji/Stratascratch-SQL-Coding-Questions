'''
	Positive Ad Channels
	ID_10013

	PROBLEM STATEMENT:
		Find the advertising channel with the smallest maximum yearly spending that still brings in more than 1500 customers each year.

    Table: uber_advertising
	Data Dictionary
		year: int
		advertising_channel: varchar
		money_spent: int
		customers_acquired: int
	
	year	advertising_channel		money_spent		customers_acquired
	2019	celebrities				10000000		1800
	2019	billboards				1000000			2000
	2019	busstops				1500			400
	2019	buses					70000			2500
	2019	tv						300000			5000
	2019	radio					1500			51
	2018	celebrities				123555			2100
	2018	billboards				500000			1800
	2018	busstops				35000			600
	2018	buses					550000			2300
	2018	tv						500000			5300
	2018	radio					2500			250
	2017	celebrities				300000			1900
	2017	billboards				200200			2100
	2017	busstops				80000			800
	2017	buses					3589000			2700
	2017	tv						80000			4700
	2017	radio					80000			1200
'''

WITH cte AS (
    SELECT
        advertising_channel,
        DENSE_RANK() OVER(ORDER BY money_spent ASC) AS drnk
    FROM (
        SELECT 
            advertising_channel,
            MAX(money_spent) AS money_spent
        FROM uber_advertising
        WHERE customers_acquired > 1500
        GROUP BY 1
        ORDER BY money_spent ASC
    ) a
)

SELECT 
    advertising_channel
FROM cte
WHERE drnk = 1
