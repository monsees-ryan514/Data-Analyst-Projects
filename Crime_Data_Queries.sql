
-- Gets the total number of each of the top 10 crimes for every month. Ignores 2024 and 2025 because that data is incomplete
SELECT  TO_CHAR(DATE_TRUNC('month', date_report), 'YYYY-MM') AS date_reported, crm_cd_desc AS category, COUNT(*) AS total 
FROM crime_data
WHERE TO_CHAR(DATE_TRUNC('year', date_report), 'YYYY') != '2024' AND TO_CHAR(DATE_TRUNC('year', date_report), 'YYYY') != '2025'
group by DATE_TRUNC('month', date_report), category
HAVING crm_cd_desc IN 
(SELECT crm_cd_desc
FROM crime_data
GROUP BY crm_cd_desc
ORDER BY COUNT(*) DESC
LIMIT 10)
ORDER BY DATE_TRUNC('month', date_report), crm_cd_desc



-- Gets the top 10 crimes that increased the most between 2020 and 2023
WITH count_2020 AS (SELECT crm_cd_desc, TO_CHAR(DATE_TRUNC('year', date_report), 'YYYY') AS year_occ, COUNT(*) AS total
FROM crime_data
WHERE TO_CHAR(DATE_TRUNC('year', date_report), 'YYYY') = '2020' 
GROUP BY crm_cd_desc, TO_CHAR(DATE_TRUNC('year', date_report), 'YYYY')), 

count_2023 AS (SELECT crm_cd_desc,TO_CHAR(DATE_TRUNC('year', date_report), 'YYYY') AS year_occ, COUNT(*) AS total
FROM crime_data
WHERE TO_CHAR(DATE_TRUNC('year', date_report), 'YYYY') = '2023' 
GROUP BY crm_cd_desc, TO_CHAR(DATE_TRUNC('year', date_report), 'YYYY'))

(SELECT c1.crm_cd_desc, c1.year_occ, c1.total as total
FROM count_2020 c1
INNER JOIN count_2023 c2 ON c1.crm_cd_desc = c2.crm_cd_desc
ORDER BY c2.total - c1.total DESC
LIMIT 10)
UNION
(SELECT c2.crm_cd_desc, c2.year_occ, c2.total as total
FROM count_2020 c1
INNER JOIN count_2023 c2 ON c1.crm_cd_desc = c2.crm_cd_desc
ORDER BY c2.total - c1.total DESC
LIMIT 10)
ORDER BY crm_cd_desc


-- Gets the overall crime numbers over time
SELECT  TO_CHAR(DATE_TRUNC('month', date_report), 'YYYY-MM') AS date_reported, COUNT(*) AS total 
FROM crime_data
WHERE TO_CHAR(DATE_TRUNC('year', date_report), 'YYYY') != '2024' AND TO_CHAR(DATE_TRUNC('year', date_report), 'YYYY') != '2025'
group by DATE_TRUNC('month', date_report)
ORDER BY DATE_TRUNC('month', date_report)
















-- Gets the times the top 10 crimes occur
SELECT crm_cd_desc, 
CASE WHEN TO_TIMESTAMP(LPAD(time_occ::text, 4, '0'), 'HH24MI')::time BETWEEN '00:00:00' AND '04:00:00' THEN '00:00-04:00' 
WHEN TO_TIMESTAMP(LPAD(time_occ::text, 4, '0'), 'HH24MI')::time BETWEEN '04:00:01' AND '08:00:00' THEN '04:00-08:00'
WHEN TO_TIMESTAMP(LPAD(time_occ::text, 4, '0'), 'HH24MI')::time BETWEEN '08:00:01' AND '12:00:00' THEN '08:00-12:00'
WHEN TO_TIMESTAMP(LPAD(time_occ::text, 4, '0'), 'HH24MI')::time BETWEEN '12:00:01' AND '16:00:00' THEN '12:00-16:00'
WHEN TO_TIMESTAMP(LPAD(time_occ::text, 4, '0'), 'HH24MI')::time BETWEEN '16:00:01' AND '20:00:00' THEN '16:00-20:00'
WHEN TO_TIMESTAMP(LPAD(time_occ::text, 4, '0'), 'HH24MI')::time BETWEEN '16:00:01' AND '20:00:00' THEN '16:00-20:00'
ELSE '20:00-24:00' END AS category,
COUNT(*) as total
FROM crime_data
WHERE crm_cd_desc IN 
(SELECT crm_cd_desc
FROM crime_data
GROUP BY crm_cd_desc
ORDER BY COUNT(*) DESC
LIMIT 10)
GROUP BY crm_cd_desc, category



-- Gets the days the top 10 crimes occur
WITH crime_days AS (SELECT crm_cd_desc,  TO_CHAR(date_occ, 'Day') AS day_occurred, COUNT(*) AS total 
FROM crime_data
WHERE crm_cd_desc IN 
(SELECT crm_cd_desc
FROM crime_data
GROUP BY crm_cd_desc
ORDER BY COUNT(*) DESC
LIMIT 10)
GROUP BY crm_cd_desc, day_occurred)

SELECT * FROM crime_days
ORDER BY crm_cd_desc, array_position(
    ARRAY['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'],
    TRIM(day_occurred))


-- Gets location of the top 10 crimes
SELECT crm_cd_desc, lat, lon FROM crime_data
WHERE crm_cd_desc IN 
(SELECT crm_cd_desc
FROM crime_data
GROUP BY crm_cd_desc
ORDER BY COUNT(*) DESC
LIMIT 10)


