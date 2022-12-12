-- Finding Updated Records
-- Problem Statement:
	-- We have a table with employees and their salaries, however, some of the records are old 
	-- and contain outdated salary information. 
	-- Find the current salary of each employee assuming that salaries increase each year. 
	-- Output their id, first name, last name, department ID, and current salary. 
	-- Order your list by employee ID in ascending order.
-- ID 10299

-- Tables: 
	-- Table Name: employee
		-- Columns Name: Data Type
		-- id: int
		-- first_name: varchar
		-- last_name: varchar
		-- salary: int
		-- department_id: int

SELECT 
    DISTINCT id,
    first_name,
    last_name,
    department_id,
    MAX(salary) OVER(PARTITION BY id) AS max_salary
FROM ms_employee_salary
order BY id ASC