-- Best Selling Item
-- Problem Statement:
	-- Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid. The best selling item is calculated using the formula (unitprice * quantity). Output the description of the item along with the amount paid.
-- ID 10172

-- Tables: 
	-- Table Name: online_retail
		-- Columns Name: Data Type
		-- invoiceno: varchar
		-- stockcode: varchar
		-- description: varchar
		-- quantity: int
		-- invoicedate: datetime
		-- unitprice: float
		-- customerid: float
		-- country: varchar
		
WITH cte1 AS (
    SELECT 
        DISTINCT description as description,
        EXTRACT(month FROM invoicedate) as month,
        SUM(unitprice * quantity) OVER(PARTITION BY description, EXTRACT(month FROM invoicedate)) as total_paid
    FROM online_retail
    ORDER BY EXTRACT(month FROM invoicedate) ASC, total_paid DESC
),

cte2 AS (
    SELECT 
        month,
        description,
        total_paid,
        DENSE_RANK() OVER(PARTITION BY month ORDER BY total_paid DESC) as rnk
    FROM cte1
)

SELECT 
    month,
    description,
    total_paid
FROM cte2 
WHERE rnk = 1

-- Alternate Solution
SELECT
    month,
    description,
    total_paid
FROM (
    SELECT 
        EXTRACT(month FROM invoicedate) AS month,
        description,
        SUM(unitprice * quantity) AS total_paid,
        DENSE_RANK() OVER(PARTITION BY EXTRACT(month FROM invoicedate) ORDER BY SUM(unitprice * quantity) DESC) as rnk
    FROM online_retail
    GROUP BY month, description
) a
WHERE rnk = 1