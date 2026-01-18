# Account "Normal" Behaviour 
CREATE VIEW account_behavior_baseline AS
    SELECT 
        AccountID,
        COUNT(*) AS total_transactions,
        AVG(TransactionAmount) AS avg_transaction_amount,
        MAX(TransactionAmount) AS max_transaction_amount,
        COUNT(DISTINCT DeviceID) AS device_count,
        COUNT(DISTINCT Location) AS location_count,
        COUNT(DISTINCT MerchantID) AS merchant_count,
        AVG(LoginAttempts) AS avg_login_attempts
    FROM
        raw_transactions
    GROUP BY AccountID;
    
    
    select * from account_behavior_baseline ;
