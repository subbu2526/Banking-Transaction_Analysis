-- ─────────────────────────────────────────────────────────────
--  SECTION 1: BASIC ANALYSIS
-- ─────────────────────────────────────────────────────────────

-- Q1. Total Number of Transactions
SELECT COUNT(*) AS TotalTransactions
FROM transactions;

-- Q2. Total Credit Amount
SELECT ROUND(SUM(Amount), 2) AS TotalCreditAmount
FROM transactions
WHERE transaction_type = 'Credit';

-- Q3. Total Debit Amount
SELECT ROUND(SUM(Amount), 2) AS TotalDebitAmount
FROM transactions
WHERE transaction_type = 'Debit';

-- Q4. Average Transaction Amount
SELECT ROUND(AVG(Amount), 2) AS AvgTransactionAmount
FROM transactions;

-- Q5. Highest Transaction Amount
SELECT MAX(Amount) AS HighestTransactionAmount
FROM transactions;

-- ─────────────────────────────────────────────────────────────
--  SECTION 2: CUSTOMER ANALYSIS
-- ─────────────────────────────────────────────────────────────

-- Q6. Top 10 Customers by Transaction Value
SELECT customer_id,
       ROUND(SUM(Amount), 2) AS TotalTransactionValue
FROM transactions
GROUP BY customer_id
ORDER BY TotalTransactionValue DESC
LIMIT 10;

-- Q7. Most Active Customers (by transaction count)
SELECT customer_id,
       COUNT(*) AS TransactionCount
FROM transactions
GROUP BY customer_id
ORDER BY TransactionCount DESC
LIMIT 10;

-- Q8. Customer Transaction Frequency
SELECT customer_id,
       COUNT(*) AS Frequency
FROM transactions
GROUP BY customer_id
ORDER BY Frequency DESC;

-- Q9. Customer-wise Average Transaction Amount
SELECT customer_id,
       ROUND(AVG(Amount), 2) AS AvgTransactionAmount
FROM transactions
GROUP BY customer_id
ORDER BY AvgTransactionAmount DESC;

-- ─────────────────────────────────────────────────────────────
--  SECTION 3: ACCOUNT ANALYSIS
-- ─────────────────────────────────────────────────────────────

-- Q10. Top Accounts by Balance
SELECT account_id,
       MAX(Balance) AS MaxBalance
FROM transactions
GROUP BY account_id
ORDER BY MaxBalance DESC
LIMIT 10;

-- Q11. Lowest Balance Accounts
SELECT account_id,
       MIN(Balance) AS MinBalance
FROM transactions
GROUP BY account_id
ORDER BY MinBalance ASC
LIMIT 10;

-- Q12. Average Balance per Account
SELECT account_id,
       ROUND(AVG(Balance), 2) AS AvgBalance
FROM transactions
GROUP BY account_id
ORDER BY AvgBalance DESC;

-- ─────────────────────────────────────────────────────────────
--  SECTION 4: TREND ANALYSIS
-- ─────────────────────────────────────────────────────────────

-- Q13. Monthly Transaction Trend
SELECT monthname(transaction_date) AS Month,
	   month(transaction_date) AS MonthNum,
       COUNT(*) AS TransactionCount
FROM transactions
GROUP BY Month(transaction_date),
monthname(transaction_date)
ORDER BY month(transaction_date);

-- Q14. Monthly Credit vs Debit Trend
SELECT MONTH(transaction_date) AS MonthNum,
    MONTHNAME(transaction_date) AS Month,
    transaction_type,
    ROUND(SUM(amount),2) AS TotalAmount
FROM transactions
GROUP BY
    MONTH(transaction_date),
    MONTHNAME(transaction_date),
    transaction_type
ORDER BY MONTH(transaction_date);

-- Q15. Running Balance Trend (Window Function)
SELECT transaction_id,
       customer_id,
       transaction_date,
       amount,
       balance,
       SUM(Amount) OVER (
           PARTITION BY customer_id
           ORDER BY transaction_date, transaction_id
       ) AS RunningTotal
FROM transactions
ORDER BY customer_id, transaction_date;

-- ─────────────────────────────────────────────────────────────
--  SECTION 5: ADVANCED QUERIES
-- ─────────────────────────────────────────────────────────────

-- Q16. Rank Customers by Total Transaction Amount (RANK)
SELECT customer_id,
       ROUND(SUM(Amount), 2) AS TotalAmount,
       RANK() OVER (ORDER BY SUM(Amount) DESC) AS CustomerRank
FROM transactions
GROUP BY customer_id;

-- Q17. Running Transaction Total (SUM OVER)
SELECT transaction_id,
       transaction_date,
       amount,
       SUM(Amount) OVER (
           ORDER BY transaction_date, transaction_id
       ) AS RunningTotal
FROM transactions
ORDER BY transaction_date;

-- Q18. Top Customer in Each Month (ROW_NUMBER)
SELECT *
FROM (
    SELECT
        MONTH(transaction_date) AS MonthNum,
        MONTHNAME(transaction_date) AS Month,
        customer_id,
        ROUND(SUM(amount),2) AS MonthlyTotal,
        ROW_NUMBER() OVER (
            PARTITION BY MONTH(transaction_date)
            ORDER BY SUM(amount) DESC
        ) AS rn
    FROM transactions
    GROUP BY
        MONTH(transaction_date),
        MONTHNAME(transaction_date),
        customer_id
) ranked
WHERE rn = 1
ORDER BY MonthNum;

-- Q19. Accounts Above Average Transaction Value (Subquery)
SELECT account_id,
       ROUND(AVG(Amount), 2) AS AvgTransactionValue
FROM transactions
GROUP BY account_id
HAVING AVG(Amount) > (
    SELECT AVG(Amount) FROM transactions
);

-- Q20. Customer Segmentation using CTE
WITH customer_totals AS (
    SELECT
        customer_id,
        ROUND(SUM(amount), 2) AS TotalAmount,
        COUNT(*) AS TransactionCount
    FROM transactions
    GROUP BY customer_id
)

SELECT
    customer_id,
    TotalAmount,
    TransactionCount,
    CASE
        WHEN TotalAmount >= 150000 THEN 'Platinum'
        WHEN TotalAmount >= 100000 THEN 'Gold'
        WHEN TotalAmount >= 50000 THEN 'Silver'
        ELSE 'Bronze'
    END AS CustomerSegment
FROM customer_totals
ORDER BY TotalAmount DESC;


