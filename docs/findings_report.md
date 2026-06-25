# Findings Report — Patient No-Show Root-Cause Analysis

**Analyst:** Mike Redding
**Dataset:** Kaggle Medical Appointment No-Shows (110,527 rows)
**Date:** March 2026

---

## Executive Summary

Analysis of 110,527 medical appointments identified lead time and patient age as the primary drivers of no-show behavior, with a secondary SMS data quality issue surfaced during analysis. Appointments booked 15+ days in advance showed a no-show rate exceeding 32% — nearly 7x higher than same-day bookings — making lead time the strongest and most actionable predictor in the dataset.

---

## Key Findings

### Finding 1 — Overall No-Show Rate
- **20.19%** of all appointments resulted in a no-show (22,319 of 110,527)
- Highest no-show day: **Saturday** (23.08%)
- Lowest no-show day: **Wednesday** (19.69%)

### Finding 2 — Lead Time is the Strongest Predictor

| Lead Time | Total Appts | No-Show Rate |
|---|---|---|
| Same day | 38,563 | 4.65% |
| 1-7 days | 32,185 | 24.15% |
| 8-14 days | 12,025 | 30.47% |
| 15-30 days | 17,371 | 32.59% |
| 30+ days | 10,378 | 33.00% |

Appointments booked 15+ days in advance are **7x more likely** to result in a no-show than same-day bookings.

### Finding 3 — Age Group Breakdown

| Age Group | Total | No-Show Rate |
|---|---|---|
| 0-17 | 27,379 | 21.90% |
| 18-34 | 24,246 | 23.98% |
| 35-54 | 29,972 | 19.85% |
| 55-74 | 22,993 | 15.70% |
| 75+ | 5,936 | 16.02% |

18-34 year olds have the highest no-show rate. Patients 55+ are the most reliable segment.

### Finding 4 — SMS Data Quality Issue

| SMS Group | Total | No-Show Rate |
|---|---|---|
| SMS Received | 35,482 | 27.57% |
| No SMS | 75,045 | 16.70% |

SMS-reminded patients show a counterintuitively higher no-show rate. Investigation revealed all 35,482 SMS records appear logged with a reminder date before the appointment — meaning the SMS field may reflect enrollment status rather than actual reminder delivery. This field cannot be used reliably for predictive modeling without correcting the logging process.

### Finding 5 — Top 5 No-Show Neighbourhoods

| Rank | Neighbourhood | Total | No-Show Rate |
|---|---|---|---|
| 1 | SANTOS DUMONT | 1,276 | 28.92% |
| 2 | SANTA CECILIA | 448 | 27.46% |
| 3 | SANTA CLARA | 506 | 26.48% |
| 4 | ITARARE | 3,514 | 26.27% |
| 5 | JESUS DE NAZARETH | 2,853 | 24.40% |

---

## Recommendations

1. **Same-day confirmation calls** for all appointments scheduled 15+ days in advance — this segment has a 32-33% no-show rate and accounts for 27,749 appointments annually
2. **Fix SMS logging** — audit whether sms_received reflects actual reminder delivery or program enrollment before using it in any predictive model
3. **Target 18-34 age group** with additional outreach — highest no-show rate with the second-highest appointment volume
4. **Pilot neighbourhood-targeted interventions** starting with Santos Dumont and Itararé given their combination of high no-show rate and appointment volume
