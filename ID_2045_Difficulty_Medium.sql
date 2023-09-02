'''
	Days Without Hiring/Termination

	ID 2045

	PROBLEM STATEMENT:
		Write a query to calculate the longest period (in days) that the company has gone without hiring anyone. Also, calculate the longest period without firing anyone. 
		Limit yourself to dates inside the table (last hiring/termination date should be the latest hiring /termination date from table), do not go into future.

	Table: uber_employees
	Data Dictionary:
		first_name: varchar
		last_name: varchar
		id: int
		hire_date: datetime
		termination_date: datetime
		salary: int
'''

WITH uber_hire AS 
(
    SELECT
        (lead_hire_date - hire_date) AS lead_hires
    FROM
    (
        SELECT 
            *,
            LEAD(hire_date) OVER(ORDER BY hire_date) AS lead_hire_date
        FROM uber_employees
    ) a
),
uber_fire AS 
(
    SELECT
        (lead_termination_date - termination_date) AS lead_terminations
    FROM
    (
        SELECT 
            *,
            LEAD(termination_date) OVER(ORDER BY termination_date) AS lead_termination_date
        FROM uber_employees
    ) a
)

SELECT 
    max(lead_hires) AS max_hire,
    max(lead_terminations) AS max_fire
FROM uber_hire, uber_fire
