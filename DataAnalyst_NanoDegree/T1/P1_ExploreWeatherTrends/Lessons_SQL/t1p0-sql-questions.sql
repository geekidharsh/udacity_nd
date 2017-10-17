-- schema: 
	/*accounts
	orders
	region
	sales_reps
	web_events
	*/

-- * ORDER BY 
	/* Write a query that returns the top 5 rows from orders ordered according to newest to oldest, 
	but with the largest total_amt_usd for each date listed first for each date. 
	*/
	SELECT * FROM orders ORDER BY occurred_at desc, total_amt_usd desc limit 5


	/*Write a query that returns the top 10 rows from orders ordered according to oldest to newest, 
	but with the smallest total_amt_usd for each date listed first for each date. */
	
	SELECT * FROM orders ORDER BY occurred_at asc, total_amt_usd asc limit 10
	-- or 
	SELECT * FROM orders ORDER BY occurred_at asc, total_amt_usd asc limit 10

-- WHERE clause
	/* Pull the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd 
	greater than or equal to 1000.*/

	SELECT * from orders WHERE gloss_amt_usd >= 1000 limit 5

	/*Pull the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.*/

	SELECT * from orders WHERE total_amt_usd < 500 limit 10

	/*Filter the accounts table to include the company name, website, and the primary point of contact for 
	Exxon Mobil in the accounts table*/
	SELECT name, website, primary_poc from accounts where name = 'Exxon Mobil'

-- Derived Columns
	/*	
	Columns created in a statement using one of the arithmetic operators. Example: 
	In orders table, we can perform: 
	SELECT gloss_qty + poster_qty from orders
	This will yield a sum of gloss_qty and poster_qty in a new column called Derived column*/

-- arithmetic operators
	/*	Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. 
	Limit the results to the first 10 orders, and include the id and account_id fields.*/
	SELECT id, account_id, standard_amt_usd / standard_qty as unit_price from orders limit 10

	/*Write a query that finds the percentage of revenue that comes from poster paper for each order. 
	You will need to use only the columns that end with _usd. (Try to do this without using the total column). 
	Include the id and account_id fields.*/

	SELECT id, account_id, 
	       poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
	FROM orders	

	-- or 
	SELECT id, account_id, poster_amt_usd/total_amt_usd poster_revenue from orders

-- logical operators
	/*LIKE
	This allows you perform operations similar to using WHERE and =, but for cases when you might not know exactly what you are looking for.

	IN
	This allows you perform operations similar to using WHERE and =, but for more than one condition.

	NOT
	This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain codition.

	AND & BETWEEN
	These allow you to combine operations where all combined conditions must be true.

	OR
	This allow you to combine operations where at least one of the combined conditions must be true.
	*/

	/*All the companies whose names start with 'C'. */
	select name from accounts where name like 'C%'


	/*All companies whose names contain the string 'one' somewhere in the name. */
	SELECT * from accounts where name LIKE '%one%'

	/*	All companies whose names end with 's'.*/
	SELECT * from accounts where name LIKE '%s'

	/*	Use the accounts table to find the account name, primary poc, and sales rep id for Walmart, Target, and Nordstrom. */
	select name, primary_poc, sales_rep_id from accounts where name IN ('Walmart', 'Target', 'Nordstrom')

	/* Use the web_events table to find all information regarding individuals who were contacted via organic or adwords.*/
	select * from web_events where channel IN ('organic', 'adwords')

	/*	All the companies whose names do not start with 'C'.
	*/
	SELECT name from orders where name NOT LIKE 'C%'

	/*All companies whose names do not contain the string 'one' somewhere in the name.
	*/
	SELECT names from orders where name NOT LIKE '%one%'
	
	/*All companies whose names do not end with 's'.
	*/
	SELECT name where name NOT LIKE '%s'

	/*	Write a query that returns all the orders where the standard_qty is over 1000, 
	the poster_qty is 0, and the gloss_qty is 0.
	*/
	select * from orders where standard_qty > 1000 and poster_qty = 0 and gloss_qty = 0

	/*Using the accounts table find all the companies whose names do not start with 'C' and end with 's'.
	*/
	select * from accounts where name not like 'C%' and name not like '%s'

	/*Use the web_events table to find all information regarding individuals who were contacted via organic or adwords and 
	started their account at any point in 2016 sorted from newest to oldest.
	*/
	
	-- BETWEEN and AND
		-- note: BETWEEN is tricky for dates! While BETWEEN is generally inclusive of endpoints, it assumes the time is at 00:00:00 
		-- (i.e. midnight) for dates. This is the reason why we set the right-side endpoint of the period at '2017-01-01'.
	SELECT *
	FROM web_events
	WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
	ORDER BY occurred_at DESC;

	-- OR
	/*	Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. 
	Only include the id field in the resulting table.*/
	select id from orders where gloss_qty > 4000 or poster_qty > 4000

	/*Write a query that returns a list of orders where the standard qty is zero and either the gloss or poster quantity 
	is over 1000.*/
	select * from orders where standard_qty = 0 and (poster_qty > 1000 or gloss_qty > 4000)

	/* good questions
	Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', 
	but it doesn't contain 'eana'.*/
	select name, primary_poc from accounts where name like 'C%' or name like 'W%' and primary_poc like 'ana' or primary_poc like 'Ana'

	-- correct answer
	SELECT *
	FROM accounts
	WHERE (name LIKE 'C%' OR name LIKE 'W%') AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana%');


	-- moving averages
	-- Using a moving average, you can both smooth out the daily volatility and allow you to observe the long term trend.


















