SELECT * FROM loans LIMIT 5;
SELECT COUNT(*) FROM loans;


SELECT 
    "EmploymentType",
    COUNT(*) AS total_applicants,
    SUM("LoanApproved") AS approved_count,
    ROUND(AVG("LoanApproved")::numeric, 3) AS approval_rate
FROM loans
GROUP BY "EmploymentType"
ORDER BY approval_rate DESC;

--average approval rate by employment type
SELECT 
    "LoanApproved",
    ROUND(AVG("CreditScore")::numeric, 1) AS avg_credit_score,
    ROUND(AVG("Income")::numeric, 1) AS avg_income,
    ROUND(AVG("LoanAmount")::numeric, 1) AS avg_loan_amount,
    COUNT(*) AS total
FROM loans
GROUP BY "LoanApproved";

--Loan-to-Income ratio
SELECT 
    "LoanApproved",
    ROUND(AVG("LoanAmount" / "Income")::numeric, 3) AS avg_loan_to_income_ratio
FROM loans
GROUP BY "LoanApproved";

--Combining CreditScore bands with approval rate
SELECT 
    CASE 
        WHEN "CreditScore" < 500 THEN 'Poor (<500)'
        WHEN "CreditScore" BETWEEN 500 AND 649 THEN 'Fair (500-649)'
        WHEN "CreditScore" BETWEEN 650 AND 749 THEN 'Good (650-749)'
        ELSE 'Excellent (750+)'
    END AS credit_band,
    COUNT(*) AS total_applicants,
    ROUND(AVG("LoanApproved")::numeric, 3) AS approval_rate
FROM loans
GROUP BY credit_band
ORDER BY approval_rate DESC;


-- Checks if the credit score effect holds even among employed applicants
SELECT 
    "EmploymentType",
    CASE 
        WHEN "CreditScore" < 500 THEN 'Poor (<500)'
        WHEN "CreditScore" BETWEEN 500 AND 649 THEN 'Fair (500-649)'
        WHEN "CreditScore" BETWEEN 650 AND 749 THEN 'Good (650-749)'
        ELSE 'Excellent (750+)'
    END AS credit_band,
    COUNT(*) AS total_applicants,
    ROUND(AVG("LoanApproved")::numeric, 3) AS approval_rate
FROM loans
WHERE "EmploymentType" != 'Unemployed'
GROUP BY "EmploymentType", credit_band
ORDER BY "EmploymentType", credit_band;


SELECT 
    CASE 
        WHEN "CreditScore" < 500 THEN 'Poor (<500)'
        WHEN "CreditScore" BETWEEN 500 AND 649 THEN 'Fair (500-649)'
        WHEN "CreditScore" BETWEEN 650 AND 749 THEN 'Good (650-749)'
        ELSE 'Excellent (750+)'
    END AS credit_band,
    COUNT(*) AS total_applicants,
    ROUND(AVG("LoanApproved")::numeric, 3) AS approval_rate
FROM loans
WHERE "EmploymentType" = 'Unemployed'
GROUP BY credit_band
ORDER BY credit_band;


-- Buckets Income into ranges to see if approval rate changes by income level
SELECT 
    CASE 
        WHEN "Income" < 30000 THEN 'Low (<30k)'
        WHEN "Income" BETWEEN 30000 AND 49999 THEN 'Lower-Mid (30k-50k)'
        WHEN "Income" BETWEEN 50000 AND 69999 THEN 'Upper-Mid (50k-70k)'
        ELSE 'High (70k+)'
    END AS income_band,
    COUNT(*) AS total_applicants,
    ROUND(AVG("LoanApproved")::numeric, 3) AS approval_rate
FROM loans
GROUP BY income_band
ORDER BY approval_rate DESC;


-- Tests whether high income can overcome unemployed status
SELECT 
    CASE 
        WHEN "Income" < 30000 THEN 'Low (<30k)'
        WHEN "Income" BETWEEN 30000 AND 49999 THEN 'Lower-Mid (30k-50k)'
        WHEN "Income" BETWEEN 50000 AND 69999 THEN 'Upper-Mid (50k-70k)'
        ELSE 'High (70k+)'
    END AS income_band,
    COUNT(*) AS total_applicants,
    ROUND(AVG("LoanApproved")::numeric, 3) AS approval_rate
FROM loans
WHERE "EmploymentType" = 'Unemployed'
GROUP BY income_band
ORDER BY income_band;