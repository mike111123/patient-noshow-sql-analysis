# Patient No-Show Root-Cause Analysis — SQL Project

  **Type:** Independent Portfolio Project  
    **Timeline:** February 2026 – March 2026  
      **Tools:** PostgreSQL, pgAdmin, MS Word  
        **Dataset:** [Kaggle Medical Appointment No-Shows](https://www.kaggle.com/datasets/joniarroba/noshowappointments) — 110,527 rows

                                                           ---

                                                           ## Project Overview

                                                           This project analyzes a real-world public dataset of 110,527 medical appointments in Brazil to identify the root causes of patient no-shows. Using PostgreSQL, I wrote 12 analytical queries to segment no-show rates across patient demographics, scheduling behavior, and geography — then delivered a written findings report with actionable recommendations.

                                                           ---

                                                           ## Key Findings

                                                           | Finding | Detail |
                                                           |---|---|
                                                           | SMS-reminded no-show rate | **27.6%** vs. 16.7% for non-reminded patients |
                                                           | Root cause identified | Reminders were logged **after** appointments, not before — data quality issue |
                                                           | Highest-risk lead time | Appointments scheduled **15+ days in advance** had significantly higher no-show rates |
                                                           | Top 5 no-show neighborhoods | Identified and ranked in findings report |

                                                           ---

                                                           ## Repository Structure

                                                           ```
                                                           patient-noshow-sql-analysis/
                                                           ├── sql/
                                                           │   ├── 01_create_schema.sql
                                                           │   ├── 02_load_data.sql
                                                           │   ├── 03_exploratory_queries.sql
                                                           │   └── 04_12_analysis_queries.sql
                                                           ├── docs/
                                                           │   └── findings_report.md
                                                           └── README.md
                                                           ```

                                                           ---

                                                           ## How to Reproduce

                                                           1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/joniarroba/noshowappointments)
                                                                                                 2. Install PostgreSQL and pgAdmin
                                                                                                 3. Run sql/01_create_schema.sql to create the table
                                                                                                 4. Follow instructions in sql/02_load_data.sql to import the CSV
                                                                                                 5. Run queries in order to reproduce all findings

                                                                                                 ---

                                                                                                 ## Skills Demonstrated

                                                                                                 - SQL: WHERE, GROUP BY, HAVING, CASE, JOIN, CTEs, subqueries
                                                                                                 - Data quality analysis and anomaly detection
                                                                                                 - Business findings documentation
                                                                                                 - Root-cause analysis methodology
