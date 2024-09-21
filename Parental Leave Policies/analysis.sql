-- DATA CLEANUP
CREATE OR REPLACE TABLE `portfolio-projects-394614.plp.parental_leave_policies_cleaned` AS
SELECT
  Company, Industry, Paid_Maternity_Leave,
  SAFE_CAST(NULLIF(Unpaid_Maternity_Leave, 'N/A') AS FLOAT64) AS Unpaid_Maternity_Leave,
  SAFE_CAST(NULLIF(Paid_Paternity_Leave, 'N/A') AS FLOAT64) AS Paid_Paternity_Leave,
  SAFE_CAST(NULLIF(Unpaid_Paternity_Leave, 'N/A') AS FLOAT64) AS Unpaid_Paternity_Leave
FROM
  `portfolio-projects-394614.plp.parental_leave_policies`;

DROP TABLE `portfolio-projects-394614.plp.parental_leave_policies`;

-- Which companies offer the most paid parental leave weeks?
SELECT 
  Company, 
  (Paid_Maternity_Leave + Paid_Paternity_Leave) AS Total_Paid_Parental_Leave
FROM 
  `portfolio-projects-394614.plp.parental_leave_policies_cleaned`
ORDER BY Total_Paid_Parental_Leave DESC
LIMIT 5;

-- Is maternity leave typically longer than paternity leave?
SELECT
  AVG(Paid_Maternity_Leave) AS Avg_Paid_Maternity_Leave,
  AVG(Paid_Paternity_Leave) AS Avg_Paid_Paternity_Leave
FROM
  `portfolio-projects-394614.plp.parental_leave_policies_cleaned`;

-- What is the distribution of parental leave weeks offered?
## By company for maternal:
SELECT 
  Company,
  Paid_Maternity_Leave,
  Unpaid_Maternity_Leave
FROM
  `portfolio-projects-394614.plp.parental_leave_policies_cleaned`
## WHERE Company = '10up'
ORDER BY Company ASC;

-- Are there noticable differences between industries?
SELECT
  industry,
  AVG((Paid_Maternity_Leave + Paid_Paternity_Leave)) AS avg_total_paid_parental_leave
FROM
  `portfolio-projects-394614.plp.parental_leave_policies_cleaned`
GROUP BY
  industry
ORDER BY
  AVG((Paid_Maternity_Leave + Paid_Paternity_Leave)) DESC;

## Alternative:
/*SELECT
  Industry,
  Company,
  (Paid_Maternity_Leave + Paid_Paternity_Leave) AS Total_Paid_Parental_Leave
FROM
  `portfolio-projects-394614.plp.parental_leave_policies_cleaned`
WHERE (Paid_Maternity_Leave + Paid_Paternity_Leave) IS NOT NULL
ORDER BY (Paid_Maternity_Leave + Paid_Paternity_Leave) DESC;*/
