-- Assessment_Q4.sql
-- Customer Lifetime Value (CLV) Estimation

WITH customer_transactions AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_transaction_value,
        MIN(date_created) AS first_transaction_date
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),
tenure_calc AS (
    SELECT 
        ct.owner_id AS customer_id,
        u.name,
        DATE_PART('year', CURRENT_DATE) * 12 + DATE_PART('month', CURRENT_DATE) -
        (DATE_PART('year', ct.first_transaction_date) * 12 + DATE_PART('month', ct.first_transaction_date)) AS tenure_months,
        ct.total_transactions,
        ct.total_transaction_value
    FROM customer_transactions ct
    JOIN users_customuser u ON u.id = ct.owner_id
),
clv_calc AS (
    SELECT 
        customer_id,
        name,
        tenure_months,
        total_transactions,
        ROUND(
            (total_transactions::float / NULLIF(tenure_months, 0)) * 12 * (total_transaction_value * 0.001 / total_transactions),
            2
        ) AS estimated_clv
    FROM tenure_calc
)
SELECT *
FROM clv_calc
ORDER BY estimated_clv DESC;
