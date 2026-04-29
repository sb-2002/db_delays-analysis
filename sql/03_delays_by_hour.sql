-- =========================================================
-- Q3: How do delays vary by hour of day?
-- =========================================================
-- "hour" is the hour of arrival (0 = midnight, 23 = 11 PM),
-- extracted from the arrival_plan timestamp during cleaning.
-- "On time" is defined as arrival_delay_m <= 5 minutes
-- (matches DB's official 6-minute punctuality threshold).
-- =========================================================

SELECT
 hour,
 COUNT(*) AS total_arrivals,
 ROUND(AVG(arrival_delay_m)::numeric, 2) AS avg_delay_min,
 ROUND(
 (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY arrival_delay_m))::numeric,
 2
 ) AS median_delay_min,
 ROUND(
 100.0 * COUNT(*) FILTER (WHERE arrival_delay_m <= 5) / COUNT(*),
 2
 ) AS on_time_pct,
 ROUND(
 100.0 * COUNT(*) FILTER (WHERE arrival_delay_m > 15) / COUNT(*),
 2
 ) AS severely_delayed_pct
FROM train_delays
GROUP BY hour
ORDER BY hour;