-- implementing store procedure for insert or update budget
USE PersonalFinanceTracking;
GO

CREATE OR ALTER PROCEDURE UpsertBudget
    @user_ID INT,
    @category_ID INT,
    @month VARCHAR(7),
    @budget_amount DECIMAL(12,2)
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM Budgets 
        WHERE user_ID = @user_ID AND category_ID = @category_ID AND month = @month
    )
    BEGIN
        UPDATE Budgets
        SET budget_amount = @budget_amount
        WHERE user_ID = @user_ID AND category_ID = @category_ID AND month = @month;
    END
    ELSE
    BEGIN
        INSERT INTO Budgets (user_ID, category_ID, month, budget_amount)
        VALUES (@user_ID, @category_ID, @month, @budget_amount);
    END
END;
GO
-- GetUserMonthlySummary Procedure
CREATE OR ALTER PROCEDURE GetUserMonthlySummary
(
    @user_ID INT,
    @month VARCHAR(7)
)
AS
BEGIN
    SELECT 
        c.category_name,
        b.budget_amount,
        ISNULL(SUM(t.amount), 0) AS total_spent
    FROM Categories c
    LEFT JOIN Budgets b 
        ON c.category_ID = b.category_ID 
        AND b.user_ID = @user_ID 
        AND b.month = @month
    LEFT JOIN Transactions t 
        ON t.category_ID = c.category_ID 
        AND t.account_ID IN (
            SELECT account_ID FROM Accounts WHERE user_ID = @user_ID
        )
        AND FORMAT(t.transaction_date, 'yyyy-MM') = @month
    GROUP BY c.category_name, b.budget_amount
    ORDER BY c.category_name;
END;
GO

-- DeleteUserBudget Procedure
CREATE OR ALTER PROCEDURE DeleteUserBudget
(
    @user_ID INT,
    @category_ID INT,
    @month VARCHAR(7)
)
AS
BEGIN
    DELETE FROM Budgets
    WHERE user_ID = @user_ID AND category_ID = @category_ID AND month = @month;
END;
GO
