-- Days At Number One
-- Problem Statement:
	-- Find the number of days a US track has stayed in the 1st position for both the US and worldwide rankings. Output the track name and the number of days in the 1st position. Order your output alphabetically by track name.
	-- If the region 'US' appears in dataset, it should be included in the worldwide ranking.
-- ID 10173

-- Tables: 
	-- Table Name: spotify_daily_rankings_2017_us
		-- Columns Name: Data Type
		-- position: int
		-- trackname: varchar
		-- artist: varchar
		-- streams: int
		-- url: varchar
		-- date: datetime
	-- Table Name: spotify_worldwide_daily_song_ranking
		-- Columns Name: Data Type
		-- id: int
		-- position: int
		-- trackname: varchar
		-- artist: varchar
		-- streams: int
		-- url: varchar
		-- date: datetime
		-- region: varchar		
		
SELECT trackname,
       MAX(n_days_on_n1_position) AS n_days_on_n1_position
FROM
  (SELECT us.trackname,
          SUM(CASE
                  WHEN world.position = 1 THEN 1
                  ELSE 0
              END) OVER(PARTITION BY us.trackname) AS n_days_on_n1_position
   FROM spotify_daily_rankings_2017_us us
   INNER JOIN spotify_worldwide_daily_song_ranking world ON world.trackname = us.trackname
   AND world.date = us.date
   WHERE us.position = 1 ) tmp
GROUP BY trackname
ORDER BY trackname