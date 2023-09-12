'''
	Call Declines
	ID 2020

	PROBLEM STATEMENT:
		Which company had the biggest month call decline from March to April 2020? Return the company_id and calls difference for the company with the highest decline.

	Table: rc_calls					Table: rc_users				
	Data Dictionary                 Data Dictionary				
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

-- SELECT * FROM rc_calls, rc_users
WITH base AS (
    SELECT
        rc.user_id,
        rc.date::date AS date,
        to_char(rc.date, 'mm-yyyy') AS month_year,
        rc.call_id,
        ru.status,
        ru.company_id
    FROM rc_calls rc
    JOIN rc_users ru
    ON rc.user_id = ru.user_id
), 
march AS (
    SELECT
        company_id,
        COUNT(*) AS march_count
    FROM base
    WHERE month_year = '03-2020'
    GROUP BY 1
),
april AS (
    SELECT
        company_id,
        COUNT(*) AS april_count
    FROM base
    WHERE month_year = '04-2020'
    GROUP BY 1
),
cte AS (
    SELECT
        company_id,
        variance,
        DENSE_RANK() OVER(ORDER BY abs_variance DESC) AS d_rnk
    FROM (
        SELECT
            march.company_id,
            march.march_count,
            april.april_count,
            (april.april_count - march.march_count) AS variance,
            ABS(april.april_count - march.march_count) AS abs_variance
        FROM march
        JOIN april ON march.company_id = april.company_id
    ) a
)

SELECT 
    company_id,
    variance
FROM cte WHERE d_rnk = 1
