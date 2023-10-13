'''
	Lyft Driver Salary And Service Tenure
	ID_10018

	PROBLEM STATEMENT:
		Find the correlation between the annual salary and the length of the service period of a Lyft driver.

    Table: lyft_rides
	Data Dictionary
		index: int
        start_date: datetime
        end_date: datetime
        yearly_salary: int
	
    index	start_date	end_date	yearly_salary
    0    	4/2/2018		        48303
    1	    	5/30/2018		        67973
    2	    	4/5/2015		        56685
    3	        1/8/2015		        51320
    4    	3/9/2017		        67507
    5	    	9/7/2015		        55155
    6	    	5/22/2016	8/6/2018	35847
    7    	9/29/2015	7/20/2018	46974
    8    	9/15/2015	4/30/2019	54316
    9    	9/20/2015	12/31/2017	56185
'''

SELECT 
    CORR(duration, yearly_salary)
FROM
(
    SELECT 
        (COALESCE(end_date::DATE, CURRENT_DATE) - COALESCE(start_date::DATE, CURRENT_DATE))::NUMERIC AS duration,
        yearly_salary
    FROM lyft_drivers
) a
