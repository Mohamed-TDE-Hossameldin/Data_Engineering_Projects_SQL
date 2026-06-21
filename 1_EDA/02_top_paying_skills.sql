/*
- What are the highest-paying skills for data engineers?
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), -3) AS median_salary,
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
HAVING
    count(jpf.job_title) > 100
ORDER BY
    median_salary DESC,
    demand_count DESC
LIMIT 35;

/*
┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ terraform  │      184000.0 │         3248 │
│ golang     │      184000.0 │          912 │
│ spring     │      176000.0 │          364 │
│ gdpr       │      170000.0 │          582 │
│ neo4j      │      170000.0 │          277 │
│ graphql    │      168000.0 │          445 │
│ zoom       │      168000.0 │          127 │
│ mongo      │      162000.0 │          265 │
│ fastapi    │      158000.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154000.0 │          129 │
│ c          │      152000.0 │          444 │
│ atlassian  │      152000.0 │          249 │
│ kubernetes │      151000.0 │         4202 │
│ typescript │      151000.0 │          388 │
│ airflow    │      150000.0 │         9996 │
│ ruby       │      150000.0 │          736 │
│ css        │      150000.0 │          262 │
│ node       │      150000.0 │          179 │
│ redis      │      149000.0 │          605 │
│ ansible    │      149000.0 │          475 │
│ vmware     │      149000.0 │          136 │
│ jupyter    │      148000.0 │          400 │
│ visio      │      147000.0 │          105 │
│ kafka      │      145000.0 │         6415 │
│ spark      │      140000.0 │        12799 │
│ pyspark    │      140000.0 │         4898 │
│ git        │      140000.0 │         4641 │
│ pandas     │      140000.0 │         2929 │
│ go         │      140000.0 │         1997 │
│ word       │      140000.0 │          650 │
│ splunk     │      140000.0 │          251 │
│ outlook    │      140000.0 │          199 │
└────────────┴───────────────┴──────────────┘
*/

/*
INSIGHTS & KEY TAKEAWAYS:
========================
1. Premium System & Low-Level Languages:
   - Rust ($210,000) commands a massive financial premium, sitting at the top of the chart despite low demand (232).
   - High-performance, compiled languages like Golang ($184,000) and C ($152,000) also pay exceptionally well. 
   - This indicates that companies are willing to pay top dollar for engineers who can optimize heavy-compute, 
     low-latency infrastructure.

2. Infrastructure-as-Code (IaC) & DevOps Dominance:
   - Terraform ($184,000 with 3,248 listings) and Kubernetes ($151,000 with 4,202 listings) alsot demonstrate a good insight: 
    that modern data engineering heavily overlaps with DevOps. 
   - We can conclude then that managing infrastructure as code and orchestrating containers are premium skills that elevate
     a base data engineer salary.

3. Data Governance & Security Compliance:
   - GDPR compliance ($170,000) appears on the high-pay list. This highlights that data protection, 
     privacy laws, and data governance are business-critical priorities that companies fund aggressively.

SUMMARY:
The highest salaries come from knowing data tools and skills and come from specialized adjacencies. 
Data engineers looking to maximize their earning potential should cross-train in DevOps/IaC (Terraform, Kubernetes), 
real-time data streaming (Kafka), or adopt high-performance programming languages (Rust, Go).
*/