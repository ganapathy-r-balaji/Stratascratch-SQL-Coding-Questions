-- Activity Rank
-- Problem Statement:
	-- Find the email activity rank for each user. Email activity rank is defined by the total number of emails sent. The user with the highest number of emails sent will have a rank of 1, and so on. Output the user, total emails, and their activity rank. Order records by the total emails in descending order. Sort users with the same number of emails in alphabetical order.
	-- In your rankings, return a unique value (i.e., a unique rank) even if multiple users have the same number of emails.
-- ID 10351

-- Tables: 
	-- Table Name: google_gmail_emails
		-- Columns Name: Data Type
		-- id: int
		-- from_user: varchar
		-- to_user: varchar
		-- day: int
		
SELECT 
    from_user,
    COUNT(from_user) as total_emails,
    ROW_NUMBER() OVER(ORDER BY COUNT(from_user) DESC, from_user ASC) as row_number
FROM google_gmail_emails
GROUP BY from_user
ORDER BY total_emails DESC, from_user ASC