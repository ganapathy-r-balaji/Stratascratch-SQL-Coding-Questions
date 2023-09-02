'''
	Find the day of the week that most people check-in

	ID 9762

	PROBLEM STATEMENT:
		Find the day of the week that most people want to check-in.
		Output the day of the week alongside the corresponding check-incount.

	Table: airbnb_contacts
	Data Dictionary:
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

WITH cte AS(
    SELECT 
        extract(dow from ds_checkin) as day,
        COUNT(*) AS checkincount
    from airbnb_contacts
    GROUP BY day
)

SELECT * FROM cte WHERE checkincount = (SELECT MAX(checkincount) From cte)
