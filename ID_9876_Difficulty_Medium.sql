'''
	Find the top two hotels with the most negative reviews

	ID 9876

	PROBLEM STATEMENT:
		Find the top two hotels with the most negative reviews.
		Output the hotel name along with the corresponding number of negative reviews. Negative reviews are all the reviews with text under negative review different than "No Negative"
		Sort records based on the number of negative reviews in descending order.

	TABLE: hotel_reviews
	Data Dictionary
		hotel_address: varchar
		additional_number_of_scoring: int
		review_date: datetime
		average_score: float
		hotel_name: varchar
		reviewer_nationality: varchar
		negative_review: varchar
		review_total_negative_word_counts: int
		total_number_of_reviews: int
		positive_review: varchar
		review_total_positive_word_counts: int
		total_number_of_reviews_reviewer_has_given: int
		reviewer_score: float
		tags: varchar
		days_since_review: varchar
		lat: float
		lng: float
'''
WITH 
cte AS(
    SELECT 
        hotel_name,
        COUNT(negative_review) as neg_cnt
    FROM hotel_reviews
    WHERE NOT negative_review = 'No Negative'
    GROUP BY hotel_name
    ORDER BY neg_cnt DESC
),
cte2 AS (
    SELECT 
        *, 
        DENSE_RANK() OVER(ORDER BY neg_cnt DESC) AS rnk
    FROM cte
)

SELECT hotel_name, neg_cnt FROM cte2 where rnk <= 2

-- ALTERNATE SOLUTION:
SELECT 
    DISTINCT hotel_name,
    COUNT(*) OVER(PARTITION BY hotel_name) as neg_cnt
FROM hotel_reviews
WHERE NOT negative_review = 'No Negative'
ORDER BY neg_cnt DESC
LIMIT 2

