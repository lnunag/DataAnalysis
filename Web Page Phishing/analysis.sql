-- Data imported through Google Cloud Big Query
-- Trying to import data through MySQL Workbench was going impossibly slow, table creation in BQ took 2 seconds.

-- Join of the original two separate datasets, created unique_id for composite key

SELECT  
  w.unique_id,
  w.url_length,
  w.n_redirection,
  w.phishing,
  p.n_dots,
  p.n_hypens,
  p.n_underline,
  p.n_slash,
  p.n_questionmark,
  p.n_equal,
  p.n_at,
  p.n_and,
  p.n_exclamation,
  p.n_space,
  p.n_tilde,
  p.n_comma,
  p.n_plus,
  p.n_asterisk,
  p.n_hastag,
  p.n_dollar,
  p.n_percent

FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id;

-- Query count of all characters in only phishing links, sort by largest

SELECT 'Hyphens' AS character_type, SUM(p.n_hypens) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Asterisks' AS character_type, SUM(p.n_asterisk) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'At' AS character_type, SUM(p.n_at) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Commas' AS character_type, SUM(p.n_comma) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Dollars' AS character_type, SUM(p.n_dollar) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Equals' AS character_type, SUM(p.n_equal) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Exclamations' AS character_type, SUM(p.n_exclamation) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Hastags' AS character_type, SUM(p.n_hastag) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Percents' AS character_type, SUM(p.n_percent) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Pluses' AS character_type, SUM(p.n_plus) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Questionmarks' AS character_type, SUM(p.n_questionmark) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Slashes' AS character_type, SUM(p.n_slash) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Spaces' AS character_type, SUM(p.n_space) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT 'Tildes' AS character_type, SUM(p.n_tilde) AS total_count
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

ORDER BY total_count DESC;

-- Average number of slashes in phishing vs legitimate URLs

SELECT
  'Phishing' AS url_type, AVG(p.n_slash) AS avg_slash
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT
  'Legitimate' AS url_type, AVG(p.n_slash) AS avg_slash
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 0;

-- How many phishing URLs contain at least one of a specific character compared to legitimate URLs?

SELECT
  'Legitimate' AS url_type,
  SUM(CASE WHEN p.n_slash > 0 THEN 1 ELSE 0 END)/COUNT(*) * 100 AS percentage_slash
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 0

UNION ALL

SELECT
  'Phishing' AS url_type,
  SUM(CASE WHEN p.n_slash > 0 THEN 1 ELSE 0 END)/COUNT(*) * 100 AS percentage_slash
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1;


-- Average length of URLs in phishing vs legitimate websites

SELECT
  'Phishing' AS url_type, AVG(w.url_length) AS avg_len
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 1

UNION ALL

SELECT
  'Legitimate' AS url_type, AVG(w.url_length) AS avg_len
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
WHERE w.phishing = 0;

-- Special Character Count Distribution for Phishing vs Legitimate

SELECT
  SUM(
    p.n_dots + 
    p.n_hypens + 
    p.n_underline + 
    p.n_slash + 
    p.n_questionmark + 
    p.n_equal + 
    p.n_at + 
    p.n_and + 
    p.n_exclamation + 
    p.n_space + 
    p.n_tilde + 
    p.n_comma + 
    p.n_plus + 
    p.n_asterisk + 
    p.n_hastag + 
    p.n_dollar + 
    p.n_percent
  ) AS total_special_chars,
  phishing
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
GROUP BY phishing;

-- Number of redirections?

SELECT
  SUM(
    w.n_redirection
  ) AS total_redirections,
  phishing
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
GROUP BY phishing;

-- How many special characters in each URL?

SELECT
  AVG(
    p.n_dots + 
    p.n_hypens + 
    p.n_underline + 
    p.n_slash + 
    p.n_questionmark + 
    p.n_equal + 
    p.n_at + 
    p.n_and + 
    p.n_exclamation + 
    p.n_space + 
    p.n_tilde + 
    p.n_comma + 
    p.n_plus + 
    p.n_asterisk + 
    p.n_hastag + 
    p.n_dollar + 
    p.n_percent
  ) AS avg_special_chars,
  phishing
FROM `portfolio-projects-394614.wpp.web_page_fishing` w
JOIN `portfolio-projects-394614.wpp.phishing_dataset` p
ON w.unique_id = p.unique_id
GROUP BY phishing;