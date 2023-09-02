'''
	Expensive Projects

	ID 10301

	PROBLEM STATEMENT:
		Given a list of projects and employees mapped to each project, calculate by the amount of project budget allocated to each employee . 
		The output should include the project title and the project budget rounded to the closest integer. 
		Order your list by projects with the highest budget per employee first.

	Table: ms_projects
	Data Dictionary:
		id: int
		title: varchar
		budget: int
	
	Table: ms_emp_projects
	Data Dictionary:
		emp_id: int
		project_id: int
'''

SELECT 
    title AS project,
    ROUND(AVG(budget)/COUNT(*)) AS budget_emp_ratio
FROM ms_projects
JOIN ms_emp_projects 
ON ms_projects.id = ms_emp_projects.project_id
GROUP BY title
ORDER BY budget_emp_ratio DESC
