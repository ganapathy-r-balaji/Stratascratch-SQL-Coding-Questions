'''
	Department Salaries
	ID 9921

	PROBLEM STATEMENT:
		Find the number of male and female employees per department and also their corresponding total salaries.
		Output department names along with the corresponding number of female employees, the total salary of female employees, the number of male employees, and the total salary of male employees.

   	Table: employee
	Data Dictionary
		id: int
		first_name: varchar
		last_name: varchar
		age: int
		sex: varchar
		employee_title: varchar
		department: varchar
		salary: int
		target: int
		bonus: int
		email: varchar
		city: varchar
		address: varchar
		manager_id: int	
	
	id	first_name	last_name	age	sex	employee_title	department	salary	target	bonus	email			city		address			manager_id
	5	Max		George		26	M	Sales		Sales		1300	200	150	Max@company.com		California	2638 Richards Avenue	1
	13	Katty		Bond		56	F	Manager		Management	150000	0	300	Katty@company.com	Arizona					1
	11	Richerd		Gear		57	M	Manager		Management	250000	0	300	Richerd@company.com	Alabama					1
	10	Jennifer	Dion		34	F	Sales		Sales		1000	200	150	Jennifer@company.com	Alabama					13
	19	George		Joe		50	M	Manager		Management	100000	0	300	George@company.com	Florida		1003 Wyatt Street	1
	
'''

SELECT 
    department,
    COUNT(CASE WHEN sex = 'F' THEN sex ELSE NULL END) AS total_female,
    SUM(CASE WHEN  sex = 'F' THEN salary ELSE NULL END) AS female_salary,
    COUNT(CASE WHEN sex = 'M' THEN sex ELSE NULL END) AS total_male,
    SUM(CASE WHEN  sex = 'M' THEN salary ELSE NULL END) AS male_salary
FROM employee
GROUP BY 1
