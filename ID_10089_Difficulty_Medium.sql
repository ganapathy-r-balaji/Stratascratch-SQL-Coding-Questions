'''
	Find the number of customers without an order
	
	ID 10089
	
	Problem Statement: Find the number of customers without an order.

	DATA DICTIONARY
	
	Table: orders
	id: int
	cust_id: int
	order_date:	datetime
	order_details: varchar
	total_order_cost: int

	
	Table: customers
	id: int
	first_name: varchar
	last_name: varchar
	city: varchar
	address: varchar
	phone_number: varchar
'''

SELECT 
    COUNT(DISTINCT id) 
FROM customers
WHERE id NOT IN (SELECT cust_id FROM orders)

-- ALTERNATE SOLUTION:
SELECT 
	COUNT(*)
FROM customers c
LEFT JOIN orders o ON o.cust_id=c.id
WHERE o.cust_id IS NULL
