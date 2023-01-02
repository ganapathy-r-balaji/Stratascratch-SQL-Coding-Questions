-- Most Profitable City of 2021
-- Problem Statement:
	-- It's the end-of-year review, and you've been tasked with identifying the city with the most profitable month in 2021.
	-- The output should provide the city, the most profitable month, and the profit.
-- ID 2137

-- Tables: 
	-- Table Name: lyft_orders
		-- Columns Name: Data Type
		-- order_id: int
		-- customer_id: varchar
		-- driver_id: varchar
		-- country: varchar
		-- city: varchar

	-- Table Name: lyft_payment_details
		-- Columns Name: Data Type
		-- order_id: int
		-- order_date: datetime
		-- promo_code: bool
		-- order_fare: float
		
with cte as 
(
    select
        city, 
        month, 
        profit,
        dense_rank() over(order by profit desc) as rnk
    from
        (select
            distinct city,
            month,
            sum(order_fare) OVER(Partition by city, month) as profit
        from
            (
                select 
                    lyft_orders.city,
                    EXTRACT(month from lyft_payment_details.order_date) as month,
                    lyft_payment_details.order_fare
                from lyft_orders
                join lyft_payment_details
                on lyft_orders.order_id = lyft_payment_details.order_id
            ) a
        ) b
)

select
    city, 
    month, 
    profit
from cte
where rnk <= 2
