-- Most Profitable Companies
-- Problem Statement:
	-- Find the 3 most profitable companies in the entire world.
	-- Output the result along with the corresponding company name.
	-- Sort the result based on profits in descending order.
-- ID 10354

SELECT 
    company,
    profits
FROM 
    forbes_global_2010_2014
ORDER BY profits DESC 
LIMIT 3

-- Alternate Solution
WITH cte AS (
    SELECT 
        company,
        profits,
        DENSE_RANK() OVER(ORDER BY profits DESC) as rnk
    FROM 
        forbes_global_2010_2014
)

-- If using DENSE_RANK(), then
SELECT 
    company,
    profits
FROM cte 
WHERE rnk <= 3

-- Note: You can use either RANK() or DENSE_RANK()
