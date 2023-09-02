'''
	MacBook Pro Events

	ID 10140

	PROBLEM STATEMENT:
		Find how many events happened on MacBook-Pro per company in Argentina from users that do not speak Spanish.
		Output the company id, language of users, and the number of events performed by users.


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
    DISTINCT company_id,
    language,
    COUNT(*) OVER(PARTITION BY company_id, language) AS n_macbook_pro_events
FROM
(    
    SELECT 
        * 
    FROM playbook_events
    JOIN playbook_users USING (user_id)
    WHERE playbook_events.location IN ('Argentina') 
    AND playbook_users.language NOT IN ('spanish')
    AND playbook_events.device IN ('macbook pro')
) a
ORDER BY company_id
