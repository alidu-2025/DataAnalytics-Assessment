-- Assessment_Q1.sql
-- High-Value Customers with Multiple Products

WITH savings AS (
    SELECT owner_id, COUNT(*) AS savings_count, SUM(confirmed_amount) AS total_savings
    FROM savings_savingsaccount
    WHERE is_regular_savings = 1 AND confirmed_amount > 0
    GROUP BY owner_id
),
investments AS (
    SELECT owner_id, COUNT(*) AS investment_count, SUM(confirmed_amount) AS total_investment
    FROM plans_plan
    WHERE is_a_fund = 1 AND confirmed_amount > 0
    GROUP BY owner_id
)
SELECT 
    u.id AS owner_id,
    u.name,
    s.savings_count,
    i.investment_count,
    ROUND((s.total_savings + i.total_investment) / 100.0, 2) AS total_deposits
FROM users_customuser u
JOIN savings s ON u.id = s.owner_id
JOIN investments i ON u.id = i.owner_id
ORDER BY total_deposits DESC;
