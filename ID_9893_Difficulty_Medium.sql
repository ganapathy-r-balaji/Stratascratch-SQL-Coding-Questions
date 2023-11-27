'''
	Frequent Customers
	ID 9893

	PROBLEM STATEMENT:
		Find customers who appear in the orders table more than three times.

   	Table: orders
	Data Dictionary
		id: int
		cust_id: int
		order_date: datetime
		order_details: varchar
		total_order_cost: int		

		id	cust_id		order_date	order_details	total_order_cost
		1	3		3/4/2019	Coat		100
		2	3		3/1/2019	Shoes		80
		3	3		3/7/2019	Skirt		30
		4	7		2/1/2019	Coat		25
		5	7		3/10/2019	Shoes		80

	
'''

SELECT 
    cust_id
FROM orders
GROUP BY cust_id
HAVING COUNT(cust_id) > 3
