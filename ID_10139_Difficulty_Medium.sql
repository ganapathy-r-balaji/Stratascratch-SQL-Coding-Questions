'''
	Number of Speakers By Language

	ID 10139

	PROBLEM STATEMENT:
		Find the number of speakers of each language by country. Output the country, language, and the corresponding number of speakers. 
		
		Output the result based on the country in ascending order.

	Table: playbook_events
	Data Dictionary:
		user_id: int
		occurred_at: datetime
		event_type: varchar
		event_name: varchar
		location: varchar
		device: varchar
	
	Table: playbook_users
	Data Dictionary:
		user_id: int
		created_at: datetime
		company_id: int
		language: varchar
		activated_at: datetime
		state: varchar
'''

SELECT
    DISTINCT location,
    language,
    COUNT(DISTINCT user_id) AS language_count
FROM
(
    SELECT 
        user_id,
        location,
        language
    FROM playbook_events JOIN playbook_users USING (user_id) 
) a
GROUP BY location, language
ORDER BY location ASC, language_count DESC
