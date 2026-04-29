-- =========================================================
-- Q1: What percentage of trains arrive on time overall?
-- =========================================================
-- Definition: A train is "on time" if its arrival delay is 5
-- minutes or less (DB's official threshold is "less than 6 min").
-- =========================================================

SELECT
 COUNT(*) AS total_arrivals ,
 COUNT(*) FILTER (WHERE arrival_delay_m <= 5) AS on_time_count,
 COUNT(*) FILTER (WHERE arrival_delay_m > 5) AS delayed_count,
 ROUND(
 100.0 * COUNT(*) FILTER (WHERE arrival_delay_m <= 5) / COUNT(*),
 2
 ) AS on_time_percentage,
 ROUND(AVG(arrival_delay_m)::numeric, 2) AS avg_delay_minutes,
 ROUND(
 (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY arrival_delay_m))::numeric,
 2
 ) AS median_delay_minutes,
 MAX(arrival_delay_m) AS max_delay_minutes
FROM train_delays;