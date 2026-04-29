-- =========================================================
-- Q6: Which stations have the worst delays?
-- =========================================================
-- Groups all arrivals by station and ranks by average delay.
-- "On time" is defined as arrival_delay_m <= 5 minutes.
--
-- HAVING COUNT(*) >= 100 filters out very small stations where
-- a handful of bad trains would skew the average. Without this,
-- the "worst stations" list would be dominated by tiny rural
-- stops with 5 trains, not real high-traffic problem hubs.
--
-- LIMIT 20 returns only the 20 worst-performing stations,
-- which is enough for the dashboard top-N visualization.
-- =========================================================

SELECT
    station,
    state,
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
GROUP BY station, state, category
HAVING COUNT(*) >= 100
ORDER BY avg_delay_min DESC
LIMIT 20;