-- =========================================================
-- Q5: Do longer routes accumulate more delay than shorter ones?
-- =========================================================
-- "path" is a pipe-separated list of upcoming stops for each train.
-- We use it as a proxy for route length: more stops = longer route.
-- Routes are bucketed into Short / Medium / Long for clear comparison.
--
-- We exclude rows with NULL path (about 10% of the data — likely
-- terminal stops where there's nothing further on the route).
-- =========================================================

WITH route_with_length AS (
    SELECT
        arrival_delay_m,
        (LENGTH(path) - LENGTH(REPLACE(path, '|', '')) + 1) AS stop_count
    FROM train_delays
    WHERE path IS NOT NULL
)
SELECT
    CASE
        WHEN stop_count <= 3 THEN '1. Short (1-3 stops)'
        WHEN stop_count <= 8 THEN '2. Medium (4-8 stops)'
        WHEN stop_count <= 15 THEN '3. Long (9-15 stops)'
        ELSE '4. Very long (16+ stops)'
    END AS route_length_bucket,
    COUNT(*) AS total_arrivals,
    ROUND(AVG(stop_count)::numeric, 1) AS avg_stops_in_bucket,
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
FROM route_with_length
GROUP BY route_length_bucket
ORDER BY route_length_bucket;