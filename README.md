
# Customer Churn Analysis SQL Project

## Project Overview

**Project Title**: Customer Churn Analysis  
**Database**: `customers`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze customer churn data. The project involves investigating customer demographics, behavior patterns, and business questions related to churn. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL while solving real-world problems.

## Objectives

1. **Understand overall churn trends**: Identify how many customers are leaving.
2. **Churn segmentation**: Analyze churn across geography, age, product count, and credit score.
3. **Insight extraction**: Use SQL to derive actionable business insights.
4. **Strategy recommendations**: Based on findings, suggest retention strategies.

## Project Structure

### 1. Data Exploration & Cleaning

- **Data Check**: View raw customer data.
```sql
SELECT * FROM customers;
```

- **Churn Rate Calculation**: Determine the overall churn rate.
```sql
SELECT COUNT(*) AS total_customers,
       SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS exited_customers,
       ROUND(100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM customers;
```

---

### 2. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **What is the churn rate by geography?**
```sql
SELECT Geography,
       COUNT(*) AS total,
       SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY Geography
ORDER BY churn_rate_percent DESC;
```

2. **Does credit score affect churn?**
```sql
SELECT Exited,
       ROUND(AVG(CreditScore), 2) AS avg_credit_score,
       COUNT(*) AS num_customers
FROM customers 
GROUP BY Exited;
```

3. **Which age group is most likely to churn?**
```sql
SELECT 
  CASE
    WHEN Age < 30 THEN 'Under 30'
    WHEN Age BETWEEN 30 AND 40 THEN '30-39'
    WHEN Age BETWEEN 40 AND 49 THEN '40-49'
    ELSE '50+'
  END AS age_group,
  COUNT(*) AS total,
  SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY age_group
ORDER BY churn_rate_percent DESC;
```

4. **What is the churn rate by number of products?**
```sql
SELECT NumOfProducts,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY NumOfProducts
ORDER BY NumOfProducts;
```

---

## Findings

- **Overall Churn**: 20.37% of all customers exited.
- **Geographic Trends**: Germany has the highest churn rate (32.44%), nearly double that of France.
- **Credit Score**: Churned customers have a slightly lower average credit score (645) than retained ones (651).
- **Age Factor**: Churn increases with age. 50+ age group shows the highest churn (~45%).
- **Product Count**: Customers with more than 2 products churn at significantly higher rates.

---

## Reports

- **Churn Summary**: Total customers vs exited customers.
- **Segment Analysis**: Churn rate by geography, age, and number of products.
- **Credit Score Comparison**: Churned vs retained customers.
- **Targeted Suggestions**:
  - Investigate customer experience in Germany.
  - Focus retention efforts on older customers and high-product holders.
  - Consider simplifying product offerings or bundling strategies.

---

## Conclusion

This project serves as a practical guide to SQL-based customer churn analysis. Through data exploration and insightful queries, we identified key churn indicators and risk segments. These findings can help inform business strategy, product development, and customer engagement efforts.

---

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Ensure the `customers` table is available in your SQL environment.
3. **Run the Queries**: Use the SQL queries provided above to perform the analysis.
4. **Explore Further**: Modify or add new queries to investigate other churn factors.
