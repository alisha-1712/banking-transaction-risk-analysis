# Banking Transaction Risk Analysis

## Project Overview
This project analyzes banking transaction data to identify, quantify, and investigate transaction risk using a rule-based risk scoring framework.  
The final output is a single Power BI dashboard designed for executive monitoring, channel-level diagnostics, and transaction-level investigation.

The project demonstrates an end-to-end analytics workflow using SQL for data preparation and risk logic and Power BI for visualization and interaction.

---

## Business Problem
Banks process large volumes of transactions daily, the majority of which are legitimate.  
However, a subset of transactions may exhibit behavioural or security anomalies that require monitoring and investigation.

This project addresses the following questions:
- How much transaction risk exists overall?
- How is risk distributed across severity levels?
- Which transaction channels contribute most to high-risk activity?
- Which specific transactions should be prioritised for investigation?

---

## Dataset Information
- **Dataset name:** Banking Transactions & Fraud Pattern Analysis Dataset  
- **Source:** Kaggle (synthetic dataset for analytical and ML use cases)  
- **Records:** ~2,500 transactions  
- **Granularity:** Transaction-level  

### Key Fields
- TransactionID, AccountID  
- TransactionAmount, TransactionDate  
- TransactionType (Credit/Debit)  
- Channel (ATM, Branch, Online)  
- Location (U.S. cities)  
- DeviceID, IP Address  
- LoginAttempts, AccountBalance  

The dataset is synthetic and intended for analysis, pattern detection, and risk modeling, not real-world financial reporting.

---

## Tools & Technologies
- **MySQL** – data validation, feature engineering, and risk logic  
- **Power BI** – dashboarding, DAX measures, report-page tooltips  
- **SQL Views** – modular and reusable transformations  
- **GitHub** – version control and documentation  

---

## Analysis Workflow

### 1. Data Validation
- Checked for null values and logical inconsistencies  
- Validated transaction date sequencing at the account level  
- Derived missing temporal fields where required  

### 2. Feature Engineering (SQL)
- Account behaviour baselines  
- Transaction frequency indicators  
- High-amount anomaly flags  
- Login attempt risk flags  
- Device and location change detection  

### 3. Risk Scoring
- Each transaction assigned a composite risk score (0–5)  
- Risk score derived from multiple independent indicators  
- Scores grouped into:
  - Low Risk
  - Medium Risk
  - High Risk  

### 4. Aggregation & Views
- SQL views created to consolidate all risk logic  
- Final analytical view exposed to Power BI for reporting  

---

## Dashboard Design (Power BI)

The solution is implemented as a single non-redundant dashboard with the following components:

### Key KPIs
- Total Transactions  
- High Risk Transactions  
- High Risk Percentage  
- Average Risk Score  

### Core Visuals
- Transaction Distribution by Risk Level  
- Channel Contribution to High Risk Transactions  
- High & Extreme Risk Transaction Table (filtered and conditionally formatted)  

### Interactivity
- Global slicers for Transaction Date, Channel, and Location  
- Report-page tooltips providing:
  - risk context,
  - channel-level risk dynamics,
  - investigation guidance  

---

## Key Insights
- Medium-risk transactions dominate overall volume, indicating widespread moderate behavioural risk rather than isolated extreme events.  
- High-risk transactions represent a small but meaningful share of total activity.  
- Risk contribution varies by transaction channel, highlighting areas for targeted monitoring.  
- Extreme-risk transactions are rare but clearly identifiable for prioritised review.

---

## Business Value
The dashboard enables:
- quick executive-level risk assessment,  
- targeted channel-level diagnostics,  
- efficient identification of transactions requiring investigation.

The approach prioritises explainability, clarity, and operational usability over black-box prediction.

---


