# 🏦 Banking Transaction Analysis 

> A complete end-to-end data analysis project on 500 banking transactions using **SQL**, **Python**, and **Power BI**.

---

## 📌 Project Overview

This project analyzes a year-worth of simulated banking data (FY2023) to uncover customer behaviour, account trends, transaction patterns, and business insights. The analysis is structured across three tools — SQL for querying, Python for exploration, and Power BI for visual dashboards.

---

## 📂 Repository Structure

```
banking-transaction-analysis/
│
├── data/
│   └── banking_transactions.csv       # Raw dataset (500 rows, 10 columns)
│
├── sql/
│   └── banking_sql.sql                # 20 SQL queries across 5 sections
│
├── powerbi/
│   └── Banking_analysis.pbix          # Power BI dashboard file
│
├── report/
│   └── Banking_Analysis_Report.docx   # Full written analysis report
│
└── README.md
```

---

## 📊 Dataset

| Field | Type | Description |
|---|---|---|
| TransactionID | String | Unique transaction identifier |
| CustomerID | String | Customer reference (CUST001–CUST050) |
| AccountID | String | Account reference (ACC1001–ACC1050) |
| TransactionDate | Date | Date of transaction |
| TransactionType | String | Credit / Debit |
| Amount | Float | Transaction amount (INR) |
| Balance | Float | Account balance after transaction |
| Month / MonthNum / Year | Mixed | Derived date fields |

**Rows:** 500 &nbsp;|&nbsp; **Customers:** 50 &nbsp;|&nbsp; **Period:** Jan–Dec 2023

---

## 🔍 SQL Analysis (20 Queries)

### Section 1 – Basic Analysis
- Total transactions, credits, debits
- Average and maximum transaction amounts

### Section 2 – Customer Analysis
- Top 10 customers by transaction value
- Most active customers by frequency
- Customer-wise average transaction amount

### Section 3 – Account Analysis
- Top/bottom accounts by balance
- Average balance per account

### Section 4 – Trend Analysis
- Monthly transaction count trend
- Monthly Credit vs Debit comparison
- Running balance using Window Functions

### Section 5 – Advanced Queries
- `RANK()` — Customer ranking by total amount
- `SUM() OVER` — Running total across the year
- `ROW_NUMBER() OVER (PARTITION BY)` — Top customer per month
- Subquery — Accounts above average transaction value
- CTE + `CASE WHEN` — Customer segmentation (Platinum/Gold/Silver/Bronze)

---

## 📈 Key Findings

| Metric | Value |
|---|---|
| Total Transactions | 500 |
| Total Credit Amount | ₹25,47,811.86 |
| Total Debit Amount | ₹13,56,538.85 |
| Net Cash Flow | ₹11,91,273.01 |
| Average Transaction | ₹7,808.70 |
| Peak Month | August (63 txns, ₹5.0L) |
| Lowest Month | April (28 txns, ₹1.65L) |
| Credit:Debit Ratio | 1.72 : 1 |

### Customer Segments
| Segment | Criteria | Count |
|---|---|---|
| 🥇 Platinum | ≥ ₹1,50,000 | 4 (8%) |
| 🥈 Gold | ₹1,00,000 – ₹1,49,999 | 23 (46%) |
| 🥉 Silver | ₹50,000 – ₹99,999 | 20 (40%) |
| Bronze | < ₹50,000 | 3 (6%) |

---

## 🛠️ Tools Used

- **MySQL** — SQL queries, window functions, CTEs
- **Python (Pandas)** — Exploratory data analysis
- **Power BI** — Interactive dashboard with KPI cards, bar/line charts, slicers

---

## 🚀 How to Run

1. **SQL:** Import `banking_transactions.csv` into MySQL, then run `banking_sql.sql`
2. **Power BI:** Open `Banking_analysis.pbix` in Power BI Desktop
3. **Report:** Open `Banking_Analysis_Report.docx` for the full written analysis

---

