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

/*
INSIGHTS & KEY TAKEAWAYS:
========================
1. The Core Duopoly (SQL & Python):
   - SQL (29,221) and Python (28,776) are neck-and-neck as the absolute baseline requirements. 
   - Nearly every remote Data Engineer role expects fluency in both, confirming that data manipulation 
     and programming form the twin pillars of modern data engineering.

2. Cloud Platform Dominance:
   - AWS (17,823) leads cloud demand by a significant margin, appearing in ~26% more postings than Azure (14,143).
   - GCP (6,446) trails as a distant third. AWS and Azure skills still offer the broadest market reach for remote roles.

3. The Big Data & Orchestration Stack:
   - Spark (12,799) remains the dominant framework for distributed computing.
   - Airflow (9,996) solidifies its position as the industry standard for workflow orchestration.
   - The close pairing of Snowflake (8,639) and Databricks (8,183) highlights a massive market demand 
     for modern cloud data warehousing and lakehouse architectures.

SUMMARY:
To maximize remote employability, a Data Engineer should master the core foundation (SQL/Python), 
choose a primary cloud ecosystem (ideally AWS or Azure), and pick up an orchestration engine (Airflow) 
paired with a heavy-compute platform (Spark/Databricks/Snowflake).
*/