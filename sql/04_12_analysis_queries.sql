-- 04_12_analysis_queries.sql
-- All 12 analysis queries for patient no-show root-cause analysis

-- ========================
-- 04: No-show by age group
-- ========================
SELECT
    CASE
        WHEN age BETWEEN 0  AND 17  THEN '0-17'
        WHEN age BETWEEN 18 AND 34  THEN '18-34'
        WHEN age BETWEEN 35 AND 54  THEN '35-54'
        WHEN age BETWEEN 55 AND 74  THEN '55-74'
        ELSE '75+'
    END AS age_group,
    COUNT(*) AS total,
    ROUND(AVG(CASE WHEN no_show = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS noshow_rate_pct
FROM appointments WHERE age >= 0
GROUP BY age_group ORDER BY age_group;

-- ============================
-- 05: No-show by day of week
-- ============================
SELECT
    TO_CHAR(appointment_day, 'Day') AS day_of_week,
    COUNT(*) AS total,
    ROUND(AVG(CASE WHEN no_show = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS noshow_rate_pct
FROM appointments
GROUP BY day_of_week, EXTRACT(DOW FROM appointment_day)
ORDER BY EXTRACT(DOW FROM appointment_day);

-- ============================
-- 06: No-show by lead time
-- ============================
WITH lead_times AS (
    SELECT no_show,
        (appointment_day - scheduled_day::DATE) AS lead_days
    FROM appointments
    WHERE (appointment_day - scheduled_day::DATE) >= 0
)
SELECT
    CASE
        WHEN lead_days = 0               THEN 'Same day'
        WHEN lead_days BETWEEN 1 AND 7   THEN '1-7 days'
        WHEN lead_days BETWEEN 8 AND 14  THEN '8-14 days'
        WHEN lead_days BETWEEN 15 AND 30 THEN '15-30 days'
        ELSE '30+ days'
    END AS lead_time_bucket,
    COUNT(*) AS total,
    ROUND(AVG(CASE WHEN no_show = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS noshow_rate_pct
FROM lead_times
GROUP BY lead_time_bucket
ORDER BY MIN(lead_days);

-- ================================
-- 07: Top 10 no-show neighbourhoods
-- ================================
SELECT
    neighbourhood,
    COUNT(*) AS total,
    ROUND(AVG(CASE WHEN no_show = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS noshow_rate_pct
FROM appointments
GROUP BY neighbourhood
HAVING COUNT(*) >= 100
ORDER BY noshow_rate_pct DESC
LIMIT 10;

-- ============================
-- 08: SMS vs no-show rate
-- ============================
SELECT
    CASE WHEN sms_received = 1 THEN 'SMS Received' ELSE 'No SMS' END AS sms_group,
    COUNT(*) AS total,
    ROUND(AVG(CASE WHEN no_show = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS noshow_rate_pct
FROM appointments
GROUP BY sms_received;

-- ============================================================
-- 09: KEY FINDING - SMS reminders logged AFTER appointments
-- ============================================================
SELECT
    CASE
        WHEN scheduled_day::DATE <= appointment_day THEN 'Reminder before appointment'
        ELSE 'Reminder logged AFTER appointment (data issue)'
    END AS sms_timing,
    COUNT(*) AS count,
    ROUND(AVG(CASE WHEN no_show = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS noshow_rate_pct
FROM appointments
WHERE sms_received = 1
GROUP BY sms_timing;

-- ============================
-- 10: Age x gender cross-tab
-- ============================
SELECT
    CASE
        WHEN age BETWEEN 0  AND 17  THEN '0-17'
        WHEN age BETWEEN 18 AND 34  THEN '18-34'
        WHEN age BETWEEN 35 AND 54  THEN '35-54'
        WHEN age BETWEEN 55 AND 74  THEN '55-74'
        ELSE '75+'
    END AS age_group,
    gender,
    COUNT(*) AS total,
    ROUND(AVG(CASE WHEN no_show = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS noshow_rate_pct
FROM appointments WHERE age >= 0
GROUP BY age_group, gender ORDER BY age_group, gender;

-- ================================
-- 11: No-show by chronic condition
-- ================================
SELECT 'Hypertension' AS condition,
    ROUND(SUM(CASE WHEN hipertension=1 AND no_show='Yes' THEN 1.0 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN hipertension=1 THEN 1.0 ELSE 0 END),0) * 100, 2) AS noshow_rate_pct
FROM appointments
UNION ALL
SELECT 'Diabetes',
    ROUND(SUM(CASE WHEN diabetes=1 AND no_show='Yes' THEN 1.0 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN diabetes=1 THEN 1.0 ELSE 0 END),0) * 100, 2)
FROM appointments
UNION ALL
SELECT 'Alcoholism',
    ROUND(SUM(CASE WHEN alcoholism=1 AND no_show='Yes' THEN 1.0 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN alcoholism=1 THEN 1.0 ELSE 0 END),0) * 100, 2)
FROM appointments;

-- ==========================
-- 12: Summary KPI rollup
-- ==========================
SELECT
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN no_show = 'Yes' THEN 1 ELSE 0 END) AS total_no_shows,
    ROUND(AVG(CASE WHEN no_show = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS overall_noshow_rate_pct,
    ROUND(SUM(CASE WHEN sms_received=1 AND no_show='Yes' THEN 1.0 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN sms_received=1 THEN 1.0 ELSE 0 END),0) * 100, 2) AS sms_noshow_rate_pct,
    ROUND(SUM(CASE WHEN sms_received=0 AND no_show='Yes' THEN 1.0 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN sms_received=0 THEN 1.0 ELSE 0 END),0) * 100, 2) AS no_sms_noshow_rate_pct
FROM appointments;
