/*
- Identify top 10 in-demand skills for data engineers
- Focus on Remote Jobs Only
*/

SELECT
    sd.skills,
    COUNT(sd.skills) AS demand_count
FROM
    job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd 
        ON sjd.job_id = jpf.job_id
    INNER JOIN skills_dim AS sd 
        ON sd.skill_id = sjd.skill_id
WHERE
    jpf.job_work_from_home = TRUE
    AND jpf.job_title_short = 'Data Engineer'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10
;

/*
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
*/