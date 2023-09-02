'''
  Book Sales

  ID 2128
  Calculate the total revenue made per book. Output the book ID and total sales per book. In case there is a book that has never been sold, include it in your output with a value of 0.
	
  Tables: amazon_books, amazon_books_order_details

  DATA DICTIONARY:
  
  Table: amazon_books
  book_id: varchar
  book_title: varchar
  unit_price: int

  Table: amazon_books_order_details
  order_details_id: varchar
  order_id: varchar
  book_id: varchar
  quantity: int
'''

SELECT
    book_id,
    SUM(qty*unit_price) AS total_sales_per_book
FROM
(
SELECT 
    book_id,
    unit_price,
    COALESCE(quantity, 0) AS qty
FROM amazon_books
LEFT JOIN amazon_books_order_details
USING (book_id)
) a
GROUP BY 1
