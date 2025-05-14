-- creating a new database for personal finance tracking 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -Q "CREATE DATABASE PersonalFinanceTracking"
-- creating table for my new database 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -Q "USE PersonalFinanceTracking;
CREATE TABLE Users (
    user_ID INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    currency VARCHAR(10)
);
CREATE TABLE Categories (
    category_ID INT PRIMARY KEY,
    category_name VARCHAR(100),
    category_type VARCHAR(50)
);
CREATE TABLE Accounts (
    account_ID INT PRIMARY KEY,
    user_ID INT,
    account_name VARCHAR(100),
    account_type VARCHAR(50),
    balance DECIMAL(12, 2),
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);
CREATE TABLE Transactions (
    transaction_ID INT PRIMARY KEY,
    account_ID INT,
    category_ID INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(12, 2),
    description TEXT,
    transaction_date DATE,
    FOREIGN KEY (account_ID) REFERENCES Accounts(account_ID),
    FOREIGN KEY (category_ID) REFERENCES Categories(category_ID)
);
CREATE TABLE Budgets (
    budget_ID INT PRIMARY KEY,
    user_ID INT,
    category_ID INT,
    month VARCHAR(7),
    budget_amount DECIMAL(12, 2),
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (category_ID) REFERENCES Categories(category_ID)
);
CREATE TABLE Goals (
    goal_ID INT PRIMARY KEY,
    user_ID INT,
    goal_name VARCHAR(100),
    target_amount DECIMAL(12, 2),
    target_date DATE,
    current_amount DECIMAL(12, 2),
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);
CREATE TABLE Savings (
    saving_ID INT PRIMARY KEY,
    goal_ID INT,
    account_ID INT,
    amount DECIMAL(12, 2),
    saving_date DATE,
    FOREIGN KEY (goal_ID) REFERENCES Goals(goal_ID),
    FOREIGN KEY (account_ID) REFERENCES Accounts(account_ID)
);
CREATE TABLE Recurring_Transactions (
    recurring_ID INT PRIMARY KEY,
    user_ID INT,
    category_ID INT,
    amount DECIMAL(12, 2),
    frequency VARCHAR(20),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (category_ID) REFERENCES Categories(category_ID)
);"
-- checking if the tables are created sucessfuly in the database 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d Per/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d PersonalFinanceTracking -Q sonalFinanceTracking -Q "SELECT name FROM sys.tables;"

-- lets add sample data to the tables
-- adding sample data to the user table 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d PersonalFinanceTracking -Q "
INSERT INTO Users (user_ID, full_name, email, password_hash, currency)
VALUES 
(1, 'Alice Johnson', 'alice@example.com', 'hashed_pw_1', 'USD'),
(2, 'Bob Smith', 'bob@example.com', 'hashed_pw_2', 'EUR');"
-- adding sample data for the categories table 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d PersonalFinanceTracking -Q "
INSERT INTO Categories (category_ID, category_name, category_type)
VALUES 
(1, 'Groceries', 'Expense'),
(2, 'Salary', 'Income'),
(3, 'Utilities', 'Expense');"
-- adding sample data for accounts table 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d PersonalFinanceTracking -Q "
INSERT INTO Accounts (account_ID, user_ID, account_name, account_type, balance)
VALUES 
(1, 1, 'Checking Account', 'Bank', 1200.00),
(2, 1, 'Savings Account', 'Bank', 3500.00),
(3, 2, 'Cash Wallet', 'Cash', 150.00);"
-- adding sample data for transactions table 
"
INSERT INTO Transactions (transaction_ID, account_ID, category_ID, transaction_type, amount, description, transaction_date)
VALUES 
(1, 1, 1, 'Expense', 100.00, 'Weekly groceries', '2025-05-01'),
(2, 1, 2, 'Income', 3000.00, 'Monthly salary', '2025-05-01'),
(3, 3, 3, 'Expense', 60.00, 'Electric bill', '2025-05-03');"
-- adding sample data for budget table 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d PersonalFinanceTracking -Q "
INSERT INTO Budgets (budget_ID, user_ID, category_ID, month, budget_amount)
VALUES 
(1, 1, 1, '2025-05', 500.00),
(2, 2, 3, '2025-05', 200.00);"
-- adding sample data for goals table 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d PersonalFinanceTracking -Q "
INSERT INTO Goals (goal_ID, user_ID, goal_name, target_amount, target_date, current_amount)
VALUES 
(1, 1, 'Vacation Fund', 2000.00, '2025-12-31', 500.00),
(2, 2, 'Emergency Fund', 5000.00, '2026-06-30', 1000.00);"
-- adding sample data for savings table 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d PersonalFinanceTracking -Q "
INSERT INTO Savings (saving_ID, goal_ID, account_ID, amount, saving_date)
VALUES 
(1, 1, 2, 250.00, '2025-05-02'),
(2, 2, 3, 100.00, '2025-05-04');"
-- adding sample data for Recurring transaction 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d PersonalFinanceTracking -Q "
INSERT INTO Recurring_Transactions (recurring_ID, user_ID, category_ID, amount, frequency, start_date, end_date)
VALUES 
(1, 1, 3, 60.00, 'Monthly', '2025-01-01', '2025-12-01'),
(2, 2, 1, 80.00, 'Weekly', '2025-01-01', '2025-12-31');"


