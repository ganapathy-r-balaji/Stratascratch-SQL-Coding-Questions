'''
	Customer Average Orders
	ID 2013

	PROBLEM STATEMENT:
		How many customers placed an order and what is the average order amount?

	Table: postmates_orders
	Data Dictionary
		id: int
		customer_id: int
		courier_id: int
		seller_id: int
		order_timestamp_utc: datetime
		amount: float
		city_id: int
	
	First 5 rows of the table:
	---------------------------
	id		customer_id		courier_id		seller_id		order_timestamp_utc		amount		city_id
	1		102				224				79				2019-03-11 23:27:00		155.73		47
	2		104				224				75				2019-04-11 04:24:00		216.6		44
	3		100				239				79				2019-03-11 21:17:00		168.69		47
	4		101				205				79				2019-03-11 02:34:00		210.84		43
	5		103				218				71				2019-04-11 00:15:00		212.6		47

'''

SELECT 
    COUNT(DISTINCT customer_id) AS count_cust,
    AVG(amount) AS avg_amount
FROM postmates_orders
