'''
Hosts Abroad Apartments
ID 10071

PROBLEM STATEMENT:
	Find the number of hosts that have accommodations in countries of which they are not citizens.

Table: airbnb_hosts
Data Dictionary:
	host_id: int
	nationality: varchar
	gender: varchar
	age: int

host_id	nationality	gender	age
0	USA		M	28
1	USA		F	29
2	China		F	31
3	China		M	24
4	Mali		M	30

Table: airbnb_apartments
Data Dictionary:
	host_id: int
	apartment_id: varchar
	apartment_type: varchar
	n_beds: int
	n_bedrooms: int
	country: varchar
	city: varchar

host_id	apartment_id	apartment_type	n_beds	n_bedrooms	country	city
0	A1		Room		1	1		USA	New York
0	A2		Room		1	1		USA	New Jersey
0	A3		Room		1	1		USA	New Jersey
1	A4		Apartment	2	1		USA	Houston
1	A5		Apartment	2	1		USA	Las Vegas

'''

SELECT 
    COUNT(DISTINCT host_id)
FROM airbnb_hosts
JOIN airbnb_apartments USING(host_id) 
WHERE country NOT IN (select nationality from airbnb_hosts)
