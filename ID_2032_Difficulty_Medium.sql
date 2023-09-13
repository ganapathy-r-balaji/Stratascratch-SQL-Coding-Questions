'''
	Signups By Billing Cycle
	ID 2032

	PROBLEM STATEMENT:
		Write a query that returns a table containing the number of signups for each weekday and for each billing cycle frequency.
    Output the weekday number (e.g., 1, 2, 3) as rows in your table and the billing cycle frequency (e.g., annual, monthly, quarterly) as columns. If there are NULLs in the output replace them with zeroes.



	Table: signups
	Data Dictionary
		signup_id: int
		signup_start_date: datetime
		signup_stop_date: datetime
		plan_id: int
		location: varchar
	
	First 5 rows of the "signups" table:
	---------------------------
	signup_id	signup_start_date	signup_stop_date	plan_id		location
	100		4/23/2020		5/19/2020		11		Rio De Janeiro
	101		4/9/2020		7/6/2020		11		Mexico City
	102		4/21/2020		10/8/2020		10		Mendoza
	103		4/4/2020		6/19/2020		11		Rio De Janeiro
	104		4/24/2020		6/28/2020		21		Las Vegas
	
	Table: plans
	Data Dictionary
		id: int
		billing_cycle: varchar
		avg_revenue: float
		currency: varchar
	
	First 5 rows of the "plans" table:
	---------------------------
	id	billing_cycle	avg_revenue	currency
	10	monthly		9.9		USD
	11	quarterly	24.9		USD
	12	annual		109.9		USD
	20	monthly		9.9		USD
	21	quarterly	24.9		USD
	22	annual		109.9		USD
'''

SELECT 
    extract(dow from signup_start_date) AS weekday,
    COUNT(DISTINCT CASE WHEN billing_cycle='annual' THEN signup_id END) AS annual, 
    COUNT(DISTINCT CASE WHEN billing_cycle='quarterly' THEN signup_id END) AS quarterly,
    COUNT(DISTINCT CASE WHEN billing_cycle='monthly' THEN signup_id END) AS monthly
FROM signups s 
JOIN plans p ON s.plan_id = p.id  
GROUP BY 1
