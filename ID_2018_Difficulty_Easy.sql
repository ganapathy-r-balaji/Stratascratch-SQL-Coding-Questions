'''
	Inactive Free Users
	ID 2018

	PROBLEM STATEMENT:
		Return a list of users with status free who didn’t make any calls in Apr 2020.
	
	Table: rc_calls					Table: rc_users				
	user_id: int					user_id: int							
	date: datetime                  status: varchar				
	call_id: int                    company_id: int			
	
	First 5 rows of the "rc_calls" table:
	---------------------------------------------
	user_id		date			call_id
	1218		4/19/2020 1:06		0
	1554		3/1/2020 16:51		1
	1857		3/29/2020 7:06		2
	1525		3/7/2020 2:01		3
	1271		4/28/2020 21:39		4

	Rows of the "rc_users" table:
	---------------------------
	user_id		status		company_id
	1218		free		1
	1554		inactive	1
	1857		free		2
	1525		paid		1
	1271		inactive	2

'''

SELECT 
    user_id
FROM rc_users
WHERE status = 'free'
AND user_id NOT in (
    SELECT 
        user_id
    FROM rc_calls
    WHERE EXTRACT(month FROM date)=4
)
