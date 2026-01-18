#High Amount Flag
# RULE: TransactionAmount > 3 × average transaction amount of that account

CREATE VIEW high_amt_flag AS
SELECT
    t.TransactionID,
    t.AccountID,
    t.TransactionDate,
    t.TransactionAmount,
    a.avg_transaction_amount,

    CASE
        WHEN t.TransactionAmount > 3 * a.avg_transaction_amount
        THEN 1
        ELSE 0
    END AS high_amt_flag

FROM transaction_context t
JOIN account_behavior_baseline a
  ON t.AccountID = a.AccountID;

#Number of High Amount Transactions
SELECT
    COUNT(*) AS total_txns,
    SUM(high_amt_flag) AS high_amt_txns
FROM high_amt_flag;

# Accounts with High Amount Transactions
SELECT
    TransactionID,
    AccountID,
    TransactionAmount,
    avg_transaction_amount
FROM high_amt_flag
WHERE high_amt_flag = 1
ORDER BY TransactionAmount desc;

# Rapid Transaction Flag
# RULE: mins_since_last_txn < 5

CREATE VIEW rapid_txn_flag AS
SELECT
    TransactionID,
    AccountID,
    TransactionDate,
    mins_since_last_txn,

    CASE
        WHEN mins_since_last_txn IS NOT NULL
             AND mins_since_last_txn < 5
        THEN 1
        ELSE 0
    END AS rapid_txn_flag

FROM transaction_context;

# Number of Rapid Transactions
SELECT
    COUNT(*) AS total_txns,
    SUM(rapid_txn_flag) AS rapid_txns
FROM rapid_txn_flag;

# Inspected Flagged Cases
SELECT
    TransactionID,
    AccountID,
    mins_since_last_txn
FROM rapid_txn_flag
WHERE rapid_txn_flag = 1
ORDER BY mins_since_last_txn
LIMIT 10;

# Login Attempts Risk Flag
# LoginAttempts ≥ 3

CREATE VIEW login_risk_flag AS
SELECT
    TransactionID,
    AccountID,
    TransactionDate,
    LoginAttempts,

    CASE
        WHEN LoginAttempts >= 3
        THEN 1
        ELSE 0
    END AS login_risk_flag

FROM raw_transactions;

# Distribution of login attempts
SELECT
    LoginAttempts,
    COUNT(*) AS txn_count
FROM raw_transactions
GROUP BY LoginAttempts
ORDER BY LoginAttempts;

#Inspect flagged samples
SELECT
    TransactionID,
    AccountID,
    LoginAttempts
FROM login_risk_flag
WHERE login_risk_flag = 1
order by LoginAttempts desc
LIMIT 10;



# Device Change Flag
# RULE: number of distinct DeviceID > 1

CREATE VIEW device_change_flag AS
SELECT
    AccountID,

    CASE
        WHEN device_count > 1
        THEN 1
        ELSE 0
    END AS device_change_flag

FROM account_behavior_baseline;

#How many accounts use multiple devices?
SELECT
    device_change_flag,
    COUNT(*) AS account_count
FROM device_change_flag
GROUP BY device_change_flag;

# Accounts
SELECT
    AccountID
FROM device_change_flag
WHERE device_change_flag = 1
LIMIT 5;


# Location Change Flag
# RULE: number of distinct Location > 1

CREATE VIEW location_change_flag AS
SELECT
    AccountID,

    CASE
        WHEN location_count > 1
        THEN 1
        ELSE 0
    END AS location_change_flag

FROM account_behavior_baseline;

# Distribution

SELECT
    location_change_flag,
    COUNT(*) AS account_count
FROM location_change_flag
GROUP BY location_change_flag;

SELECT
    AccountID
FROM location_change_flag
WHERE location_change_flag = 1
LIMIT 5;

