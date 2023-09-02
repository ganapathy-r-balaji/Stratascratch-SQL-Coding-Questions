'''
	Find the average age of guests reviewed by each host

	ID 10074

	PROBLEM STATEMENT:
		Find the average age of guests reviewed by each host.
		Output the user along with the average age.

	Table: airbnb_reviews
	Data Dictionary:
		from_user: int
		to_user: int
		from_type: varchar
		to_type: varchar
		review_score: int
	
	Table: airbnb_guests
	Data Dictionary:
		guest_id: int
		nationality: varchar
		gender: varchar
		age: int
'''

SELECT 
    ar.from_user as from_user,
    AVG(ag.age) as age
FROM airbnb_reviews ar
JOIN airbnb_guests ag ON ar.to_user = ag.guest_id
WHERE ar.from_type = 'host'
GROUP BY ar.from_user
