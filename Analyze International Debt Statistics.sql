-- What is the number of distinct countries present in the database?
SELECT 
    COUNT(DISTINCT international_debt.country_name) AS total_distinct_countries
FROM international_debt;

-- What are the distinct debt indicators?
SELECT 
    DISTINCT international_debt.indicator_code AS distinct_debt_indicators
FROM international_debt
ORDER BY distinct_debt_indicators;

-- What is the total amount of debt owed by all the countries present in the table, in millions? 
SELECT 
    ROUND(SUM(international_debt.debt)/1000000, 2) AS total_debt
FROM international_debt; 

-- What country has the highest amount of debt?
SELECT 
    international_debt.country_name, 
    SUM(international_debt.debt) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;

-- What is the average amount of debt across different debt indicators?
SELECT 
    international_debt.indicator_code AS debt_indicator,
    international_debt.indicator_name,
    AVG(international_debt.debt) AS average_debt
FROM international_debt
GROUP BY debt_indicator, indicator_name
ORDER BY average_debt DESC
LIMIT 10;

-- What is the highest amount of principal repayments in the "DT.AMT.DLXF.CD" category?
SELECT 
    international_debt.country_name, 
    international_debt.indicator_name
FROM international_debt
WHERE debt = (SELECT 
                  MAX(debt)
              FROM international_debt
              WHERE indicator_code='DT.AMT.DLXF.CD');