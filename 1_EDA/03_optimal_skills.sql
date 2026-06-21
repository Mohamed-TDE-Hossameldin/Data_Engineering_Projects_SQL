/*
- What are the most optimal skills for data engineers - balancing both demand and salary?
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), -3) AS median_salary,
    ROUND(LN(COUNT(sd.skills)), 1) AS ln_demand_count,
    ROUND((median_salary * ln_demand_count / 1_000_000), 2) AS rank
FROM
    job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON sjd.job_id = jpf.job_id
    INNER JOIN skills_dim AS sd
        ON sd.skill_id = sjd.skill_id
WHERE
    jpf.job_work_from_home = TRUE
    AND jpf.job_title_short = 'Data Engineer'
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING
    count(jpf.job_title) > 100
ORDER BY
    rank DESC
LIMIT 25;

/*
┌────────────┬───────────────┬─────────────────┬────────┐
│   skills   │ median_salary │ ln_demand_count │  rank  │
│  varchar   │    double     │     double      │ double │
├────────────┼───────────────┼─────────────────┼────────┤
│ terraform  │      184000.0 │             5.3 │   0.98 │
│ python     │      135000.0 │             7.0 │   0.95 │
│ aws        │      137000.0 │             6.7 │   0.92 │
│ sql        │      130000.0 │             7.0 │   0.91 │
│ airflow    │      150000.0 │             6.0 │    0.9 │
│ spark      │      140000.0 │             6.2 │   0.87 │
│ snowflake  │      136000.0 │             6.1 │   0.83 │
│ kafka      │      145000.0 │             5.7 │   0.83 │
│ azure      │      128000.0 │             6.2 │   0.79 │
│ java       │      135000.0 │             5.7 │   0.77 │
│ kubernetes │      151000.0 │             5.0 │   0.76 │
│ scala      │      137000.0 │             5.5 │   0.75 │
│ databricks │      133000.0 │             5.6 │   0.74 │
│ git        │      140000.0 │             5.3 │   0.74 │
│ redshift   │      130000.0 │             5.6 │   0.73 │
│ gcp        │      136000.0 │             5.3 │   0.72 │
│ hadoop     │      135000.0 │             5.3 │   0.72 │
│ nosql      │      134000.0 │             5.3 │   0.71 │
│ pyspark    │      140000.0 │             5.0 │    0.7 │
│ docker     │      135000.0 │             5.0 │   0.68 │
│ mongodb    │      136000.0 │             4.9 │   0.67 │
│ r          │      135000.0 │             4.9 │   0.66 │
│ go         │      140000.0 │             4.7 │   0.66 │
│ github     │      135000.0 │             4.8 │   0.65 │
│ bigquery   │      135000.0 │             4.8 │   0.65 │
└────────────┴───────────────┴─────────────────┴────────┘
*/