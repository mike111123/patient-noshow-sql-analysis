-- 03_exploratory_queries.sql
-- Initial data profiling and sanity checks

-- Total row count
SELECT COUNT(*) AS total_appointments FROM appointments;

-- Overall no-show rate
SELECT
    no_show,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct
FROM appointments
GROUP BY no_show;

-- Gender breakdown with no-show rate
SELECT
    gender,
    COUNT(*) AS count,
    ROUND(AVG(CASE WHEN no_show = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS noshow_rate_pct
FROM appointments
GROUP BY gender;

-- Age range check (flag negative age outliers)
SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    ROUND(AVG(age), 1) AS avg_age
FROM appointments
WHERE age >= 0;

-- Date range of appointments
SELECT
    MIN(appointment_day) AS earliest,
    MAX(appointment_day) AS latest
FROM appointments;

-- Null and data quality check
SELECT
    COUNT(*) FILTER (WHERE patient_id IS NULL)      AS null_patient_id,
    COUNT(*) FILTER (WHERE appointment_day IS NULL) AS null_appt_day,
    COUNT(*) FILTER (WHERE no_show IS NULL)         AS null_no_show,
    COUNT(*) FILTER (WHERE age < 0)                 AS invalid_age
FROM appointments;
