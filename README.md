# DataAnalytics-Assessment

This repository contains solutions to the SQL Proficiency Assessment, covering data retrieval, aggregation, joins, subqueries, and business logic with SQL.

---

## 📁 Files

- Assessment_Q1.sql: High-Value Customers with Multiple Products
- Assessment_Q2.sql: Transaction Frequency Analysis
- Assessment_Q3.sql: Account Inactivity Alert
- Assessment_Q4.sql: Customer Lifetime Value (CLV) Estimation

---

## 🧠 Per-Question Explanations

### Q1. High-Value Customers with Multiple Products
We identify users with both savings and investment plans that are funded, summing their confirmed deposits (converted from kobo). We join across both tables using owner_id and sort by total deposits.

### Q2. Transaction Frequency Analysis
For each customer, we compute their transaction frequency per month. Categories are derived by evaluating average transactions over the customer's active tenure in months.

### Q3. Account Inactivity Alert
This query finds accounts (savings and investments) that have not seen inflow activity for over a year. We calculate the days since their most recent deposit transaction and filter where it exceeds 365 days.

### Q4. Customer Lifetime Value Estimation
This simplified CLV model is based on average profit per transaction (0.1% of transaction value) and monthly frequency of transactions. We derive tenure from the earliest transaction date to current date.

---

## 🚧 Challenges

- Handling division-by-zero (tenure = 0) in CLV estimation
- Aggregating transaction data across both account types with consistent formats
- Working with monetary values stored in kobo (needed conversion to Naira)
- Building reusable subqueries for frequency and CLV efficiently

---

All solutions are optimized for clarity, efficiency, and SQL best practices.
