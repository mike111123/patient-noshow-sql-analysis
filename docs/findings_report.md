# Findings Report — Patient No-Show Root-Cause Analysis

**Analyst:** Mike Redding
**Dataset:** Kaggle Medical Appointment No-Shows (110,527 rows)
**Date:** March 2026

---

## Executive Summary

Analysis of 110,527 medical appointments identified lead time, patient age, and a critical SMS data quality issue as the primary drivers of no-show behavior. Appointments booked 15+ days in advance are the highest-risk segment and the most actionable target for intervention.

---

## Key Findings

### Finding 1 — Overall No-Show Rate
- **20.2%** of all appointments resulted in a no-show (22,319 of 110,527)
- Highest no-show day: **Saturday** (26.1%)
- Lowest no-show day: **Wednesday** (18.4%)

### Finding 2 — SMS Data Quality Issue
- SMS-reminded patients showed **27.6%** no-show rate vs. **16.7%** for non-reminded
- Root cause: reminders were frequently logged **after** the appointment date
- The SMS field cannot be used reliably for analysis until timestamps are corrected

### Finding 3 — Lead Time is the Strongest Predictor

| Lead Time | No-Show Rate |
|---|---|
| Same day | 4.2% |
| 1-7 days | 15.1% |
| 8-14 days | 24.8% |
| 15-30 days | 31.3% |
| 30+ days | 38.7% |

### Finding 4 — Age Group Breakdown

| Age Group | No-Show Rate |
|---|---|
| 0-17 | 22.1% |
| 18-34 | 26.3% |
| 35-54 | 19.8% |
| 55-74 | 14.2% |
| 75+ | 11.9% |

### Finding 5 — Top 5 No-Show Neighbourhoods

| Rank | Neighbourhood | No-Show Rate |
|---|---|---|
| 1 | SANTOS DUMONT | 34.1% |
| 2 | ANDORINHAS | 32.8% |
| 3 | ILHA DO FRADE | 31.5% |
| 4 | AEROPORTO | 30.9% |
| 5 | ILHAS OCEANICAS DE TRINDADE | 30.2% |

---

## Recommendations

1. **Same-day confirmation calls** for appointments scheduled 15+ days in advance
2. **Fix SMS logging timestamps** before using reminder data for analysis
3. **Prioritize outreach for 18-34 age group** — highest no-show rate with highest volume
4. **Pilot neighborhood-targeted interventions** in the top 5 no-show areas
