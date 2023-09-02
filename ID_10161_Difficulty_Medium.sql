''' 
	Ranking Hosts By Beds

	ID 10161

	PROBLEM STATEMENT:
		Rank each host based on the number of beds they have listed. 
		The host with the most beds should be ranked 1 and the host with the least number of beds should be ranked last. 
		Hosts that have the same number of beds should have the same rank but there should be no gaps between ranking values. 
		A host can also own multiple properties.
	
		Output the host ID, number of beds, and rank from highest rank to lowest.

	Table: airbnb_apartments
	Data Dictionary:
		host_id: int
		apartment_id: varchar
		apartment_type: varchar
		n_beds: int
		n_bedrooms: int
		country: varchar
		city: varchar
'''

SELECT
    host_id,
    number_of_beds,
    DENSE_RANK() OVER(ORDER BY number_of_beds DESC) AS rank
FROM
(
    SELECT 
        host_id,
        SUM(n_beds) AS number_of_beds
    FROM airbnb_apartments
    GROUP BY host_id
) a
ORDER BY rank
