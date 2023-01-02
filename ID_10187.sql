-- Find the total number of available beds per hosts' nationality
-- Problem Statement:
	-- Find the total number of available beds per hosts' nationality.
	-- Output the nationality along with the corresponding total number of available beds.
	-- Sort records by the total available beds in descending order.
-- ID 10187

-- Tables: 
	-- Table Name: airbnb_apartments
		-- Columns Name: Data Type
		-- host_id: int
		-- apartment_id: varchar
		-- apartment_type: varchar
		-- n_beds: int
		-- n_bedrooms: int
		-- country: varchar
		-- city: varchar

	-- Table Name: airbnb_hosts
		-- Columns Name: Data Type
		-- host_id: int
		-- nationality: varchar
		-- gender: varchar
		-- age: int

select
    nationality,
    SUM(n_beds) AS total_beds_available
FROM(
select
        aa.n_beds, 
        ah.nationality 
    from airbnb_apartments aa
    INNER JOIN airbnb_hosts ah
    ON aa.host_id = ah.host_id
) a
GROUP BY nationality
ORDER BY total_beds_available DESC
