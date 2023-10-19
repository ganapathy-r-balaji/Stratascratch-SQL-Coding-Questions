'''
	Total Cost Of Orders
	ID_10183

	PROBLEM STATEMENT:
		Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. Order records by customer first name alphabetically.

    Table: customers
	Data Dictionary
		id: int
		first_name: varchar
		last_name: varchar
		city: varchar
		address: varchar
		phone_number: varchar
	
		id	first_name	last_name	city			address					phone_number
		3	Farida		Joseph		San Francisco	3153 Rhapsody Street	813-368-1200
		3	Farida		Joseph		San Francisco	3153 Rhapsody Street	813-368-1200
		3	Farida		Joseph		San Francisco	3153 Rhapsody Street	813-368-1200
		7	Jill		Michael		Austin									813-297-0692
		7	Jill		Michael		Austin									813-297-0692

	Table: orders
	Data Dictionary
		id: int
		cust_id: int
		order_date: datetime
		order_details: varchar
		total_order_cost: int

	id	cust_id	order_date	order_details	total_order_cost
	1	3		3/4/2019	Coat			100
	2	3		3/1/2019	Shoes			80
	3	3		3/7/2019	Skirt			30
	4	7		2/1/2019	Coat			25
	5	7		3/10/2019	Shoes			80
'''
	
SELECT 
    o.cust_id,
    c.first_name,
    SUM(o.total_order_cost) AS total_order_cost
FROM orders o
INNER JOIN customers c ON o.cust_id = c.id
GROUP BY 1, 2
ORDER BY 2

