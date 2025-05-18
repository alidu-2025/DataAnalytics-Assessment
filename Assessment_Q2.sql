-- Assessment_Q2.sql
-- Transaction Frequency Analysis

WITH tx_summary AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        DATE_TRUNC('month', MIN(date_created)) AS start_month,
        DATE_TRUNC('month', MAX(date_created)) AS end_month
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),
monthly_avg AS (
    SELECT 
        owner_id,
        total_transactions,
        GREATEST(
            1, 
            DATE_PART('year', end_month) * 12 + DATE_PART('month', end_month)
            - DATE_PART('year', start_month) * 12 - DATE_PART('month', start_month) + 1
        ) AS active_months
    FROM tx_summary
),
categorized AS (
    SELECT
        CASE
            WHEN (total_transactions::float / active_months) >= 10 THEN 'HighFrequency'
            WHEN (total_transactions::float / active_months) BETWEEN 3 AND 9 THEN 'MediumFrequency'
            ELSE 'LowFrequency'
        END AS frequency_category,
        total_transactions::float / active_months AS avg_tx_per_month
    FROM monthly_avg
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_tx_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category;
