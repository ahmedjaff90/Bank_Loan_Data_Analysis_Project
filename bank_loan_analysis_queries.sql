-- BANK LOAN REPORT | SUMMARY

-- Total Loan Applications
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data;  -- Counts all loan applications in the dataset

-- MTD (Month-to-Date) Loan Applications
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;  -- Counts loan applications issued in December (current month)

-- PMTD (Previous Month-to-Date) Loan Applications
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;  -- Counts loan applications issued in November (previous month)

-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data;  -- Sums up the total loan amounts funded

-- MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;  -- Sums up the total funded amounts for loans issued in December

-- PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;  -- Sums up the total funded amounts for loans issued in November

-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data;  -- Sums up the total amount received from all loans

-- MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;  -- Sums up the total payments received in December

-- PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;  -- Sums up the total payments received in November

-- Average Interest Rate
SELECT AVG(int_rate) * 100 AS Avg_Int_Rate 
FROM bank_loan_data;  -- Calculates the average interest rate across all loans (multiplied by 100 for percentage)

-- MTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS MTD_Avg_Int_Rate 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;  -- Calculates the average interest rate for loans issued in December

-- PMTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS PMTD_Avg_Int_Rate 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;  -- Calculates the average interest rate for loans issued in November

-- Average Debt-to-Income Ratio (DTI)
SELECT AVG(dti) * 100 AS Avg_DTI 
FROM bank_loan_data;  -- Calculates the average DTI ratio (multiplied by 100 for percentage)

-- MTD Average DTI
SELECT AVG(dti) * 100 AS MTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;  -- Calculates the average DTI for loans issued in December

-- PMTD Average DTI
SELECT AVG(dti) * 100 AS PMTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;  -- Calculates the average DTI for loans issued in November


-- GOOD LOAN ISSUED

-- Good Loan Percentage (Fully Paid or Current loans)
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;  -- Calculates the percentage of good loans (either Fully Paid or Current)

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';  -- Counts the number of applications for good loans

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';  -- Sums the total loan amount for good loans

-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';  -- Sums the total payments received for good loans


-- BAD LOAN ISSUED

-- Bad Loan Percentage (Charged Off loans)
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;  -- Calculates the percentage of bad loans (Charged Off)

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';  -- Counts the number of applications for bad loans

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';  -- Sums the total loan amount for bad loans

-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';  -- Sums the total payments received for bad loans


-- LOAN STATUS ANALYSIS

-- Loan Status Overview
SELECT
    loan_status,
    COUNT(id) AS LoanCount,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM
    bank_loan_data
GROUP BY
    loan_status;  -- Summarizes loan details by status (Fully Paid, Current, Charged Off, etc.)

-- MTD Loan Status Overview
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;  -- Summarizes loan status for loans issued in December


-- BANK LOAN REPORT | OVERVIEW

-- Monthly Loan Overview
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);  -- Summarizes loan applications, funded amounts, and payments received by month

-- Loan Overview by State
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;  -- Summarizes loan applications, funded amounts, and payments received by state

-- Loan Overview by Term
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;  -- Summarizes loan applications, funded amounts, and payments received by loan term (e.g., 36 months or 60 months)

-- Loan Overview by Employee Length
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;  -- Summarizes loan applications, funded amounts, and payments received by employee length

-- Loan Overview by Purpose
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;  -- Summarizes loan applications, funded amounts, and payments received by loan purpose

-- Loan Overview by Home Ownership
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;  -- Summarizes loan applications, funded amounts, and payments received by home ownership status (e.g., Own, Rent)
