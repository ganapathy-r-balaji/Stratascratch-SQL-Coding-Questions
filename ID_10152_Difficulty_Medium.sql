'''
	Workers With The Highest And Lowest Salaries

	ID: 10152

	PROBLEM STATEMENT:
	You have been asked to find the employees with the highest and lowest salary. 
	Your output should include the employee ID, salary, and department, as well as a column salary_type that categorizes the output by:
		'Highest Salary' represents the highest salary
		'Lowest Salary' represents the lowest salary.

	DATA DICTIONARY:

	Table: worker
	worker_id: int
	first_name: varchar
	last_name: varchar
	salary: int
	joining_date: datetime
	department: varchar

	Table: title
	worker_ref_id: int
	worker_title: varchar
	affected_from: datetime
'''

WITH base AS
(
    SELECT
        w.worker_id,
        w.salary,
        w.department,
        DENSE_RANK() OVER(ORDER BY w.salary DESC) AS rnk
    FROM worker w
), 

highest_salary AS
(
    SELECT
        worker_id,
        salary,
        department,
        'Highest Salary' AS salary_type
    FROM base
    WHERE rnk = (SELECT MIN(rnk) FROM base)
),

lowest_salary AS
(
    SELECT
        worker_id,
        salary,
        department,
        'Lowest Salary' AS salary_type
    FROM base
    WHERE rnk = (SELECT MAX(rnk) FROM base)
)

SELECT * FROM highest_salary
UNION 
SELECT * FROM lowest_salary

