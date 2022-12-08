-- Find the number of employees who received the bonus and who didn't
-- Problem Statement:
	-- Find the number of employees who received the bonus and who didn't.
	-- Output value inside has_bonus column (1 if they had bonus, 0 if not) along with the corresponding number of employees for each.
-- ID 10081

-- Tables: 
	-- Table Name: employee
		-- Columns Name: Data Type
		-- id: int
		-- first_name: varchar
		-- last_name: varchar
		-- age: int
		-- sex: varchar
		-- employee_title: varchar
		-- department: varchar
		-- salary: int
		-- target: int
		-- bonus: int
		-- email: varchar
		-- city: varchar
		-- address: varchar
		-- manager_id: int
		
	-- Table Name: bonus
		-- Columns Name: Data Type
		-- worker_ref_id: int
		-- bonus_amount: int
		-- bonus_date: datetime

WITH cte1 AS (
    SELECT
        e.id,
        b.worker_ref_id,
        CASE WHEN b.worker_ref_id IS NULL THEN 0 ELSE 1 END AS has_bonus
    FROM employee e
    LEFT JOIN bonus b 
    ON e.id = b.worker_ref_id
)

SELECT 
    distinct has_bonus,
    CASE WHEN has_bonus = 0 THEN COUNT(distinct id) ELSE count(distinct worker_ref_id) END AS n_employees
FROM cte1
GROUP BY has_bonus