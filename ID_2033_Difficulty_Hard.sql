'''
	Find The Most Profitable Location
	ID 2033

	PROBLEM STATEMENT:
		Find the most profitable location. Write a query that calculates the average signup duration and average transaction amount for each location, 
		and then compare these two measures together by taking the ratio of the average transaction amount and average duration for each location.
		Your output should include the location, average duration, average transaction amount, and ratio. Sort your results from highest ratio to lowest.

	Table: signups
	Data Dictionary
		signup_id: int 
		signup_start_date: datetime
		signup_stop_date: datetime
		plan_id: int
		location: varchar

	Table: transactions
	Data Dictionary
		transaction_id: int
		signup_id: int
		transaction_start_date: datetime
		amt: float

	First 5 rows of the "signups" table:
	-------------------------------------
	signup_id	signup_start_date	signup_stop_date	plan_id		location
	100		2020-04-23		2020-05-19		11		Rio De Janeiro
	101		2020-04-09		2020-07-06		11		Mexico City
	102		2020-04-21		2020-10-08		10		Mendoza
	103		2020-04-04		2020-06-19		11		Rio De Janeiro
	104		2020-04-24		2020-06-28		21		Las Vegas

	First 5 rows of the "transactions" table:
	------------------------------------------
	transaction_id	signup_id	transaction_start_date		amt
	1		100		2020-04-30			24.9
	2		101		2020-04-16			24.9
	3		102		2020-04-28			9.9
	4		102		2020-05-28			9.9
	5		102		2020-06-27			9.9

'''
WITH 
    base AS (
        SELECT
            location,
            AVG(DISTINCT signup_duration) AS mean_duration,
            AVG(transaction_amt) AS mean_revenue,
            AVG(transaction_amt)/AVG(signup_duration) AS ratio
        FROM (
            SELECT 
                s.location,
                (s.signup_stop_date - s.signup_start_date) AS signup_duration,
                t.amt AS transaction_amt 
            FROM signups s
            JOIN transactions t 
            ON s.signup_id = t.signup_id
        ) a
        GROUP BY 1
    )
SELECT 
    * 
FROM base 
ORDER BY ratio DESC
