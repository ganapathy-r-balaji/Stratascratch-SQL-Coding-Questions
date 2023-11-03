'''
	Most Checkins
	ID_10053

	PROBLEM STATEMENT:
		Find the top 5 businesses with the most check-ins.
		Output the business id along with the number of check-ins.

   	Table: yelp_checkin
	Data Dictionary
		business_id: varchar
		weekday: varchar
		hour: datetime
		checkins: int
	business_id		weekday	hour	checkins
	r137FzG8WefldxGmxOOwvw	Wed	17:00	1
	rxU6LyoSNK6Oc9IFhKFWHg	Fri	21:00	2
	8fDLvW2Q6sPhsNawr4fplA	Mon	20:00	6
	ydE2SjvSd9_NMoEBAE2PuA	Sun	4:00	6
	oJZNHz5UUVUgrZwVBVlpYw	Mon	10:00	2
'''

SELECT
    business_id,
    num_checkins
FROM (
    SELECT 
        business_id,
        SUM(checkins) AS num_checkins,
        DENSE_RANK() OVER(ORDER BY SUM(checkins) DESC) AS drnk
    FROM yelp_checkin
    GROUP BY 1
) a
WHERE drnk <= 5
