'''
	Number Of Custom Email Labels

	ID 10120

	PROBLEM STATEMENT:
	Find the number of occurrences of custom email labels for each user receiving an email. Output the receiver user id, label, and the corresponding number of occurrences.

	Table: google_gmail_emails
	Data Dictionary
		id: int
		from_user: varchar
		to_user: varchar
		day: int

	
	Table: google_gmail_labels
	Data Dictionary
		email_id: int
		label: varchar
'''

SELECT 
    gge.to_user,
    ggl.label,
    COUNT(ggl.label) AS custom_count
FROM google_gmail_emails gge
JOIN google_gmail_labels ggl
ON gge.id = ggl.email_id
WHERE LOWER(ggl.label) LIKE '%custom%'
GROUP BY gge.to_user, ggl.label
