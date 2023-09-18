'''
	Avg Earnings per Weekday and Hour
	ID 2034

	PROBLEM STATEMENT:
		You have been asked to calculate the average earnings per order segmented by a combination of weekday (all 7 days) and hour using the column customer_placed_order_datetime.
		You have also been told that the column order_total represents the gross order total for each order. Therefore, you will need to calculate the net order total.
		The gross order total is the total of the order before adding the tip and deducting the discount and refund.
		Note: In your output, the day of the week should be represented in text format (i.e., Monday). Also, round earnings to 2 decimals

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
    weekday,
    hour_of_day,
    ROUND(AVG(order_value)::numeric, 2) AS avg_earnings
FROM (
    SELECT 
        TRIM(to_char(customer_placed_order_datetime, 'Day')) AS weekday,
        EXTRACT(HOUR FROM customer_placed_order_datetime) AS hour_of_day,
        (order_total + tip_amount - (discount_amount + refunded_amount)) AS order_value
    FROM doordash_delivery
) a
GROUP BY 1, 2
