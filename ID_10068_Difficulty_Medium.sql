'''
User Email Labels
ID 10068

PROBLEM STATEMENT:
	Find the number of emails received by each user under each built-in email label. The email labels are: 'Promotion', 'Social', and 'Shopping'. 
	Output the user along with the number of promotion, social, and shopping mails count,.

Table: google_gmail_emails
Data Dictionary:
	id: int
	from_user: varchar
	to_user: varchar
	day: int

id	from_user		to_user			day
0	6edf0be4b2267df1fa	75d295377a46f83236	10
1	6edf0be4b2267df1fa	32ded68d89443e808	6
2	6edf0be4b2267df1fa	55e60cfcc9dc49c17e	10
3	6edf0be4b2267df1fa	e0e0defbb9ec47f6f7	6
4	6edf0be4b2267df1fa	47be2887786891367e	1

Table: google_gmail_labels
Data Dictionary:
	email_id: int
	label: varchar

email_id	label
0		Shopping
1		Custom_3
2		Social
3		Promotion
4		Social

'''

SELECT 
    to_user,
    SUM(CASE WHEN ggl.label = 'Promotion' THEN 1 ELSE 0 END) AS promotion_count,
    SUM(CASE WHEN ggl.label = 'Social' THEN 1 ELSE 0 END) AS social_count,
    SUM(CASE WHEN ggl.label = 'Shopping' THEN 1 ELSE 0 END) AS shopping_count
FROM google_gmail_emails gge
JOIN google_gmail_labels ggl
ON gge.id = ggl.email_id
WHERE ggl.label IN ('Promotion', 'Social', 'Shopping')
GROUP BY 1
