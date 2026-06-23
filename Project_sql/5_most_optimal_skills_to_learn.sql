

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(job_postings_fact.job_id) AS skill_demand,
    ROUND(AVG(salary_year_avg),0) AS salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg <> 0 AND
    job_work_from_home = 'true' 
GROUP BY skill_id
HAVING
    skill_demand > 10
ORDER BY 
    salary DESC,
    skill_demand DESC
LIMIT 25;



-- USING CTEs

with demand_skill AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS skill_demand
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg <> 0 AND
        job_work_from_home = 'true' 
    GROUP BY 
        skills_dim.skill_id
), salary AS(
    
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg),0) AS Avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON  job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
    WHERE 
        job_title_short = 'Data Analyst' AND 
        salary_year_avg <> 0 AND
        job_work_from_home = 'true'
    GROUP BY skills_dim.skill_id
)
SELECT
    demand_skill.skill_id,
    demand_skill.skills,
    demand_skill.skill_demand,
    salary.Avg_salary
FROM 
    demand_skill
INNER JOIN salary ON demand_skill.skill_id = salary.skill_id
WHERE
    demand_skill.skill_demand > 10
ORDER BY 
    Avg_salary DESC,
    skill_demand DESC
LIMIT 25;

