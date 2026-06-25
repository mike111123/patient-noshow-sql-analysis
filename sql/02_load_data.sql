-- 02_load_data.sql
-- Download dataset from Kaggle:
-- https://www.kaggle.com/datasets/joniarroba/noshowappointments

-- Update the file path before running
COPY appointments (
    patient_id, appointment_id, gender, scheduled_day,
    appointment_day, age, neighbourhood, scholarship,
    hipertension, diabetes, alcoholism, handcap,
    sms_received, no_show
)
FROM '/your/path/to/KaggleV2-May-2016.csv'
DELIMITER ','
CSV HEADER;

-- Verify row count: should return 110527
SELECT COUNT(*) FROM appointments;
