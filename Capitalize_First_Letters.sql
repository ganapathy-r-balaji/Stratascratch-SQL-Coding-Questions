'''
	Capitalize First Letters
	ID_10546

	PROBLEM STATEMENT:
		Convert the first letter of each word found in content_text to uppercase, while keeping the rest of the letters lowercase.
		Your output should include the original text in one column and the modified text in another column.

    Table: user_content
	Data Dictionary
		content_id: bigint
		content_text: text
		content_type: text
		customer_id: bigint
	
	content_id	customer_id	content_type	content_text
	1			2			comment			hello world! this is a TEST.
	2			8			comment			what a great day
	3			4			comment			WELCOME to the event.
	4			2			comment			e-commerce is booming.
	5			6			comment			Python is fun!!
	6			6			review			123 numbers in text.
	7			10			review			special chars: @#$$%^&*()
	8			4			comment			multiple CAPITALS here.
	9			6			review			sentence. and ANOTHER sentence!
	10			2			post			goodBYE!

'''

SELECT 
    content_text,
    CASE WHEN SUBSTRING(content_text FROM 1 FOR 1) ~ '^[a-zA-Z]' 
        THEN concat(upper(substring(content_text,1,1)),substring(content_text,2,length(content_text))) 
        ELSE content_text
    END AS new_content_text
FROM  user_content;
