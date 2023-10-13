'''
	Find the oldest survivor per passenger class
	ID 9883

	PROBLEM STATEMENT:
		Find the oldest survivor of each passenger class.
		Output the name and the age of the survivor along with the corresponding passenger class.
		Order records by passenger class in ascending order.


  Table: lyft_rides
  Data Dictionary
		passengerid: int
		survived: int
		pclass: int
		name: varchar
		sex: varchar
		age: float
		sibsp: int
		parch: int
		ticket: varchar
		fare: float
		cabin: varchar
		embarked: varchar
'''

SELECT
    pclass,
    name,
    age
FROM (
    SELECT 
        pclass,
        name,
        age,
        DENSE_RANK() OVER(PARTITION BY pclass ORDER BY age DESC) AS d_rnk
    FROM titanic
    WHERE survived = 1 
    AND age IS NOT NULL
) a
WHERE d_rnk = 1
