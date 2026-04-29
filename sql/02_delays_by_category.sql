-- =========================================================
-- Q2: How do delays vary by station category?
-- =========================================================
-- Category 1 = top-tier hub (e.g., Berlin Hbf, München Hbf)
-- Category 5 = small local station
-- =========================================================

SELECT
 category,
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
GROUP BY category
ORDER BY category;