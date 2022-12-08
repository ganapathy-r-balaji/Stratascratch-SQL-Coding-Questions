-- Find the genre of the person with the most number of oscar winnings
-- Problem Statement:
	-- Find the genre of the person with the most number of oscar winnings.
	-- If there are more than one person with the same number of oscar wins, return the first one in alphabetic order based on their name. Use the names as keys when joining the tables.
-- ID 10171

-- Tables: 
	-- Table Name: oscar_nominees
		-- Columns Name: Data Type
		-- year: int
		-- category: varchar
		-- nominee: varchar
		-- movie: varchar
		-- winner: bool
		-- id: int
	-- Table Name: oscar_nominees
		-- Columns Name: Data Type
		-- name: varchar
		-- amg_person_id: varchar
		-- top_genre: varchar
		-- birthday: datetime
		-- id: int


WITH cte AS (
    SELECT 
        o.nominee,
        n.top_genre,
    FROM oscar_nominees o
    join nominee_information n
    ON o.nominee = n.name
    WHERE o.winner = True
),

cte1 AS (
    SELECT 
        DISTINCT nominee AS nominee_distinct,
        top_genre,
        COUNT(*) OVER(PARTITION BY nominee) AS nominee_count
    FROM cte
    ORDER BY nominee_count DESC
),

cte2 AS (
    SELECT 
        nominee_distinct,
        top_genre,
        DENSE_RANK() OVER(ORDER BY nominee_count DESC) AS rnk
    FROM cte1
)

SELECT 
    DISTINCT top_genre 
FROM cte2
WHERE rnk = 1