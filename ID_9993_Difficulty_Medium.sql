'''
	Find artists with the highest number of top 10 ranked songs over the years
	ID 9993

	PROBLEM STATEMENT:
		Find artists with the highest number of top 10 ranked songs over the years.
		Output the artist along with the corresponding number of top 10 rankings.

    Table: spotify_worldwide_daily_song_ranking
	Data Dictionary
		id: int
		position: int
		trackname: varchar
		artist: varchar
		streams: int
		url: varchar
		date: datetime
		region: varchar	
		
'''
WITH cte AS (
    SELECT
        artist,
        artist_cnt,
        DENSE_RANK() OVER(ORDER BY artist_cnt DESC) AS d_rnk
    FROM (
        SELECT 
            artist,
            COUNT(DISTINCT trackname) as artist_cnt
        FROM spotify_worldwide_daily_song_ranking
        WHERE position < 11 
        GROUP BY artist
    ) a
)

SELECT 
    artist,
    artist_cnt
FROM cte 
WHERE d_rnk = 1
