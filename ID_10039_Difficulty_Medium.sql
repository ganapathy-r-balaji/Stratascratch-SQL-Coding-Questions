''' 
	Macedonian Vintages

	ID 10039

	PROBLEM STATEMENT:
		Find the vintage years of all wines from the country of Macedonia. The year can be found in the 'title' column. 
		
		Output the wine (i.e., the 'title') along with the year. The year should be a numeric or int data type.

	Table: winemag_p2
	Data Dictionary:
		id: int
		country: varchar
		description: varchar
		designation: varchar
		points: int
		price: float
		province: varchar
		region_1: varchar
		region_2: varchar
		taster_name: varchar
		taster_twitter_handle: varchar
		title: varchar
		variety: varchar
		winery: varchar
'''

SELECT 
    title,
    (regexp_matches(title, '[0-9]+\.?[0-9]*'))[1]::numeric AS year
FROM winemag_p2
WHERE country = 'Macedonia'
