'''
	Unique Highest Salary
	ID 9919

	PROBLEM STATEMENT:
		Find the highest salary among salaries that appears only once.

    Table: employee
	Data Dictionary
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

WITH cte AS (
    SELECT
        salary,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS drnk 
    FROM (SELECT DISTINCT(salary) AS salary FROM employee) a
)

SELECT salary FROM cte WHERE drnk = 1

-- -----------------------------------------------------------

SELECT
    MAX(salary) AS salary
FROM
(
	SELECT
	        salary
	FROM employee
	GROUP BY salary
	HAVING COUNT(salary) = 1
) a
