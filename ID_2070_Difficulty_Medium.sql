'''
	Top Three Classes

	ID 2070

	PROBLEM STATEMENT:
		The marketing department wants to launch a new promotion for the most successful product classes.
		Find the top 3 product classes according to their number of sales. In the event of a tie, output all results.

	Table: online_products
	Data Dictionary:
		product_id: int
		product_class: varchar
		brand_name: varchar
		is_low_fat: varchar
		is_recyclable: varchar
		product_category: int
		product_family: varchar
	
	Table: online_orders
	Data Dictionary:
		product_id: int
		promotion_id: int
		cost_in_dollars: int
		customer_id: int
		date: datetime
		units_sold: int
'''

WITH 
	base AS 
	(
	    SELECT 
	        DISTINCT product_class,
	        COUNT(*) OVER(PARTITION BY product_class) AS total_units_sold
	    FROM
	    (
	        SELECT * FROM online_products JOIN online_orders USING (product_id)
	    ) a
	),
	cte AS 
	(
	    SELECT
	        product_class,
	        total_units_sold,
	        DENSE_RANK() OVER(ORDER BY total_units_sold DESC) AS rnk
	    FROM base
	)

SELECT 
	product_class 
FROM cte 
WHERE rnk <= 3
