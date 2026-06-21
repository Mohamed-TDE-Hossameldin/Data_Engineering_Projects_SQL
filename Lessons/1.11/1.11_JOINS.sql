/*
The recruiter says "I don't like IDs."
Show: job_title, company name
Use an INNER JOIN.
*/
SELECT
    jpf.job_title,
    cd.name,
FROM
    job_postings_fact AS jpf
    INNER JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id
;

/*
Show:
company name
job title
salary
Only for salaries above 150000.
*/

SELECT
    cd.name,
    jpf.job_title,
    jpf.salary_year_avg
FROM
    job_postings_fact AS jpf
    LEFT JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    salary_year_avg > 150_000
;

/*
Find all skills required for a specific job posting.
Suppose:
job_id = 12345
Return:
skills
type
*/

SELECT
    jpf.job_title,
    sd.skills,
    sd.type,
FROM
    job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    lEFT JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
LIMIT 100
;

/*
Find all skills required by Data Engineers.
Display:
job_title
skills
Sort alphabetically.
*/

SELECT
    jpf.job_title,
    sd.skills
FROM
    job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.skill_id
    LEFT JOIN skills_dim AS sd ON sjd.skill_id = sjd.skill_id
WHERE
    jpf.job_title LIKE '%Data Engineer%'
ORDER BY
    job_title ASC
;

/*
List companies hiring Data Scientists.
Show:
company_name
job_title
salary_year_avg
Sort highest salary first.
*/

SELECT
    cd.name AS company_name,
    jpf.job_title,
    jpf.salary_year_avg
FROM
    company_dim AS cd
    LEFT JOIN job_postings_fact AS jpf ON jpf.company_id = cd.company_id
WHERE
    jpf.job_title LIKE '%Data Scientist%'
ORDER BY
    salary_year_avg DESC
;

/*
Find all Python-related postings.
Requirement:
Skills include:
Python
Display:
job_title
company_name
salary_year_avg
*/

SELECT
    jpf.job_title,
    cd.name,
    jpf.salary_year_avg,
FROM
    job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd ON jpf.company_id = cd.company_id
    LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    LEFT JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    sd.skills LIKE '%python%'
;

/*
How many postings mention each skill?
Return:
skill
count
Sort descending.
*/

SELECT
    sd.skills,
    COUNT(jpf.job_title) AS job_count
FROM
    job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
    LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
GROUP BY
    sd.skills
ORDER BY
    job_count DESC
;

/*
For each skill:
Find:
Average salary of postings requiring it.
Return:
skill
avg_salary
num_jobs
Only include skills appearing in more than 50 jobs.
Sort by average salary descending.
*/

SELECT
    sd.skills,
    AVG(jpf.salary_year_avg) AS average_salary,
    COUNT(jpf.job_title) AS num_jobs
FROM
    job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
    LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
GROUP BY
    skills
HAVING
    num_jobs > 50
ORDER BY
    average_salary DESC
;

/*
Management asks: "Which companies are hiring the most Data Engineers?"
Return:
company_name
number_of_jobs
average_salary
Only include companies with:
At least 10 Data Engineer postings.
Sort descending.
*/

SELECT
    cd.name,
    COUNT(jpf.job_title) AS number_of_jobs,
    AVG(jpf.salary_year_avg) AS average_salary
FROM
    company_dim AS cd
    LEFT JOIN job_postings_fact AS jpf ON cd.company_id = jpf.company_id
WHERE
    jpf.job_title LIKE '%Data Engineer%'
GROUP BY
    cd.name
HAVING
    number_of_jobs > 10
ORDER BY
    number_of_jobs DESC
;

/*
Find the most lucrative skills.
For each skill:
Show:
skill name
average salary
max salary
Only include:
At least 30 postings.
Average salary above 140000.
Sort descending.
*/

SELECT
    sd.skills,
    AVG(jpf.salary_year_avg) AS average_salary,
    MAX(jpf.salary_year_avg) AS max_salary
FROM
    job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
    LEFT JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.job_title) > 30
    AND
    average_salary > 140_000
ORDER BY
    average_salary DESC
;

/*
Build a "Top Remote DE Skills" report.
Requirements:
    Jobs must be:
    Data Engineer
    Remote
For each skill:
Return:
    skill
    occurrences
    average salary
Only include skills appearing at least 15 times.
Sort:
    occurrences descending
    average salary descending
*/

SELECT
    sd.skills,
    COUNT(sd.skills) AS occurrences,
    AVG(jpf.salary_year_avg) AS average_salary
FROM
    job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
    LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    jpf.job_title LIKE '%Data Engineer%'
    AND
    jpf.job_location = 'Anywhere'
GROUP BY
    sd.skills
HAVING
    occurrences > 15
ORDER BY
    occurrences DESC,
    average_salary DESC
;