-- Weight For First Shipment
-- Problem Statement:
-- Write a query to find the weight for each shipment's earliest shipment date. Output the shipment id along with the weight.
-- ID 2057

SELECT shipment_id, weight 
FROM amazon_shipment
WHERE (shipment_id, shipment_date) IN (SELECT shipment_id, MIN(shipment_date)
                                       FROM amazon_shipment GROUP BY 1)