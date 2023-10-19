'''
Start Dates Of Top Drivers
ID 10083

PROBLEM STATEMENT:
	Find contract starting dates of the top 5 most paid Lyft drivers. Consider only drivers who are still working with Lyft.

Table: lyft_drivers
Data Dictionary:
	index: int
	start_date: datetime
	end_date: datetime
	yearly_salary: int
index	start_date	end_date	yearly_salary
0	4/2/2018			48303
1	5/30/2018			67973
2	4/5/2015			56685
3	1/8/2015			51320
4	3/9/2017			67507
5	9/7/2015			55155
6	5/22/2016	8/6/2018	35847
7	9/29/2015	7/20/2018	46974
8	9/15/2015	4/30/2019	54316
9	9/20/2015	12/31/2017	56185
'''

SELECT
    start_date
FROM
(
    SELECT 
        *,
        DENSE_RANK() OVER(ORDER BY yearly_salary DESC) AS drnk
    FROM lyft_drivers 
    WHERE end_date IS NULL
) a
WHERE drnk <= 5
