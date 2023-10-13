'''
	Median Salary
	ID 9900

	PROBLEM STATEMENT:
		Find the median employee salary of each department.
		Output the department name along with the corresponding salary rounded to the nearest whole dollar.

  Table: lyft_rides
	Data Dictionary
		index: int
        start_date: datetime
        end_date: datetime
        yearly_salary: int
	
id	first_name		last_name	age	sex	employee_title	department	salary	target	bonus	email									city				address								manager_id
5		Max						George		26	M		Sales						Sales				1300		200			150		Max@company.com				California	2638 Richards Avenue	1
13	Katty					Bond			56	F		Manager					Management	150000	0				300		Katty@company.com			Arizona														1
11	Richerd				Gear			57	M		Manager					Management	250000	0				300		Richerd@company.com		Alabama														1
10	Jennifer			Dion			34	F		Sales						Sales				1000		200			150		Jennifer@company.com	Alabama														13
19	George				Joe				50	M		Manager					Management	100000	0				300		George@company.com		Florida			1003 Wyatt Street			1
12	Shandler			Bing			23	M		Auditor					Audit				1100		200			150		Shandler@company.com	Arizona														11
14	Jason					Tom				23	M		Auditor					Audit				1000		200			150		Jason@company.com			Arizona														11
'''
	
SELECT 
    department, 
    percentile_cont(0.5) WITHIN GROUP (ORDER BY salary)
FROM employee
GROUP BY department
