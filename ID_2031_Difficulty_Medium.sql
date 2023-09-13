'''
	Transactions By Billing Method and Signup ID
	ID 2031

	PROBLEM STATEMENT:
		Get list of signups which have a transaction start date earlier than 10 months ago from March 2021. For all of those users get the average transaction value and group it by the billing cycle. 		
		Your output should include the billing cycle, signup_id of the user, and average transaction amount. Sort your results by billing cycle in reverse alphabetical order and signup_id in ascending order.


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
	
	Table: transactions
	Data Dictionary
		transaction_id: int
		signup_id: int
		transaction_start_date: datetime
		amt: float
	
	First 5 rows of the "transactions" table:
	---------------------------
	transaction_id	signup_id	transaction_start_date	amt
	1		100		4/30/2020		24.9
	2		101		4/16/2020		24.9
	3		102		4/28/2020		9.9
	4		102		5/28/2020		9.9
	5		102		6/27/2020		9.9

	
	Table: plans
	Data Dictionary
		id: int
		billing_cycle: varchar
		avg_revenue: float
		currency: varchar
	
	First 5 rows of the "plans" table:
	---------------------------
	id	billing_cycle	avg_revenue	currency
	10	monthly			9.9			USD
	11	quarterly		24.9		USD
	12	annual			109.9		USD
	20	monthly			9.9			USD
	21	quarterly		24.9		USD
	22	annual			109.9		USD
		
'''

SELECT 
    p.billing_cycle,
    s.signup_id,
    AVG(p.avg_revenue) AS avg_amt
FROM signups s
JOIN transactions t ON s.signup_id = t.signup_id
JOIN plans p ON s.plan_id = p.id 
WHERE transaction_start_date < (date '2021-03-01' - INTERVAL '10 month')::date
GROUP BY 1, 2
ORDER by p.billing_cycle DESC, s.signup_id
