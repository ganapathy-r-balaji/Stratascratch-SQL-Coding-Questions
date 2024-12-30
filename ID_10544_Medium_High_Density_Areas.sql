'''
	High-Density Areas
	ID_10544

	PROBLEM STATEMENT:
		Identify the top 3 areas with the highest customer density. Customer density = (total number of unique customers in the area / area size).
		Your output should include the area name and its calculated customer density, and ties will be ranked the same.


    Table: transaction_records
	Data Dictionary
		customer_id: bigint
		store_id: bigint
		transaction_amount: bigint
		transaction_date: date
		transaction_id: bigint
	
    Table: stores
	Data Dictionary
		area_name: text
		area_size: bigint
		store_id: bigint
		store_location: text
		store_open_date: date
	
'''

WITH base AS (
    SELECT 
        s.area_name,
        s.area_size,
        COUNT(DISTINCT tr.customer_id)/s.area_size::float AS cust_density
    FROM transaction_records AS tr 
    LEFT JOIN stores AS s 
        ON tr.store_id = s.store_id
    GROUP BY 1, 2
)

, cte AS (
    SELECT 
        area_name,
        cust_density,
        RANK() OVER(ORDER BY cust_density DESC) AS rnk_dense
    FROM base
)

SELECT area_name, cust_density FROM cte WHERE rnk_dense<=3
