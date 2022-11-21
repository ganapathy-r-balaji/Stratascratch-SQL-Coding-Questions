-- Salaries Differences
-- Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.
-- ID 10308

-- Method 1: 
SELECT 
    ABS(
    (
        SELECT 
            MAX(de.salary)
        FROM db_employee de
        LEFT JOIN db_dept dd
        ON de.department_id = dd.id
        WHERE department = 'marketing'
        ) - 
        (SELECT 
            MAX(de.salary)
        FROM db_employee de
        LEFT JOIN db_dept dd
        ON de.department_id = dd.id
        WHERE department = 'engineering')
    ) AS max_salary_diff

-- Method 2: 
SELECT 
    MAX(CASE WHEN dd.department = 'marketing' THEN de.salary END) - 
    MAX(CASE WHEN dd.department = 'engineering' THEN de.salary END) AS max_salary_diff
FROM db_employee de
LEFT JOIN db_dept dd
ON de.department_id = dd.id

