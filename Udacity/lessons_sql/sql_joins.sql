/*Try pulling all the data from the accounts table, and all the data from the orders table.*/
SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

/*Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
*/
SELECT orders.standard_qty, orders.gloss_qty, 
       orders.poster_qty,  accounts.website, 
       accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

/*######################################################*/

/*Provide a table for all web_events associated with account name of Walmart. There should be three columns. 
Be sure to include the primary_poc, time of the event, and the channel for each event. 
Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.*/
SELECT web_events.channel,web_events.ocurred_at, accounts.name, accounts.primary_poc
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
WHERE accounts.name = 'Walmart'

/*Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: 
the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) 
for the order. Your final table should have 3 columns: region name, account 
name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero*/
SELECT r.name region, a.name account, 
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;

/*##########################################*/

/*Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for the Midwest region. Your final table should include three columns: the region name, 
the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT region.name, sales_reps.name AS SalesRepName, accounts.name AS AcountName
FROM sales_reps
JOIN region
ON region.id= sales_reps.region_id
JOIN accounts
ON accounts.sales_rep_id=sales_reps.id
WHERE region.name = 'Midwest'
ORDER BY accounts.name;

/*Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: 
the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT region.name, sales_reps.name AS SalesRepName, accounts.name AS AcountName
FROM sales_reps
JOIN region
ON region.id= sales_reps.region_id
JOIN accounts
ON accounts.sales_rep_id=sales_reps.id
WHERE sales_reps.name LIKE 'S%' AND region.name = 'Midwest'
ORDER BY accounts.name;

/*Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: 
the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT region.name, sales_reps.name AS SalesRepName, accounts.name AS AcountName
FROM sales_reps
JOIN region
ON region.id= sales_reps.region_id
JOIN accounts
ON accounts.sales_rep_id=sales_reps.id
WHERE sales_reps.name LIKE '% K%' AND region.name = 'Midwest'
ORDER BY accounts.name;

/*Provide the name for each region for every order, as well as the account name and the unit price they paid 
(total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. 
Your final table should have 3 columns: region name, account name, and unit price. 
In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).*/
SELECT region.name, accounts.name AS AccountName, orders.total_amt_usd/(orders.total+0.01) unit_rice
FROM region
JOIN sales_reps
ON sales_reps.region_id=region.id
JOIN accounts
ON accounts.sales_rep_id=sales_reps.id
JOIN orders
ON orders.account_id=accounts.id
WHERE orders.standard_qty > 100;        

/*Provide the name for each region for every order, as well as the account name and the unit price 
they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order 
quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, 
account name, and unit price. Sort for the smallest unit price first. In order to avoid a 
division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).*/
SELECT region.name, accounts.name AS AccountName, (orders.total_amt_usd/(orders.total+0.01)) unit_rice
FROM region
JOIN sales_reps
ON sales_reps.region_id=region.id
JOIN accounts
ON accounts.sales_rep_id=sales_reps.id
JOIN orders
ON orders.account_id=accounts.id
WHERE orders.standard_qty > 100 AND orders.poster_qty > 50;

/*Provide the name for each region for every order, as well as the account name and the unit price 
they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order 
quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, 
account name, and unit price. Sort for the largest unit price first. 
In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).*/
SELECT region.name, accounts.name AS AccountName, (orders.total_amt_usd/(orders.total+0.01)) unit_price
FROM region
JOIN sales_reps
ON sales_reps.region_id=region.id
JOIN accounts
ON accounts.sales_rep_id=sales_reps.id
JOIN orders
ON orders.account_id=accounts.id
WHERE orders.standard_qty > 100 AND orders.poster_qty > 50            
ORDER BY unit_price DESC;

/*What are the different channels used by account id 1001? Your final table should have only 2 columns: 
account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.*/
SELECT DISTINCT accounts.name, web_events.channel
FROM accounts
JOIN web_events
ON web_events.account_id=accounts.id
WHERE accounts.id=1001

/*Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.*/
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;