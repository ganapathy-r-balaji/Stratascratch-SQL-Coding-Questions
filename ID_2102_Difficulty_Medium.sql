'''
	Flags per Video

	ID 2102

	PROBLEM STATEMENT:
		For each video, find how many unique users flagged it. A unique user can be identified using the combination of their first name and last name. Do not consider rows in which there is no flag ID.

	Table: user_flags
	Data Dictionary
		user_firstname: varchar
		user_lastname: varchar
		video_id: varchar
		flag_id: varchar
'''

SELECT
    video_id,
    COUNT(DISTINCT CONCAT(firstname, lastname)) AS unique_users
FROM
(SELECT 
    *,
    COALESCE(user_firstname, 'NONE') AS firstname,
    COALESCE(user_lastname, 'NONE') AS lastname
FROM user_flags 
WHERE flag_id IS NOT NULL) a
GROUP BY 1
