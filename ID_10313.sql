-- Naive Forecasting
-- Problem Statement:
	-- Some forecasting methods are extremely simple and surprisingly effective. Naïve forecast is one of them; we simply set all forecasts to be the value of the last observation. Our goal is to develop a naïve forecast for a new metric called "distance per dollar" defined as the (distance_to_travel/monetary_cost) in our dataset and measure its accuracy.
	-- To develop this forecast,  sum "distance to travel"  and "monetary cost" values at a monthly level before calculating "distance per dollar". This value becomes your actual value for the current month. The next step is to populate the forecasted value for each month. This can be achieved simply by getting the previous month's value in a separate column. Now, we have actual and forecasted values. This is your naïve forecast. Let’s evaluate our model by calculating an error matrix called root mean squared error (RMSE). RMSE is defined as sqrt(mean(square(actual - forecast)). Report out the RMSE rounded to the 2nd decimal spot.
-- ID 10313


WITH cte1 AS (
    SELECT
        to_char(request_date, 'YYYY-MM') AS year_month,
        SUM(distance_to_travel) as distance_travelled,
        SUM(monetary_cost) as cost_val
    FROM uber_request_logs
    GROUP BY year_month
    ORDER BY year_month
),
cte2 AS (
    SELECT 
        year_month,
        distance_travelled,
        cost_val,
        distance_travelled/cost_val AS distance_to_travel
    FROM cte1
),
cte3 AS (
    SELECT
        year_month,
        distance_to_travel,
        LAG(distance_to_travel) OVER(ORDER BY year_month) AS previous_value
    FROM cte2
),
cte4 AS (
    SELECT 
        POWER((distance_to_travel - previous_value), 2) as pwr
    FROM cte3
    WHERE previous_value IS NOT null
)
SELECT ROUND(SQRT(AVG(pwr))::numeric, 2) AS rmse FROM cte4