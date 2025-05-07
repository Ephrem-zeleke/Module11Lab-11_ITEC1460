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
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d PersonalFinanceTracking -Q "SELECT name FROM sys.tables;"

-- lets add sample data to the tables
-- adding sample data to the user table 
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongP@ssw0rd' -d PersonalFinanceTracking -Q "
INSERT INTO Users (user_ID, full_name, email, password_hash, currency)
VALUES 
(1, 'Alice Johnson', 'alice@example.com', 'hashed_pw_1', 'USD'),
(2, 'Bob Smith', 'bob@example.com', 'hashed_pw_2', 'EUR');"
--

