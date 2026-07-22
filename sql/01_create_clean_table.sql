-- Cyclistic Bike-Share Analysis
-- Step 1: Create the cleaned 2025 trip dataset
--
-- Cleaning rules:
-- 1. Keep only rides from the 2025 calendar year.
-- 2. Exclude rides shorter than 1 minute.
-- 3. Exclude rides lasting 24 hours or longer.
-- 4. Preserve rows with missing station data because they remain
--    useful for rider-type, duration, date, and time analysis.
-- 5. Add calculated fields needed for analysis and Tableau.

CREATE OR REPLACE TABLE
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`
CLUSTER BY
  member_casual,
  rideable_type
AS

SELECT
  ride_id,
  rideable_type,
  started_at,
  ended_at,

  DATE(started_at) AS ride_date,

  TIMESTAMP_DIFF(ended_at, started_at, SECOND)
    AS ride_length_seconds,

  ROUND(
    TIMESTAMP_DIFF(ended_at, started_at, SECOND) / 60.0,
    2
  ) AS ride_length_minutes,

  FORMAT_DATE('%A', DATE(started_at))
    AS day_of_week,

  EXTRACT(DAYOFWEEK FROM started_at)
    AS day_of_week_number,

  FORMAT_DATE('%B', DATE(started_at))
    AS month_name,

  EXTRACT(MONTH FROM started_at)
    AS month_number,

  EXTRACT(HOUR FROM started_at)
    AS start_hour,

  CASE
    WHEN EXTRACT(DAYOFWEEK FROM started_at) IN (1, 7)
      THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,

  start_station_name,
  start_station_id,
  end_station_name,
  end_station_id,
  start_lat,
  start_lng,
  end_lat,
  end_lng,
  member_casual

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_raw`

WHERE
  DATE(started_at) BETWEEN DATE '2025-01-01' AND DATE '2025-12-31'
  AND TIMESTAMP_DIFF(ended_at, started_at, SECOND) >= 60
  AND TIMESTAMP_DIFF(ended_at, started_at, SECOND) < 86400;
