'''
	Customers Without Orders
	ID 9896

	PROBLEM STATEMENT:
		Find customers who have never made an order.
		Output the first name of the customer.

   	Table: customers
	Data Dictionary
		id: int
		first_name: varchar
		last_name: varchar
		city: varchar
		address: varchar
		phone_number: varchar
	
		id	first_name	last_name	city			address					phone_number
		8	John		Joseph		San Francisco							928-386-8164
		14	Liam		Samuel		Miami								808-555-5201
		1	Mark		Thomas		Arizona			4476 Parkway Drive			602-993-5916
		9	Justin		Alexander	Denver			4470 McKinley Avenue			970-433-7589
		11	Frank		Jacob		Miami			1299 Randall Drive			808-590-5201
		7	Jill		Michael		Austin								813-297-0692
		4	William		Daniel		Denver								813-368-1200


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
    DISTINCT c.first_name
FROM customers c
LEFT JOIN orders o ON c.id = o.cust_id
WHERE o.cust_id IS NULL
