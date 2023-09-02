'''
	Share of Loan Balance

	ID 2001

	PROBLEM STATEMENT:
		Write a query that returns the rate_type, loan_id, loan balance , and a column that shows with what percentage the loan balance contributes to the total balance among the loans of the same rate type.

	Table: submissions
	Data Dictionary:
		id: int
		balance:float
		interest_rate: float
		rate_type: varchar
		loan_id: int
'''

SELECT 
    loan_id,
    rate_type,
    balance,
    100* balance / (SUM(balance) OVER(PARTITION BY rate_type))
FROM submissions
