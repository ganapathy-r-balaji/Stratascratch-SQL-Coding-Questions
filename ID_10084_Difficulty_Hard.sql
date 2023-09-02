'''
Cum Sum Energy Consumption

Calculate the running total (i.e., cumulative sum) energy consumption of the Meta/Facebook data centers in all 3 continents by the date. 
Output the date, running total energy consumption, and running total percentage rounded to the nearest whole number.

ID 10084

Tables: fb_eu_energy, fb_na_energy, fb_asia_energy

Data Dictionary:
Table: fb_eu_energy
date: datetime
consumption: int

Table: fb_na_energy
date: datetime
consumption: int

Table: fb_asia_energy
date: datetime
consumption: int
'''

WITH 
total_energy AS (
   SELECT 
      *
   FROM fb_eu_energy eu
   UNION ALL 
   SELECT 
      *
   FROM fb_asia_energy asia
   UNION ALL 
   SELECT 
      *
   FROM fb_na_energy na),
energy_by_date AS (
   SELECT 
      date,
      sum(consumption) AS total_energy
   FROM total_energy
   GROUP BY date
   ORDER BY date ASC)

SELECT 
    date,
    SUM(total_energy) OVER (ORDER BY date ASC) AS cumulative_total_energy,
    ROUND(SUM(total_energy) OVER (ORDER BY date ASC) * 100 / (SELECT sum(total_energy) FROM energy_by_date), 0) AS percentage_of_total_energy
FROM energy_by_date
