'''
	Find the fraction of rides for each weather and the hour
	ID_10019

	PROBLEM STATEMENT:
		Find the fraction (percentage divided by 100) of rides each weather-hour combination constitutes among all weather-hour combinations.
		Output the weather, hour along with the corresponding fraction.


	Table: lyft_rides
	Data Dictionary
		index: int
		weather: varchar
		hour: int
		travel_distance: float
		gasoline_cost: float
	
	index	weather		hour	travel_distance		gasoline_cost
	0	cloudy		7	24.468			1.129
	1	cloudy		23	23.667			1.993
	2	sunny		17	20.931			0.859
	3	rainy		2	29.575			0.848
	4	rainy		7	16.111			0.952

	IN THIS PROBLEM, I HAVE USED TWO DIFFERENT APPROACHES - THE FIRST WITH A COMMON TABLE EXPRESSION, AND THE NEXT WITH A NESTED QUERY.
'''
-- APPROACH 1
	WITH 
	    cte1 AS
	    (
	        SELECT 
	            weather, 
	            hour,
	            COUNT(*) AS cnts
	        FROM lyft_rides
	        GROUP BY 1, 2
	        ORDER BY 1, 2
	    ),
	    cte2 AS 
	    (
	        SELECT
	            COUNT(*)::DECIMAL AS total_cnts
	        FROM lyft_rides
	    )
	
	SELECT
	    weather,
	    hour,
	    cnts / total_cnts::DECIMAL AS probability
	FROM cte1, cte2
	ORDER BY 1, 2
	
-- ----------------------------------------------------------------
	
-- APPROACH 2
SELECT 
    weather,
    hour,
    cnt/total_cnts AS probability 
FROM
(
    SELECT 
        weather, 
        hour,
        COUNT(*) AS cnt
    FROM lyft_rides
    GROUP BY 1, 2
    ORDER BY 1, 2
) segment_count
LEFT JOIN (
    SELECT
        COUNT(*)::DECIMAL AS total_cnts
    FROM lyft_rides
) total_counts
ON TRUE
