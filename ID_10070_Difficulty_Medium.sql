'''
DeepMind employment competition
ID 10070

PROBLEM STATEMENT:
	Find the winning teams of DeepMind employment competition.
	Output the team along with the average team score.
	Sort records by the team score in descending order.

Table: google_competition_participants
Data Dictionary:
	member_id: int
	team_id: int
member_id	team_id
0		9
1		8
2		9
3		11
4		7

Table: google_competition_scores
Data Dictionary:
	member_id: int
	member_score: float
member_id	member_score
0		0.918
1		0.823
2		0.661
3		0.554
4		0.662

'''

SELECT 
    team_id,
    AVG(member_score) AS avg_score
FROM google_competition_participants 
JOIN google_competition_scores USING(member_id)
GROUP BY 1
ORDER BY 2 DESC
