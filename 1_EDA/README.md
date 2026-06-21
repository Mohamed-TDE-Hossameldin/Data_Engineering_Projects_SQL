# Exploratory Data Analysis w/ SQL: Job Market Analysis

![Project 1 Overview](..\Images\1_EDA_Project_Overview.png)

A SQL project analyzing the data engineer job market using real world job posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights**.

## Executive Summary
🔎 **Project Scope:** Built **3 analytical queries** that answer key questions about the data engineer job market.  
🔎 **Data Modeling**: Used **multi-table joins** across fact and dimension tables to extract insights.  
🔎 **Analytics:** Applied **aggregations, filtering, and sorting** to find top skills by demand, salary, and overall values.   
🔎 **Outcomes:** Delivered **actionable insights** on SQL/Python dominance, cloud trends, and salary patterns.  

If you only have a minute, review these:  
1. [Top 10 Demanded Skills Query](01_top_demanded_skills.sql) - demand analysis with multi-table joins
2. [35 Highest-Paying Skills Query](02_top_paying_skills.sql) - salary analysis with aggregations
3. [Top 25 Optimal Skills Query](03_optimal_skills.sql) - combined demand/salary optimization query

## Problem & Context
Job market analysts need to answer questions like:  

- 🔥 **Most in-demand**: Which skills are most in-demand for data engineers?
- 💰 **Highest paid**: Which skills command the highest-salaries?
- 🎯 **Best trade-off**: What is the optimal skillset balancing demand and compensation?

This project analyzes a data warehouse built using a star schema design. The warehouse structure consists of:

![Data Warehouse](../Images/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact` – Central table containing job posting details (job titles, locations, salaries, dates, etc.)
- **Dimension Tables:**
    - `company_dim` - Company information linked to job postings
    - `skills_dim` - Skills catalog with skill names and types
- **Bridge Table**: `skills_job_dim` - Resolves the many-to-many relationship between job postings and skills

By querying across these interconnected tables, extracted insights about skill demand, salary patterns, and optimal skill combinations for data engineering roles.  

## Tech Stack
- ⚙️ **Query Engine:** DuckDB for fast OLAP-style analytical queries
- 📜 **Language:** SQL (ANSI-style with analytical functions)
- 📐 **Data Model:** Star schema with fact + dimension + bridge tables
- 🛠️ **Development:** VS Code for SQL editing + Termnial for DuckDB CLI
- 🌿 **Version Control:** Git/GitHub for versioned SQL scripts
## Analysis Overview

### Query Structure
1. [Top 10 Demanded Skills](01_top_demanded_skills.sql) - Identifies the 10 most in-demand skills for remote data engineer positions
2. [35 Highest-Paying Skills Query](02_top_paying_skills.sql) - Analyzes the 35 highest-paying skills with salary and demand metrics
3. [Top 25 Optimal Skills Query](03_optimal_skills.sql) - Calculates an optimal score using natural log of demand combined with median salary to identify the most valuable skills to learn

### Key Insights
- ⚙️ **Core languages:** SQL and Python each appear in ~29,000 job postings, making them the most demanded skills
- ☁️ **Cloud platforms:** AWS and Azure are critical for modern data engineering roles
- 🏗️ **Infra & tooling:** Kubernetes, Docker, and Terraform are associated with premium salaries
- 📊 **Big data tools:** Apache Spark shows strong demand with competitive compensation

## SQL Skills Demonstrated

### Query Design and Implementation
- **Complex Joins:** Multi table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`.
- **Aggregations:** `COUNT()`, `MEDIAN()`, and `ROUND()` for statistical analysis
- **Filtering:** Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg`)
- **Sorting & Limiting:** `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques
- **Groupings:** `GROUP BY` for categorical analysis by skill
- **Mathematical functions:** `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics:** Derived optimal score combining log-transformed demand with median salary
- **`HAVING` Clause:** Filtering aggregated results (skills with >= 100 postings)
- **`NULL` Handling:** Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)