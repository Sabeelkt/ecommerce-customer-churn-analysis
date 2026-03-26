# E-Commerce Customer Behaviour & Churn Analysis

An end-to-end data analytics project analysing customer behaviour 
and predicting churn for a UK-based online retailer using SQL, 
Python, scikit-learn, and Power BI.

---

## Business Question

*"Which customer segments drive the most revenue — and what 
behaviour predicts churn or repeat purchase?"*

---

## Project Overview

| Detail | Value |
|---|---|
| Dataset | Online Retail II — UCI Machine Learning Repository |
| Records | 1,067,371 transactions |
| Customers | 5,878 unique customers |
| Period | December 2009 to December 2011 |
| Tools | MySQL, Python, Power BI, Excel |

---

## Tools and Technologies

| Tool | Purpose |
|---|---|
| MySQL | Data storage and SQL analysis |
| Python (pandas, numpy) | Data cleaning and feature engineering |
| scikit-learn | Churn prediction ML model |
| Seaborn / matplotlib | EDA and model evaluation charts |
| Power BI | Interactive 3-page dashboard |
| SQLAlchemy | Python to MySQL pipeline |
| Excel | Executive summary report |

---

## Project Architecture
```
Raw CSV (94MB)
     ↓
Python ETL Pipeline
     ↓
MySQL Database (4 tables)
     ↓
SQL Analysis + Python ML Model
     ↓
Power BI Dashboard (3 pages)
     ↓
Excel Executive Summary
```

---

## Key Findings

**Finding 1 — Champions are 34x more valuable than Lost customers**
Champions (22.8% of customers) spend an average of £8,885 each.
Lost customers (23.2%) spend only £259 on average.
Protecting Champions should be the business's top retention priority.

**Finding 2 — 75% of new customers never return after first purchase**
Cohort retention analysis across 25 monthly cohorts shows that 
first-month retention averages just 25%. The business has a 
critical new customer conversion problem.

**Finding 3 — Purchase frequency is the strongest churn predictor**
The ML model identified frequency as the most important feature — 
more important than total spend or average order value. Customers 
with declining purchase frequency should be targeted for retention 
campaigns before their spend drops.

**Finding 4 — 2,094 customers (35.6%) are at high churn risk**
The Logistic Regression model (AUC 0.788) identified 2,094 
customers with churn probability above 70%. Immediate win-back 
campaigns targeting these customers could recover significant revenue.

**Finding 5 — December 2009 cohort retained best**
The earliest customer cohort showed 35% Month-1 retention and 
maintained 20%+ retention through Month 24 — significantly better 
than later cohorts.

---

## Machine Learning Model

| Detail | Value |
|---|---|
| Model | Logistic Regression |
| Features | Frequency, Monetary, AOV, Days Active |
| Train/Test split | 80% / 20% |
| Accuracy | 72.4% |
| Precision | 70.8% |
| Recall | 77.8% |
| AUC-ROC | 0.788 |

Note: Recency was intentionally excluded from features to prevent 
data leakage — churn was defined as recency > 90 days, so including 
recency would make the problem trivially easy.

---

## Dashboard Preview

![Business Overview](reports/dashboard_page1.png)
![Customer Segments](reports/dashboard_page2.png)
![Churn Analysis](reports/dashboard_page3.png)

---

## Project Structure
```
churn_project/
│
├── notebooks/
│   ├── 01_data_loading.ipynb
│   ├── 02_cleaning_and_rfm.ipynb
│   ├── 03_cohort_analysis.ipynb
│   └── 04_churn_model.ipynb
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_verify_tables.sql
│   └── 03_rfm_segmentation.sql
│
├── reports/
│   ├── cohort_retention_heatmap.png
│   ├── churn_distribution.png
│   ├── model_evaluation.png
│   ├── dashboard_page1.png
│   ├── dashboard_page2.png
│   └── dashboard_page3.png
│
├── dashboard/
│   └── customer_churn_dashboard.pbix
│
└── README.md
```

---

## How to Run This Project

**1 — Download the dataset**
```
https://www.kaggle.com/datasets/mashlyn/online-retail-ii-uci
```
Save as `data/online_retail_II.csv`

**2 — Set up MySQL**
```sql
CREATE DATABASE churn_project;
```

**3 — Install Python dependencies**
```bash
pip install pandas numpy sqlalchemy pymysql scikit-learn 
    seaborn matplotlib jupyter
```

**4 — Run notebooks in order**
```
01_data_loading.ipynb
02_cleaning_and_rfm.ipynb
03_cohort_analysis.ipynb
04_churn_model.ipynb
```

**5 — Open Power BI dashboard**
Connect to your local MySQL instance and refresh data.

---

## Data Quality Notes

| Issue | Action taken |
|---|---|
| Null Customer IDs (22.8%) | Removed — anonymous transactions |
| Cancelled orders (1.8%) | Removed — invoices starting with C |
| Negative quantities (2.2%) | Removed — returns |
| Zero unit prices (0.6%) | Removed — test entries |
| Duplicate rows (3.2%) | Removed |
| Retention rate | 73% — 779,425 clean rows |

---

## Business Recommendations

1. **Launch a first-purchase follow-up campaign** targeting the 75% 
   of new customers who never return. A personalised email within 
   30 days of first order could significantly improve Month-1 retention.

2. **Prioritise frequency-based retention triggers** over spend-based 
   ones. When a customer misses their expected purchase window — 
   trigger an automated win-back offer immediately.

3. **Contact the 2,094 high-risk customers** with personalised 
   discounts before they churn. Focus on At Risk segment customers 
   who have historical spend above £1,000 — highest recovery ROI.

---

*Dataset: Online Retail II — UCI Machine Learning Repository*
*Available on Kaggle — free download*


