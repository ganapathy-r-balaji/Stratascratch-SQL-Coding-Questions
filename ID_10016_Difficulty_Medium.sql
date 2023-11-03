'''
	Churn Rate Of Lyft Drivers
	ID_10016

	PROBLEM STATEMENT:
		Find the global churn rate of Lyft drivers across all years. Output the rate as a ratio.

   	Table: lyft_drivers
	Data Dictionary
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
	10	4/25/2018	4/28/2018	79536
'''

SELECT 
    COUNT(CASE WHEN end_date IS NOT NULL THEN index ELSE NULL END) / COUNT(*)::DECIMAL AS churn_rate 
FROM lyft_drivers;
