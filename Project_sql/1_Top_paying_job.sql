



SELECT 
    job_id,
    job_title_short,
    company_dim.name AS Company_name,
    salary_year_avg
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id  
WHERE 
    salary_year_avg <> 0 AND
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    company_dim.name IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;