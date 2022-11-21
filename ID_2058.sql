-- Total Shipment Weight
-- Problem Statement:
-- Calculate the total weight for each shipment and add it as a new column. Your output needs to have all the existing rows and columns in addition to the  new column that shows the total weight for each shipment. One shipment can have multiple rows.
-- ID 2058

SELECT *, SUM(weight) OVER(PARTITION BY shipment_id) as sum_weight 
FROM amazon_shipment