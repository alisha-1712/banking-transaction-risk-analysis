CREATE VIEW transaction_risk_score AS
SELECT
    t.TransactionID,
    t.AccountID,
    t.TransactionDate,
    t.TransactionAmount,
    t.Channel,
    t.Location,

    -- Individual flags (defensive COALESCE)
    COALESCE(ha.high_amt_flag, 0)     AS high_amt_flag,
    COALESCE(rt.rapid_txn_flag, 0)       AS rapid_txn_flag,
    COALESCE(lr.login_risk_flag, 0)      AS login_risk_flag,
    COALESCE(dc.device_change_flag, 0)   AS device_change_flag,
    COALESCE(lc.location_change_flag, 0) AS location_change_flag,

    -- Composite risk score
    (
        COALESCE(ha.high_amt_flag, 0) +
        COALESCE(rt.rapid_txn_flag, 0) +
        COALESCE(lr.login_risk_flag, 0) +
        COALESCE(dc.device_change_flag, 0) +
        COALESCE(lc.location_change_flag, 0)
    ) AS risk_score,

    -- Risk labels
    CASE
        WHEN (
            COALESCE(ha.high_amt_flag, 0) +
            COALESCE(rt.rapid_txn_flag, 0) +
            COALESCE(lr.login_risk_flag, 0) +
            COALESCE(dc.device_change_flag, 0) +
            COALESCE(lc.location_change_flag, 0)
        ) >= 3 THEN 'High Risk'

        WHEN (
            COALESCE(ha.high_amt_flag, 0) +
            COALESCE(rt.rapid_txn_flag, 0) +
            COALESCE(lr.login_risk_flag, 0) +
            COALESCE(dc.device_change_flag, 0) +
            COALESCE(lc.location_change_flag, 0)
        ) = 2 THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_level

FROM transaction_context t
LEFT JOIN high_amt_flag ha
       ON t.TransactionID = ha.TransactionID
LEFT JOIN rapid_txn_flag rt
       ON t.TransactionID = rt.TransactionID
LEFT JOIN login_risk_flag lr
       ON t.TransactionID = lr.TransactionID
LEFT JOIN device_change_flag dc
       ON t.AccountID = dc.AccountID
LEFT JOIN location_change_flag lc
       ON t.AccountID = lc.AccountID;


# Risk Score Distribution
SELECT
    risk_score,
    COUNT(*) AS txn_count
FROM transaction_risk_score
GROUP BY risk_score
ORDER BY risk_score;

# Risk level split
SELECT
    risk_level,
    COUNT(*) AS txn_count
FROM transaction_risk_score
GROUP BY risk_level;


# High Risk Samples
SELECT
    TransactionID,
    AccountID,
    risk_score,
    risk_level
FROM transaction_risk_score
WHERE risk_level = 'High Risk'
LIMIT 10;



