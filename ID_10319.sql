-- Monthly Percentage Difference
-- Problem Statement:
	-- Given a table of purchases by date, calculate the month-over-month percentage change in revenue. The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
	-- The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.
-- ID 10319

WITH cte1 AS (
    SELECT
        to_char(created_at, 'YYYY-MM') AS year_month,
        sum(value) as sale_value
    FROM sf_transactions
    GROUP BY year_month
    ORDER BY year_month
),

cte2 AS (
    SELECT
        year_month,
        sale_value,
        LAG(sale_value) OVER(ORDER BY year_month) as previous_sale_value
    FROM cte1    
)

SELECT 
    year_month,
    round((((sale_value - previous_sale_value)/previous_sale_value)*100),2) as revenue_diff_pct
FROM cte2