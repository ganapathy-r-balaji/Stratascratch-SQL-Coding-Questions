-- Top 3 Restaurants of 2022
-- Problem Statement:
	-- Christmas is quickly approaching, and the DoorDash team anticipates an increase in sales. 
	-- In order to predict the busiest restaurants, they want to identify the top three restaurants by ID in terms of sales in 2022.
	-- The output should include the restaurant IDs as well as their corresponding sales.
-- ID 2138

-- Tables: 
	-- Table Name: order_value_dd
		-- Columns Name: Data Type
		-- delivery_id: varchar
		-- sales_amount: float

	-- Table Name: delivery_orders
		-- Columns Name: Data Type
		-- delivery_id: varchar
		-- order_placed_time: datetime
		-- predicted_delivery_time: datetime
		-- actual_delivery_time: datetime
		-- delivery_rating: int
		-- dasher_id: varchar
		-- restaurant_id: varchar
		-- consumer_id: varchar
		
with cte as
(
    select 
        restaurant_id,
        sales_amt,
        DENSE_RANK() OVER(ORDER BY sales_amt desc) as rnk
    from
        (
            select 
                distinct delivery_orders.restaurant_id,
                SUM(order_value_dd.sales_amount) OVER(partition by delivery_orders.restaurant_id) as sales_amt
            from order_value_dd
            join delivery_orders
            on order_value_dd.delivery_id = delivery_orders.delivery_id
            where extract(year from delivery_orders.order_placed_time)  = 2022
            ORDER BY sales_amt desc
        ) a
)

SELECT 
    restaurant_id,
    sales_amt
FROM cte 
WHERE rnk <= 3
