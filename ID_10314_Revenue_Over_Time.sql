'''
	Revenue Over Time
	ID_10314

	PROBLEM STATEMENT:
		Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased. Do not include returns which are represented by negative purchase values. Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.
		A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. The first two months will not be a true 3-month rolling average since we are not given data from last year. Assume each month has at least one purchase.

    Table: amazon_purchases
	Data Dictionary
		created_at: date
		purchase_amt: bigint
		user_id: bigint
'''

WITH cte AS (
    SELECT 
        to_char(created_at::date, 'YYYY-MM') AS year_month,
        SUM(purchase_amt) AS monthly_purchase_amt
    FROM amazon_purchases
    WHERE purchase_amt > 0
    GROUP BY 1
    ORDER BY 1
)

SELECT
    year_month,
    AVG(monthly_purchase_amt) OVER(ORDER BY year_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_purchase_amt
FROM cte
;
