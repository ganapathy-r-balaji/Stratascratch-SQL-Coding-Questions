'''
	Make a report showing the number of survivors and non-survivors by passenger class

	ID 9881

	PROBLEM STATEMENT:
		Make a report showing the number of survivors and non-survivors by passenger class.
		Classes are categorized based on the pclass value as:
		pclass = 1: first_class
		pclass = 2: second_classs
		pclass = 3: third_class
		Output the number of survivors and non-survivors by each class.

	Table: titanic
	DATA DICTIONARY
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
    survived,
    COUNT(pclass) FILTER(WHERE pclass = 1) AS first_class,
    COUNT(pclass) FILTER(WHERE pclass = 2) AS second_class,
    COUNT(pclass) FILTER(WHERE pclass = 3) AS third_class
FROM titanic
GROUP BY survived
    
-- ALTERNATE SOLUTION:
SELECT
    survived,
    SUM(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) first_class,
    SUM(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) second_class,
    SUM(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) third_class
FROM titanic
GROUP BY survived
