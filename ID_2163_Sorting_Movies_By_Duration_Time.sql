'''
	Sorting Movies By Duration Time
	ID_2163

	PROBLEM STATEMENT:
		You have been asked to sort movies according to their duration in descending order.
		Your output should contain all columns sorted by the movie duration in the given dataset.

	Table: movie_catalogue
	Data Dictionary
		duration: text
		rating: text
		release_year: bigint
		show_id: text
		title: text
	'''

SELECT 
    *
FROM movie_catalogue
ORDER BY CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INTEGER)  DESC
;
