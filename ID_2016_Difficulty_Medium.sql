'''
	Pizza Partners
	ID 2016

	PROBLEM STATEMENT:
		Which partners have ‘pizza’ in their name and are located in Boston? And what is the average order amount? Output the partner name and the average order amount.


	Table: postmates_orders				Table: postmates_markets				Table: postmates_partners
	Data Dictionary                                 Data Dictionary						Data Dictionary
	id: int						id: int							id: int
	customer_id: int                                name: varchar						name: varchar
	courier_id: int                                 timezone: varchar					category: varchar
	seller_id: int                                                      
	order_timestamp_utc: datetime
	amount: float
	city_id: int
	
	First 5 rows of the "postmates_orders" table:
	---------------------------
	id	customer_id	courier_id	seller_id	order_timestamp_utc	amount	city_id
	1	102		224		79		3/11/2019 23:27		155.73	47
	2	104		224		75		4/11/2019 4:24		216.6	44
	3	100		239		79		3/11/2019 21:17		168.69	47
	4	101		205		79		3/11/2019 2:34		210.84	43
	5	103		218		71		4/11/2019 0:15		212.6	47

	Rows of the "postmates_markets" table:
	---------------------------
	id	name	timezone
	43	Boston	EST
	44	Seattle	PST
	47	Denver	MST
	49	Chicago	CST

	Rows of the "postmates_partners" table:
	---------------------------
	id	name			category
	71	Papa John's		Pizza
	75	Domino's Pizza	Pizza
	77	Pizza Hut		Pizza
	79	Papa Murphy's	Pizza

'''

SELECT 
    pp.name,
    AVG(po.amount) AS avg_amount
FROM postmates_orders po
JOIN postmates_partners pp
ON po.seller_id = pp.id
WHERE po.city_id IN (SELECT id FROM postmates_markets WHERE LOWER(name) LIKE '%boston%')
AND LOWER(pp.name) LIKE '%pizza%'
GROUP BY 1

