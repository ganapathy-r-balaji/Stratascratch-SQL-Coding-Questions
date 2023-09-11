'''
	Session Type Duration
	ID 2011

	PROBLEM STATEMENT
		Calculate the average session duration for each session type?

	Table: twitch_sessions
	Data Dictionary
		user_id: int
		session_start: datetime
		session_end: datetime
		session_id: int
		session_type: varchar

	First 5 rows of the table:
	---------------------------
	user_id		session_start			session_end		session_id		session_type
	0		2020-08-11 05:51:31		2020-08-11 05:54:45		539			streamer
	2		2020-07-11 03:36:54		2020-07-11 03:37:08		840			streamer
	3		2020-11-26 11:41:47		2020-11-26 11:52:01		848			streamer
	1		2020-11-19 06:24:24		2020-11-19 07:24:38		515			viewer
	2		2020-11-14 03:36:05		2020-11-14 03:39:19		646			viewer

'''

SELECT
    session_type,
    AVG(session_duration) AS avg_session_duration
FROM
(
    SELECT 
        session_type,
        (session_end - session_start) AS session_duration 
    FROM twitch_sessions
) a
GROUP BY session_type
