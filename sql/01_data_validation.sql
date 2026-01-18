CREATE TABLE raw_transactions (
    TransactionID            VARCHAR(50) PRIMARY KEY,
    AccountID                VARCHAR(50),
    TransactionAmount        DECIMAL(12,2),
    TransactionDate          DATETIME,
    TransactionType          ENUM('Credit', 'Debit'),
    Location                 VARCHAR(100),
    DeviceID                 VARCHAR(50),
    IPAddress                VARCHAR(45),
    MerchantID               VARCHAR(50),
    AccountBalance           DECIMAL(14,2),
    PreviousTransactionDate  DATETIME,
    Channel                  VARCHAR(50),
    CustomerAge              INT,
    CustomerOccupation       VARCHAR(50),
    TransactionDuration      INT,
    LoginAttempts            INT
);

SELECT COUNT(*) FROM raw_transactions;

SELECT
    COUNT(*) AS null_dates
FROM raw_transactions
WHERE TransactionDate IS NULL;

SELECT
    TransactionType,
    COUNT(*)
FROM raw_transactions
GROUP BY TransactionType;

SELECT
    MIN(TransactionDate),
    MAX(TransactionDate)
FROM raw_transactions;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT TransactionID) AS distinct_transactions
FROM raw_transactions;

SELECT
    SUM(TransactionDate IS NULL) AS null_dates,
    SUM(TransactionAmount IS NULL) AS null_amounts,
    SUM(AccountID IS NULL) AS null_accounts
FROM raw_transactions;

SELECT
    MIN(TransactionAmount),
    MAX(TransactionAmount),
    AVG(TransactionAmount)
FROM raw_transactions;
