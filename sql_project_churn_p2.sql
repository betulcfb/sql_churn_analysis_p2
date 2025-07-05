--Checking my data
SELECT * FROM customers ;


--Obj 1: What is the overall churn rate? 
--Understand how many customers exited the bank.


SELECT COUNT(*) AS total_customers,
SUM(CASE WHEN  Exited =1 THEN 1 ELSE 0 END) AS exited_cutomers,
ROUND(100.0 * SUM(CASE WHEN  Exited =1 THEN 1 ELSE 0 END) /COUNT(*),2 ) AS churn_rate_percent
FROM customers;
--an overall churn rate of 20.37% mean that every 5 cutomers 1 is leaving 


-- Obj 2: Is churn rate higher in specific countries (Geography)? 
--Compare churn by country to see if any location has higher exit trends.

SELECT Geography,
COUNT(*) AS total,
SUM(CASE WHEN  Exited =1 THEN 1 ELSE 0 END) AS churned,
ROUND(100.0 * SUM(CASE WHEN  Exited =1 THEN 1 ELSE 0 END) /COUNT(*),2 ) AS churn_rate_percent
FROM customers
GROUP BY Geography
ORDER BY churn_rate_percent DESC;
--Germany has the highest churn rate at 32.44%,nearly double Spain and France
--Despite France having the largest customer base,it's churn rate is the lowest.
--Focus on investigating why Germany has a higher churn rate.
--Conduct a targeted customer satisfaction surveys or interviews.
--Consider creating a retention campaign or personalized offers. 


-- Obj 3: Does credit score affect customer churn?
--Assess the average credit score for churned vs retained customers.
SELECT exited,
ROUND(AVG(creditscore),2) AS avg_credit_score,
COUNT(*) AS num_customers
FROM customers 
GROUP BY exited;

--Customers who churned have a slightly lower average credit score(645) compared to those stayed(651)
--Suggest that credit score alone may not be a good predictor of churn. 

--Obj 4: Which age group is most likely to churn?
--- Identify if certain age brackets are more at risk.

SELECT 
CASE
WHEN age < 30 THEN 'Under 30'
WHEN age BETWEEN 30 AND 40 THEN '30-39'
WHEN age BETWEEN 40 AND 49 THEN '40-49'
ELSE '50+'
END AS age_group,
COUNT(*) AS total,
SUM(CASE WHEN  Exited =1 THEN 1 ELSE 0 END) AS churned,
ROUND(100.0 * SUM(CASE WHEN  Exited =1 THEN 1 ELSE 0 END) /COUNT(*),2 ) AS churn_rate_percent
FROM customers
GROUP BY age_group
ORDER BY churn_rate_percent DESC;

--churn increases with age
--Older customers(50+) churn the most nearly half are leaving(45%)
--tailored communications
--personalized financial products 


-- Obj 5: Is there a relationship between number of products and churn?
 --See if customers with more products are more or less likely to exit.

SELECT numofproducts,
COUNT(*) AS total_customers,
SUM(CASE WHEN  Exited =1 THEN 1 ELSE 0 END) AS churned_customers,
ROUND(100.0 * SUM(CASE WHEN  Exited =1 THEN 1 ELSE 0 END) /COUNT(*),2 ) AS churn_rate_percent
FROM customers
GROUP BY numofproducts
ORDER BY numofproducts;

--Churn rate increases dramatically with the numbers of products
--Customers with one product shows moderate churn rate 27%
--cutomers with 3&4 products have a extremely higher churn rate
--investigate customers with more than 3 products
--focusing how to retain customers with 2 products
--possibilty restructure our product or personalize it to help in churn reduction.