'''
	Update Call Duration
	ID 2022

	PROBLEM STATEMENT:
		Redfin helps clients to find agents. Each client will have a unique request_id and each request_id has several calls. 
		For each request_id, the first call is an “initial call” and all the following calls are “update calls”.  What is the average call duration for all update calls?

	Table: redfin_call_tracking
	Data Dictionary
		created_on: datetime
		request_id: int
		call_duration: int
		id: int

	First 5 rows of the table:
	---------------------------
	created_on		request_id		call_duration		id
	3/1/2020 4:08		2			3					1
	3/1/2020 5:28		1			28					2
	3/1/2020 7:27		2			22					3
	3/1/2020 13:18		1			12					4
	3/1/2020 15:08		2			13					5
'''

SELECT
    AVG(call_duration) AS avg_call_duration
FROM (
    SELECT 
        call_duration,
        ROW_NUMBER() OVER(PARTITION BY request_id ORDER BY created_on) AS row_num
    FROM redfin_call_tracking
) a
WHERE row_num != 1
