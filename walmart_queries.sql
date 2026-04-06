-- 📋 View all data
SELECT * FROM walmart;

-- 🧮 Count total records in the dataset
SELECT COUNT(*) FROM walmart;

-- 💳 Count number of transactions for each payment method
SELECT 
    payment_method,
    COUNT(*) AS no_payments
FROM walmart
GROUP BY payment_method;

-- 🏪 Count the number of unique branches
SELECT COUNT(DISTINCT branch) FROM walmart;

-- 📦 Find the minimum quantity sold in any transaction
SELECT MIN(quantity) FROM walmart;

-- 📊 Business Question 1: For each payment method, find number of transactions and total quantity sold
SELECT 
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

-- ⭐ Business Question 2: Identify the highest-rated category in each branch based on average rating
SELECT branch, category, avg_rating
FROM (
    SELECT 
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
    FROM walmart
    GROUP BY branch, category
) AS ranked
WHERE rank = 1;

-- 📅 Business Question 3: Determine the busiest day for each branch based on the number of transactions
SELECT branch, day_name, no_transactions
FROM (
    SELECT 
        branch,
        DAYNAME(STR_TO_DATE(date, '%d/%m/%Y')) AS day_name,
        COUNT(*) AS no_transactions,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
    FROM walmart
    GROUP BY branch, day_name
) AS ranked
WHERE rank = 1;

-- 💰 Business Question 4: Total quantity sold through each payment method
SELECT 
    payment_method,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

-- 🏙️ Business Question 5: Find min, max, and average rating for each category across all cities
SELECT 
    city,
    category,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY city, category;

-- 💸 Business Question 6: Calculate total profit for each product category
-- (Assumes profit = unit_price × quantity × profit_margin)
SELECT 
    category,
    SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart
GROUP BY category
ORDER BY total_profit DESC;

-- 💳 Business Question 7: Find the most commonly used payment method in each branch
WITH cte AS (
    SELECT 
        branch,
        payment_method,
        COUNT(*) AS total_trans,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
    FROM walmart
    GROUP BY branch, payment_method
)
SELECT branch, payment_method AS preferred_payment_method
FROM cte
WHERE rank = 1;

-- 🕒 Business Question 8: Classify sales based on time of day (Morning, Afternoon, Evening)
SELECT
    branch,
    CASE 
        WHEN HOUR(TIME(time)) < 12 THEN 'Morning'
        WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS num_invoices
FROM walmart
GROUP BY branch, shift
ORDER BY branch, num_invoices DESC;

-- 📉 Business Question 9 (Updated): Identify revenue trend changes across years for each branch
-- Calculates yearly revenue per branch and compares it to the previous year
WITH CT1 AS (
    SELECT 
        branch,
        YEAR(date) AS yr,
        ROUND(SUM(1.0 * SUBSTRING(unit_price, 2, LENGTH(unit_price))), 2) AS revenue
    FROM walmart
    GROUP BY 1, 2
),
CT2 AS (
    SELECT *,
        LAG(revenue, 1) OVER(PARTITION BY branch ORDER BY yr) AS pre,
        revenue - LAG(revenue, 1) OVER(PARTITION BY branch ORDER BY yr) AS diff
    FROM CT1
)
SELECT *,
    DENSE_RANK() OVER(PARTITION BY branch ORDER BY diff) AS rnk
FROM CT2
WHERE diff IS NOT NULL;
