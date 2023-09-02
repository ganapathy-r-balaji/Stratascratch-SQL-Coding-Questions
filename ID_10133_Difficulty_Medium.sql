'''
	Requests Acceptance Rate

	ID 10133

	PROBLEM STATEMENT:
		Find the acceptance rate of requests which is defined as the ratio of accepted contacts vs all contacts. Multiply the ratio by 100 to get the rate.

	Table: airbnb_contacts
	Data Dictionary
		id_guest: varchar
		id_host: varchar
		id_listing: varchar
		ts_contact_at: datetime
		ts_reply_at: datetime
		ts_accepted_at: datetime
		ts_booking_at: datetime
		ds_checkin: datetime
		ds_checkout: datetime
		n_guests: int
		n_messages: int
'''

SELECT 
	100 * SUM (CASE WHEN ts_accepted_at IS NOT NULL THEN 1 ELSE 0 END)/COUNT(*) as acceptance_rate 
FROM airbnb_contacts

-- ALTERNATE SOLUTION:
SELECT 
    COUNT(ts_accepted_at)/COUNT(ts_contact_at) :: float * 100 AS acceptancerate
FROM airbnb_contacts
