CREATE VIEW transaction_context AS
SELECT
    TransactionID,
    AccountID,
    TransactionAmount,
    TransactionDate,
    TransactionType,
    Location,
    DeviceID,
    IPAddress,
    MerchantID,
    AccountBalance,
    Channel,
    CustomerAge,
    CustomerOccupation,
    TransactionDuration,
    LoginAttempts,

    LAG(TransactionDate) OVER (
        PARTITION BY AccountID
        ORDER BY TransactionDate
    ) AS derived_prev_txn_date,

    TIMESTAMPDIFF(
        MINUTE,
        LAG(TransactionDate) OVER (
            PARTITION BY AccountID
            ORDER BY TransactionDate
        ),
        TransactionDate
    ) AS mins_since_last_txn,

    HOUR(TransactionDate) AS transaction_hour

FROM raw_transactions;


SELECT
    MIN(mins_since_last_txn),
    MAX(mins_since_last_txn)
FROM transaction_context;


SELECT * FROM transaction_context;