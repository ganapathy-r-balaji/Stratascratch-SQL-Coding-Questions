-- Class Performance
-- Problem Statement:
	-- You are given a table containing assignment scores of students in a class. Write a query that identifies the largest difference in total score  of all assignments.
	-- Output just the difference in total score (sum of all 3 assignments) between a student with the highest score and a student with the lowest score.
-- ID 10310

-- Tables: 
	-- Table Name: cust_tracking
		-- Columns Name: Data Type
		-- id: int
		-- student: varchar
		-- assignment1: int
		-- assignment2: int
		-- assignment3: int

SELECT
    max(total_scores) - min(total_scores) AS difference_in_scores
FROM
    (
    SELECT
        DISTINCT student,
        SUM(assignment_scores) OVER(PARTITION BY student) AS total_scores
    FROM
        (
            SELECT 
                student,
                assignment1 as assignment_scores
            FROM box_scores
            UNION ALL
            SELECT 
                student,
                assignment2 as assignment_scores
            FROM box_scores
            UNION ALL
            SELECT 
                student,
                assignment3 as assignment_scores
            FROM box_scores
        ) a
    ) b