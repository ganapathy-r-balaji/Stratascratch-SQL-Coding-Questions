'''
	Sum Of Transportation Numbers

	ID 9819

	PROBLEM STATEMENT:
		Find the sum of all values between the lowest and highest transportation numbers (i.e., exclude the lowest and highest numbers in your sum).
		Your output should have 3 columns: the minimum number, maximum number, and summation.

	Table: transportation_numbers
	Data Dictionary
		index: int
		number: int
'''

SELECT
    (SELECT MIN(number) FROM transportation_numbers) AS min_number,
    (SELECT MAX(number) FROM transportation_numbers) AS max_number,
    SUM(number) AS sum_number
FROM transportation_numbers
WHERE number > (SELECT MIN(number) FROM transportation_numbers)
AND number < (SELECT MAX(number) FROM transportation_numbers)

-- ALTERNATE SOLUTION
SELECT 
    MIN(number) AS min_number,
    MAX(number) AS max_number,
    SUM(number) - MIN(number) - MAX(number) AS sum_number
FROM transportation_numbers

