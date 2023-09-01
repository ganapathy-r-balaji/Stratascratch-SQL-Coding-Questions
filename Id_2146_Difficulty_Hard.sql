-- Department Manager and Employee Salary Comparison

-- Oracle is comparing the monthly wages of their employees in each department to those of their managers and co-workers.
-- You have been tasked with creating a table that compares an employee's salary to that of their manager and to the average salary of their department.
-- It is expected that the department manager's salary and the average salary of employee's from that department are in their own separate column.
-- Order the employee's salary from highest to lowest based on their department.
-- Your output should contain the department, employee id, salary of that employee, salary of that employee's manager and the average salary from employee's within that department rounded to the nearest whole number.
-- Note: Oracle have requested that you not include the department manager's salary in the average salary for that department in order to avoid skewing the results. 
-- Managers of each department do not report to anyone higher up; they are their own manager.

'''
Table Name: employee_o
Data Sictionary:
  id: int
  first_name: varchar
  last_name: varchar
  age: int
  gender: varchar 
  employee_title: varchar
  department: varchar
  salary: int
  manager_id: int
'''

SELECT 
    e1.department,
    e1.id AS employee_id,
    e1.salary AS employee_salary,
    e2.salary AS manager_salary,
    ROUND(AVG(e1.salary) OVER(PARTITION BY e1.department)) as avg_employee_salary
FROM employee_o e1
JOIN employee_o e2 ON e1.manager_id = e2.id AND e1.id != e2.id
GROUP BY 1, 2, 3, 4
ORDER BY 1, 3 DESC
