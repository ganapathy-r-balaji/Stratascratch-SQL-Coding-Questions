'''
  Rank Variance Per Country

  ID 2007
  Which countries have risen in the rankings based on the number of comments between Dec 2019 vs Jan 2020? Hint: Avoid gaps between ranks when ranking countries.

  Tables: fb_comments_count, fb_active_users

  DATA DICTIONARY:
  
  Table: fb_comments_count
  user_id: int
  created_at: datetime
  number_of_comments: int

  Table: fb_active_users
  user_id: int
  name: varchar
  status: varchar
  country: varchar
'''
with dec_2019 AS(
SELECT country,
       sum(number_of_comments) AS total_comments,
       DENSE_RANK() OVER(ORDER BY  sum(number_of_comments) DESC) AS rank_dec,
       TO_CHAR(created_at, 'YYYY-MM') AS created_at_ym
FROM 
fb_comments_count AS cm
join fb_active_users AS users
    ON cm.user_id = users.user_id
    AND TO_CHAR(created_at, 'YYYY-MM') ='2019-12'
WHERE country IS NOT NULL
group by country, created_at_ym
 ),
 
jan_2020 AS(
SELECT country,
       sum(number_of_comments) AS total_comments,
       DENSE_RANK() OVER(ORDER BY  sum(number_of_comments) DESC) AS rank_jan,
       TO_CHAR(created_at, 'YYYY-MM') AS created_at_ym
FROM 
fb_comments_count AS cm
join fb_active_users AS users
    ON cm.user_id = users.user_id
    AND TO_CHAR(created_at, 'YYYY-MM') ='2020-01'
WHERE country IS NOT NULL
group by country, created_at_ym
 )
 
 select jan_2020.country from 
 dec_2019
RIGHT JOIN 
 jan_2020
 ON dec_2019.country=jan_2020.country
 WHERE rank_jan < ranK_dec
      or rank_dec IS NULL


-- ALTERNATE SOLUTION
WITH 
dec_2019 AS (
    SELECT 
        DISTINCT country,
        SUM(number_of_comments) OVER(PARTITION BY country) AS comments_dec_2019
    FROM fb_comments_count
    JOIN fb_active_users
    USING (user_id)
    WHERE TO_CHAR(created_at, 'YYYY-MM') = '2019-12'
),
jan_2020 AS  (
    SELECT 
        DISTINCT country,
        SUM(number_of_comments) OVER(PARTITION BY country) AS comments_jan_2020
    FROM fb_comments_count
    JOIN fb_active_users
    USING (user_id)
    WHERE TO_CHAR(created_at, 'YYYY-MM') = '2020-01'
),
cte AS (
    SELECT 
        country, 
        CASE WHEN comments_dec_2019 IS NULL THEN 0 ELSE comments_dec_2019 END AS dec_2019_comments,
        CASE WHEN comments_jan_2020 IS NULL THEN 0 ELSE comments_jan_2020 END AS jan_2020_comments
    FROM dec_2019 
    FULL OUTER JOIN jan_2020 USING(country)
)
SELECT
    country
FROM
(
    SELECT 
        country,
        (jan_2020_comments - dec_2019_comments) AS comments_diff
    FROM cte
) a
WHERE comments_diff > 0
ORDER BY comments_diff DESC
LIMIT 2

