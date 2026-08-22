# 💰 Loan Risk Analysis Dashboard

![Dashboard Preview](dashboard/dashboard_screenshot.png)

<div align="center">

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=for-the-badge&logo=jupyter&logoColor=white)

**An end-to-end analytics project uncovering what actually drives loan approval decisions — from raw, messy data to a live, interactive business dashboard.**

</div>

---

## 🎯 Business Problem

Lenders need to know which applicant characteristics genuinely drive approval decisions, so they can build consistent, risk-aware, and fair lending policies. This project analyzes 5,000 loan applications end-to-end — cleaning, querying, and visualizing the data — to answer one core question:

> **What actually determines whether a loan gets approved — and are there any risk factors currently acting as hidden hard rules rather than weighted signals?**

The analysis uncovers a critical, non-obvious finding: **employment status overrides every other factor**, including credit score and income — a policy-level insight most surface-level analyses would miss.

---

## 🔍 Key Findings

| # | Finding | Business Implication |
|---|---------|----------------------|
| 1 | **Employment status is a near-absolute gate.** Unemployed applicants are rejected ~97% of the time — regardless of credit score or income. | Even a 750+ credit score or high income gives *zero* meaningful lift for unemployed applicants — this behaves like a hard policy rule, not a risk-weighted factor. |
| 2 | **CreditScore has a sharp threshold effect at ~650**, for employed applicants. Approval jumps from ~20% (Fair) to over 70% (Good). | A steep cliff, not a gradual slope — worth flagging for how the current approval model is likely structured. |
| 3 | **Income shows a "floor effect," not a threshold.** Approval rises sharply above ~30k, then plateaus past ~50k. | More income beyond a moderate level doesn't meaningfully improve approval odds. |
| 4 | **Approved applicants borrow a smaller share of their income** — average Loan-to-Income ratio of **0.39** (approved) vs **0.53** (rejected). | Confirms real-world underwriting logic: loan size *relative to* income matters more than loan size alone. |
| 5 | **Age, YearsExperience, Gender, Education, and City showed negligible effect.** | Rules out several intuitive but weak predictors — and confirms no meaningful gender-based disparity in this dataset. |

---

## 🧠 Analytical Approach

This wasn't a single-pass analysis — each finding was **tested, then stress-tested** against confounding factors:

1. Found EmploymentType strongly predicts approval
2. Checked whether it was just a *proxy* for lower credit scores → **it wasn't** (credit scores were nearly identical across employment types)
3. Tested whether a high credit score or high income could *override* unemployed status → **it couldn't**, approval stayed flat (~3%) across every credit and income band
4. Concluded EmploymentType functions as an independent, near-absolute gate — a genuine interaction-effect insight, not just a correlation

This mirrors how a real risk/business analyst would validate a finding before presenting it to stakeholders.

---

## 🛠️ Tech Stack

| Layer | Tools |
|-------|-------|
| **Data Cleaning** | Python, pandas, NumPy (Jupyter Notebook) |
| **Exploratory Analysis** | PostgreSQL (pgAdmin) — commented, business-question-driven SQL queries |
| **Visualization** | Power BI — live DirectQuery connection, DAX calculated columns |
| **Version Control** | Git & GitHub |

---

## 📊 Dashboard Features

- 🔴 **Live DirectQuery connection** to PostgreSQL — dashboard reflects the database in real time, not a static import
- 🎛️ **Interactive slicers** — filter by Employment Type, Gender, and City
- 📈 **DAX-engineered features** — CreditScore bands, Income bands, and readable Approval Status labels built directly in Power BI
- 🍩 **KPI cards + donut chart** for at-a-glance metrics (Total Applicants, Approval Rate, Avg Credit Score)
- 💡 **Insight callout box** surfacing the headline finding directly on the dashboard

---

## 🧹 Data Cleaning Summary

| Step | Action | Why |
|------|--------|-----|
| Missing Income & CreditScore | Filled with **median** | Robust to skew/outliers, unlike mean |
| Missing Education | Filled with **mode** | Categories were well-balanced, so mode-filling introduced no meaningful bias |
| Negative Income/LoanAmount | **Dropped** (31 rows) | Impossible real-world values — no reliable way to "correct" them |
| Duplicates | Checked — **none found** | Confirmed no double-counted applicants |
| Categorical consistency | Verified Gender, City, EmploymentType | Confirmed no spelling/formatting inconsistencies before analysis |

**Result:** 5,000 → **4,969 clean rows**, zero missing values, zero duplicates.

---

## 📁 Repository Structure

```
loan-risk-analysis/
├── README.md
├── data/
│   └── loan_data_raw.csv          # Original, uncleaned dataset
├── notebooks/
│   └── data_cleaning_eda.ipynb    # Python cleaning & initial EDA
├── sql/
│   └── loan_risk_analysis.sql     # Commented, business-question-driven SQL queries
└── dashboard/
    ├── loan_risk_dashboard.pbix   # Power BI dashboard file
    └── dashboard_screenshot.png   # Exported dashboard image
```

---

## 🚀 How to Reproduce

1. **Clone this repository**
   ```bash
   git clone https://github.com/sneha-179/loan-risk-analysis.git
   cd loan-risk-analysis
   ```
2. **Load the raw data** (`data/loan_data_raw.csv`) into a PostgreSQL database
3. **Run the cleaning notebook**: `notebooks/data_cleaning_eda.ipynb`
4. **Run the SQL queries**: `sql/loan_risk_analysis.sql` against the cleaned table
5. **Open the dashboard**: `dashboard/loan_risk_dashboard.pbix` in Power BI Desktop
   - Update the PostgreSQL connection under **Transform Data → Data Source Settings**

---

## 💡 Business Recommendation

The current approval process appears to treat employment status as an automatic disqualifier rather than one input among several. This raises a genuine policy question worth putting in front of stakeholders:

> **Should a strong credit score or high income be allowed to partially offset unemployment status**, rather than employment acting as a hard, non-negotiable filter?

Surfacing this question — not just reporting a correlation — is the core value this analysis adds.

---

## 👤 Author

**Sneha**
B.Tech, Electrical & Electronics Engineering, VNIT Nagpur
[GitHub](https://github.com/sneha-179)

---

<div align="center">

**⭐ If you found this project useful, consider giving it a star!**

</div>
