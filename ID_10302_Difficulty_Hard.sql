'''
  Distance Per Dollar

  ID 10302

  You’re given a dataset of uber rides with the traveling distance (‘distance_to_travel’) and cost (‘monetary_cost’) for each ride. 
  For each date, find the difference between the distance-per-dollar for that date and the average distance-per-dollar for that year-month. 
  Distance-per-dollar is defined as the distance traveled divided by the cost of the ride.

  The output should include the year-month (YYYY-MM) and the absolute average difference in distance-per-dollar (Absolute value to be rounded to the 2nd decimal).
  You should also count both success and failed request_status as the distance and cost values are populated for all ride requests. 
  Also, assume that all dates are unique in the dataset. Order your results by earliest request date first.

  Table: uber_request_logs
  request_id: int
  request_date: datetime
  request_status: varchar
  distance_to_travel: float
  monetary_cost: float
  driver_to_client_distance: float
'''

SELECT 
    v.year_month,
    round(avg(v.abs_monthly_cost_difference),2) as avg_monthly_cost_difference
FROM (
    SELECT 
        u.year_month,
        u.distance_per_dollar,
        u.avg_monthly_cost,
        abs(u.distance_per_dollar - u.avg_monthly_cost)::decimal AS abs_monthly_cost_difference
    FROM (
        SELECT 
            to_char(uber_request_logs.request_date::date, 'YYYY-MM') as year_month,
            uber_request_logs.distance_to_travel/uber_request_logs.monetary_cost as distance_per_dollar,
            SUM(uber_request_logs.distance_to_travel) OVER(PARTITION BY to_char(uber_request_logs.request_date::date, 'YYYY-MM')) /SUM(uber_request_logs.monetary_cost) OVER(PARTITION BY to_char(uber_request_logs.request_date::date, 'YYYY-MM')) as avg_monthly_cost
        FROM uber_request_logs
    ) u
)v
GROUP BY v.year_month
ORDER BY v.year_month
