-- two views
--Summarize important business metrics such as total income, total expenses, and net savings for each user by month.
USE PersonalFinanceTracking;
GO

CREATE OR ALTER VIEW UserMonthlySummaryView AS
SELECT 
    u.user_ID,
    u.full_name,
    FORMAT(t.transaction_date, 'yyyy-MM') AS month,
    SUM(CASE WHEN t.transaction_type = 'Income' THEN t.amount ELSE 0 END) AS total_income,
    SUM(CASE WHEN t.transaction_type = 'Expense' THEN t.amount ELSE 0 END) AS total_expenses,
    SUM(CASE WHEN t.transaction_type = 'Income' THEN t.amount ELSE -t.amount END) AS net_savings
FROM Users u
JOIN Accounts a ON u.user_ID = a.user_ID
JOIN Transactions t ON a.account_ID = t.account_ID
GROUP BY u.user_ID, u.full_name, FORMAT(t.transaction_date, 'yyyy-MM');
GO

--Provides a detailed joined view of transactions with associated account, category, and user info.
CREATE OR ALTER VIEW TransactionDetailsView AS
SELECT
    t.transaction_ID,
    u.full_name,
    u.email,
    a.account_name,
    c.category_name,
    c.category_type,
    t.transaction_type,
    t.amount,
    t.description,
    t.transaction_date
FROM Transactions t
JOIN Accounts a ON t.account_ID = a.account_ID
JOIN Users u ON a.user_ID = u.user_ID
JOIN Categories c ON t.category_ID = c.category_ID;
GO



