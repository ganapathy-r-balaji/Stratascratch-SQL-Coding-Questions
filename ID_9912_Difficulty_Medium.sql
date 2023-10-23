'''
	Lowest Priced Orders
	ID 9912

	PROBLEM STATEMENT:
		Find the lowest order cost of each customer.
		Output the customer id along with the first name and the lowest order price.

    	Table: customers
	Data Dictionary
		id: int
		first_name: varchar
		last_name: varchar
		city: varchar
		address: varchar
		phone_number: varchar
		
    	Table: orders
	Data Dictionary
		id: int
		cust_id: int
		order_date: datetime
		order_details: varchar
		total_order_cost: int		
'''
SELECT 
    c.id,
    c.first_name,
    MIN(o.total_order_cost) AS lowest_cost_per_customer
FROM customers c
JOIN orders o
ON c.id = o.cust_id
GROUP BY 1, 2
