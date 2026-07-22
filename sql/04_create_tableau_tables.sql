-- Cyclistic Bike-Share Analysis
-- Step 4: Create aggregated tables for Tableau
--
-- These smaller tables improve dashboard performance and prevent
-- the full 5.4-million-row cleaned dataset from being published.


/* ---------------------------------------------------------
   1. Rider overview
--------------------------------------------------------- */

CREATE OR REPLACE TABLE
  `learning-sql-498907.cyclistic_data.tableau_rider_overview`
AS

SELECT
  member_casual,
  COUNT(*) AS total_rides,

  ROUND(
    COUNT(*) * 100.0
    / SUM(COUNT(*)) OVER (),
    2
  ) AS percent_of_all_rides,

  ROUND(
    AVG(ride_length_minutes),
    2
  ) AS average_ride_minutes,

  ROUND(
    APPROX_QUANTILES(
      ride_length_minutes,
      100
    )[OFFSET(50)],
    2
  ) AS median_ride_minutes,

  COUNTIF(day_type = 'Weekend')
    AS weekend_rides,

  ROUND(
    COUNTIF(day_type = 'Weekend')
    * 100.0 / COUNT(*),
    2
  ) AS percent_weekend_rides

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

GROUP BY
  member_casual;


/* ---------------------------------------------------------
   2. Monthly summary
--------------------------------------------------------- */

CREATE OR REPLACE TABLE
  `learning-sql-498907.cyclistic_data.tableau_monthly_summary`
AS

SELECT
  member_casual,
  month_number,
  month_name,
  COUNT(*) AS total_rides,

  ROUND(
    AVG(ride_length_minutes),
    2
  ) AS average_ride_minutes,

  ROUND(
    APPROX_QUANTILES(
      ride_length_minutes,
      100
    )[OFFSET(50)],
    2
  ) AS median_ride_minutes

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

GROUP BY
  member_casual,
  month_number,
  month_name;


/* ---------------------------------------------------------
   3. Day-of-week summary
--------------------------------------------------------- */

CREATE OR REPLACE TABLE
  `learning-sql-498907.cyclistic_data.tableau_day_summary`
AS

SELECT
  member_casual,
  day_of_week_number,
  day_of_week,
  day_type,
  COUNT(*) AS total_rides,

  ROUND(
    COUNT(*) * 100.0
    / SUM(COUNT(*)) OVER (
        PARTITION BY member_casual
      ),
    2
  ) AS percent_of_rider_type_rides,

  ROUND(
    AVG(ride_length_minutes),
    2
  ) AS average_ride_minutes,

  ROUND(
    APPROX_QUANTILES(
      ride_length_minutes,
      100
    )[OFFSET(50)],
    2
  ) AS median_ride_minutes

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

GROUP BY
  member_casual,
  day_of_week_number,
  day_of_week,
  day_type;


/* ---------------------------------------------------------
   4. Hourly summary
--------------------------------------------------------- */

CREATE OR REPLACE TABLE
  `learning-sql-498907.cyclistic_data.tableau_hourly_summary`
AS

SELECT
  member_casual,
  day_type,
  start_hour,
  COUNT(*) AS total_rides,

  ROUND(
    COUNT(*) * 100.0
    / SUM(COUNT(*)) OVER (
        PARTITION BY member_casual, day_type
      ),
    2
  ) AS percent_of_rider_type_day_rides,

  ROUND(
    AVG(ride_length_minutes),
    2
  ) AS average_ride_minutes

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

GROUP BY
  member_casual,
  day_type,
  start_hour;


/* ---------------------------------------------------------
   5. Top station summary
--------------------------------------------------------- */

CREATE OR REPLACE TABLE
  `learning-sql-498907.cyclistic_data.tableau_station_summary`
AS

WITH station_counts AS (
  SELECT
    member_casual,
    start_station_name,

    ROUND(
      AVG(start_lat),
      6
    ) AS start_lat,

    ROUND(
      AVG(start_lng),
      6
    ) AS start_lng,

    COUNT(*) AS total_rides

  FROM
    `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

  WHERE
    start_station_name IS NOT NULL
    AND TRIM(start_station_name) != ''
    AND start_lat IS NOT NULL
    AND start_lng IS NOT NULL

  GROUP BY
    member_casual,
    start_station_name
),

ranked_stations AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY member_casual
      ORDER BY
        total_rides DESC,
        start_station_name
    ) AS station_rank

  FROM
    station_counts
)

SELECT
  member_casual,
  start_station_name,
  start_lat,
  start_lng,
  total_rides,
  station_rank

FROM
  ranked_stations

WHERE
  station_rank <= 15;
