'''
	Invalid Bank Transactions

	ID 2143

	PROBLEM STATEMENT:
		Bank of Ireland has requested that you detect invalid transactions in December 2022.
		An invalid transaction is one that occurs outside of the bank normal business hours.
		The following are the hours of operation for all branches:
		
		Monday - Friday 09:00 - 16:00
		Saturday & Sunday Closed
		Irish Public Holidays 25th and 26th December
				
		Determine the transaction ids of all invalid transactions.

	Table: boi_transactions
	Data Dictionary:
		transaction_id: int
		time_stamp: datetime
'''
SELECT
    transaction_id
    -- to_char(time_stamp, 'Day'),
    -- LOWER(to_char(time_stamp, 'Day')),
    -- EXTRACT(ISODOW FROM time_stamp),
    -- EXTRACT(hour FROM time_stamp) AS hour_of_day,
    -- EXTRACT(day FROM time_stamp) AS date_part,
    -- EXTRACT(month FROM time_stamp) AS month_part,
    -- EXTRACT(year FROM time_stamp) AS year_part
FROM boi_transactions
WHERE EXTRACT(ISODOW FROM time_stamp) IN (6, 7)
OR EXTRACT(day FROM time_stamp) IN (25, 26)
OR EXTRACT(hour FROM time_stamp) < 9 
OR EXTRACT(hour FROM time_stamp) > 15
