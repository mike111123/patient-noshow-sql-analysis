-- 01_create_schema.sql
-- Patient No-Show Analysis -- Table Definition

DROP TABLE IF EXISTS appointments;

CREATE TABLE appointments (
    patient_id          BIGINT,
    appointment_id      BIGINT PRIMARY KEY,
    gender              VARCHAR(1),
    scheduled_day       TIMESTAMP,
    appointment_day     DATE,
    age                 INT,
    neighbourhood       VARCHAR(100),
    scholarship         SMALLINT,
    hipertension        SMALLINT,
    diabetes            SMALLINT,
    alcoholism          SMALLINT,
    handcap             SMALLINT,
    sms_received        SMALLINT,
    no_show             VARCHAR(3)
);

SELECT COUNT(*) FROM appointments;
