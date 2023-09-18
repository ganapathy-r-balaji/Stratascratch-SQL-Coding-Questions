'''
	Avg Order Cost During Rush Hours
	ID 2035

	PROBLEM STATEMENT:
		The company you work for has asked you to look into the average order value per hour during rush hours in the San Jose area. Rush hour is from 15H - 17H inclusive.
		You have also been told that the column order_total represents the gross order total for each order. Therefore, you will need to calculate the net order total.
		The gross order total is the total of the order before adding the tip and deducting the discount and refund.
		Use the column customer_placed_order_datetime for your calculations.


	Table: doordash_delivery
	Data Dictionary
		customer_placed_order_datetime: datetime
		placed_order_with_restaurant_datetime: datetime
		driver_at_restaurant_datetime: datetime
		delivered_to_consumer_datetime: datetime
		driver_id: int
		restaurant_id: int
		consumer_id: int
		is_new: bool
		delivery_region: varchar
		is_asap: bool
		order_total: float
		discount_amount: int
		tip_amount: float
		refunded_amount: float
'''

SELECT
    hour_of_day,
    AVG(net_order_total) AS net_earnings
FROM (
    SELECT 
        EXTRACT(HOUR FROM customer_placed_order_datetime) AS hour_of_day,
        order_total + tip_amount - (discount_amount + refunded_amount) AS net_order_total
    FROM delivery_details
    WHERE delivery_region = 'San Jose'
    AND EXTRACT(HOUR FROM customer_placed_order_datetime) BETWEEN 15 and 17
) a
GROUP BY 1
