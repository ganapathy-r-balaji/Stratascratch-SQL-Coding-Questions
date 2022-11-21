-- Workers With The Highest Salaries
-- Problem Statement:
	-- Find the titles of workers that earn the highest salary. Output the highest-paid title or multiple titles that share the highest salary.
-- ID 10353

-- Tables: 
	-- Table Name: worker
		-- Columns Name: Data Type
		-- worker_id: int
		-- first_name: varchar
		-- last_name: varchar
		-- salary: int
		-- joining_date: datetime
		-- department: varchar
	-- Table Name: title
		-- worker_ref_id: int
		-- worker_title: varchar
		-- affected_from: datetime

SELECT 
    t.worker_title
FROM worker w
LEFT JOIN title t 
ON w.worker_id = t.worker_ref_id
WHERE w.salary = (SELECT MAX(salary) FROM worker)

-- Alternate Solution
WITH cte AS (
    SELECT 
        t.worker_title AS worker_title,
        DENSE_RANK() OVER(ORDER BY w.salary DESC) as rnk
    FROM worker w
    LEFT JOIN title t 
    ON w.worker_id = t.worker_ref_id
)

SELECT worker_title FROM cte where rnk = 1
-- Note: You can use either RANK() or DENSE_RANK()
