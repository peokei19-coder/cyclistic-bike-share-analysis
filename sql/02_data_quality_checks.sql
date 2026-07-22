-- Cyclistic Bike-Share Analysis
-- Step 2: Data-quality and validation checks
--
-- These queries verify row counts, uniqueness, missing values,
-- rider categories, date coverage, and ride-duration limits.

/* ---------------------------------------------------------
   1. Confirm raw row count and unique ride IDs
--------------------------------------------------------- */

SELECT
  COUNT(*) AS total_raw_rows,
  COUNT(DISTINCT ride_id) AS unique_ride_ids
FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_raw`;


/* ---------------------------------------------------------
   2. Check for duplicate ride IDs
--------------------------------------------------------- */

SELECT
  ride_id,
  COUNT(*) AS occurrences
FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_raw`
GROUP BY
  ride_id
HAVING
  COUNT(*) > 1
ORDER BY
  occurrences DESC;


/* ---------------------------------------------------------
   3. Confirm rider categories
--------------------------------------------------------- */

SELECT
  member_casual,
  COUNT(*) AS total_rides
FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_raw`
GROUP BY
  member_casual
ORDER BY
  total_rides DESC;


/* ---------------------------------------------------------
   4. Check missing values in essential fields
--------------------------------------------------------- */

SELECT
  COUNTIF(ride_id IS NULL OR TRIM(ride_id) = '')
    AS missing_ride_id,

  COUNTIF(rideable_type IS NULL OR TRIM(rideable_type) = '')
    AS missing_rideable_type,

  COUNTIF(started_at IS NULL)
    AS missing_started_at,

  COUNTIF(ended_at IS NULL)
    AS missing_ended_at,

  COUNTIF(member_casual IS NULL OR TRIM(member_casual) = '')
    AS missing_member_casual

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_raw`;


/* ---------------------------------------------------------
   5. Check missing station and coordinate values
--------------------------------------------------------- */

SELECT
  COUNTIF(
    start_station_name IS NULL
    OR TRIM(start_station_name) = ''
  ) AS missing_start_station_name,

  COUNTIF(
    end_station_name IS NULL
    OR TRIM(end_station_name) = ''
  ) AS missing_end_station_name,

  COUNTIF(start_lat IS NULL)
    AS missing_start_lat,

  COUNTIF(start_lng IS NULL)
    AS missing_start_lng,

  COUNTIF(end_lat IS NULL)
    AS missing_end_lat,

  COUNTIF(end_lng IS NULL)
    AS missing_end_lng

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_raw`;


/* ---------------------------------------------------------
   6. Check raw ride-duration issues
--------------------------------------------------------- */

SELECT
  COUNTIF(
    TIMESTAMP_DIFF(ended_at, started_at, SECOND) < 0
  ) AS negative_duration_rides,

  COUNTIF(
    TIMESTAMP_DIFF(ended_at, started_at, SECOND) = 0
  ) AS zero_duration_rides,

  COUNTIF(
    TIMESTAMP_DIFF(ended_at, started_at, SECOND)
      BETWEEN 1 AND 59
  ) AS rides_under_one_minute,

  COUNTIF(
    TIMESTAMP_DIFF(ended_at, started_at, SECOND) >= 86400
  ) AS rides_24_hours_or_more

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_raw`;


/* ---------------------------------------------------------
   7. Validate the cleaned table
--------------------------------------------------------- */

SELECT
  COUNT(*) AS total_clean_rows,
  COUNT(DISTINCT ride_id) AS unique_clean_ride_ids,
  MIN(ride_date) AS earliest_ride_date,
  MAX(ride_date) AS latest_ride_date,
  MIN(ride_length_seconds) AS shortest_ride_seconds,
  MAX(ride_length_seconds) AS longest_ride_seconds

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`;
