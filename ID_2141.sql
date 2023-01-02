-- Most Recent Employee Login Details
-- Problem Statement:
	-- Amazon's information technology department is looking for information on employees' most recent logins.
	-- The output should include all information related to each employee's most recent login.
-- ID 2141

WITH cte AS 
(
    SELECT 
        worker_id,
        login_timestamp,
        DENSE_RANK() OVER(PARTITION BY worker_id ORDER BY login_timestamp DESC) AS rnk
    FROM worker_logins
)

SELECT 
    wl.*
FROM worker_logins wl
JOIN cte 
ON wl.login_timestamp = cte.login_timestamp
WHERE cte.rnk = 1
ORDER BY cte.worker_id