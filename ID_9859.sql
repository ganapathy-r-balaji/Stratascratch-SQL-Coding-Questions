-- Find the first 50% records of the dataset
-- Problem Statement:
	-- Find the first 50% records of the dataset.
-- ID 9859

-- Tables: 
	-- Table Name: worker
		-- Columns Name: Data Type
		-- worker_id: int
		-- first_name: varchar
		-- last_name: varchar
		-- salary: int
		-- joining_date: datetime
		-- department: varchar


WITH cte1 AS (
    SELECT 
        worker_id, 
        first_name, 
        last_name, 
        salary, 
        joining_date, 
        department,
        ROW_NUMBER() OVER() AS rn
    FROM worker
)

SELECT 
    worker_id, 
    first_name, 
    last_name, 
    salary, 
    joining_date, 
    department
FROM cte1
WHERE rn <= (SELECT COUNT(*)/2 FROM worker)