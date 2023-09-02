'''
	Second Highest Salary

	ID 9892

	PROBLEM STATEMENT:
		Find the second highest salary of employees.

	Table: employee
	Data Dictionary:
		id: int
		first_name: varchar
		last_name: varchar
		age: int
		sex: varchar
		employee_title: varchar
		department: varchar
		salary: int
		target: int
		bonus: int
		email: varchar
		city: varchar
		address: varchar
		manager_id: int
'''

SELECT
    DISTINCT salary 
FROM
    (
        select 
            salary,
            DENSE_RANK() OVER(ORDER BY salary DESC) AS salary_rank
        from employee
    ) a
WHERE salary_rank = 2
