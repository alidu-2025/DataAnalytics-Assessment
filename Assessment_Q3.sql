-- Assessment_Q3.sql
-- Account Inactivity Alert

WITH savings_activity AS (
    SELECT 
        id AS plan_id,
        owner_id,
        'Savings' AS type,
        MAX(date_created) AS last_transaction_date
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY id, owner_id
),
investment_activity AS (
    SELECT 
        id AS plan_id,
        owner_id,
        'Investment' AS type,
        MAX(date_created) AS last_transaction_date
    FROM plans_plan
    WHERE confirmed_amount > 0
    GROUP BY id, owner_id
),
all_accounts AS (
    SELECT * FROM savings_activity
    UNION ALL
    SELECT * FROM investment_activity
)
SELECT 
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATE_PART('day', CURRENT_DATE - last_transaction_date) AS inactivity_days
FROM all_accounts
WHERE last_transaction_date < CURRENT_DATE - INTERVAL '365 days';
