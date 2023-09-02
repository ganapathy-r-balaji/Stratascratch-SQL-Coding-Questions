'''
  Find the countries with the most positive reviews

  ID 9879

  Find the countries whose reviewers give most positive reviews. Positive reviews are all reviews where review text is different than "No Positive" 
  Output all countries along with the number of positive reviews but sort records based on the number of positive reviews in descending order.
  Leave out the countries with no positive reviews.

  DATA DICTIONARY:
  Table: hotel_reviews
  ---------------------
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

WITH cte AS (
    select 
        reviewer_nationality,
        positive_review
    from hotel_reviews
    WHERE NOT positive_review = 'No Positive'
)

SELECT 
    DISTINCT reviewer_nationality,
    COUNT(positive_review) OVER(PARTITION BY reviewer_nationality) AS cntpos
FROM cte
ORDER BY cntpos DESC
