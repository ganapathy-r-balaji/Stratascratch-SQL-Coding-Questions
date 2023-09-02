'''
	Second Highest Salary Without ORDER BY
	
	ID 9857
	
	Problem Statement: Find the second highest salary without using ORDER BY.

	Table: worker
	DATA DICTIONARY:
	worker_id: int
	first_name: varchar
	last_name: varchar
	salary: int
	joining_date: datetime
	department: varchar
'''

SELECT 
    MAX(salary)
FROM worker 
WHERE salary NOT IN (SELECT MAX(salary) FROM worker)
