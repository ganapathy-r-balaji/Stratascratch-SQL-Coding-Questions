-- Revenue Over Time (Difficulty: Hard)
-- Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased. 
-- Do not include returns which are represented by negative purchase values. Output the year-month (YYYY-MM) and 3-month rolling average of revenue, 
-- sorted from earliest month to latest month.

-- A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. 
-- The first two months will not be a true 3-month rolling average since we are not given data from last year. Assume each month has at least one purchase.

-- ID 10314

SELECT 
    t.month,
    avg(t.monthly_revenue) OVER(ORDER BY t.month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as avg_revenue
FROM (
    SELECT 
        to_char(created_at, 'YYYY-MM') AS month,
        sum(purchase_amt) AS monthly_revenue
    FROM amazon_purchases
    WHERE purchase_amt>0
    GROUP BY to_char(created_at::date, 'YYYY-MM')
    ORDER BY to_char(created_at::date, 'YYYY-MM')
) t
ORDER BY t.month ASC

-- Alternate Method
WITH cte1 AS (
    select 
        to_char(created_at, 'YYYY-MM') as year_month,
        SUM(purchase_amt) as curr_purchase_amt
    from amazon_purchases
    WHERE purchase_amt >= 0
    GROUP BY year_month
    ORDER BY year_month
),

cte2 AS(
    SELECT
        year_month,
        curr_purchase_amt as amount
    FROM cte1
    UNION ALL
    SELECT
        year_month,
        LAG(curr_purchase_amt, 1) OVER(ORDER BY year_month) as amount
    FROM cte1
    UNION ALL
    SELECT
        year_month,
        LAG(curr_purchase_amt, 2) OVER(ORDER BY year_month) as amount
    FROM cte1
)

SELECT
    year_month,
    avg(amount) as rolling_average
FROM cte2
GROUP BY year_month
ORDER BY year_month

