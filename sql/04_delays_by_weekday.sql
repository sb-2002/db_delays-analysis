-- =========================================================
-- Q4: Does delay risk worsen across consecutive weekdays?
-- =========================================================
-- "weekday_name" is the day name extracted from arrival_plan.
-- "On time" is defined as arrival_delay_m <= 5 minutes.
--
-- Caveat: After exploration, we discovered the dataset's stated
-- "one week" coverage actually contains only 3 full days
-- (Mon Jul 8, Tue Jul 9, Wed Jul 10) plus a partial Thursday
-- morning. The original Q4 (full Mon-Sun comparison) was not
-- answerable, so this query is restricted to the 3 full days
-- to compare delay patterns across consecutive weekdays.
-- =========================================================

SELECT
 
 DATE(arrival_plan) AS date,
 weekday_name,
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
WHERE DATE(arrival_plan) IN ('2024-07-08', '2024-07-09', '2024-07-10')
GROUP BY DATE(arrival_plan),weekday_name
ORDER BY MIN(weekday_num);