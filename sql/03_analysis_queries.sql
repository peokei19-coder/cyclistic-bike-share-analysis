-- Cyclistic Bike-Share Analysis
-- Step 3: Analyze differences between casual riders and members
--
-- Business question:
-- How do annual members and casual riders use Cyclistic bikes differently?


/* ---------------------------------------------------------
   1. Total rides and percentage by rider type
--------------------------------------------------------- */

SELECT
  member_casual,
  COUNT(*) AS total_rides,

  ROUND(
    COUNT(*) * 100.0
    / SUM(COUNT(*)) OVER (),
    2
  ) AS percentage_of_rides

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

GROUP BY
  member_casual

ORDER BY
  total_rides DESC;


/* ---------------------------------------------------------
   2. Ride-duration comparison
--------------------------------------------------------- */

SELECT
  member_casual,
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
  ) AS median_ride_minutes,

  ROUND(
    MIN(ride_length_minutes),
    2
  ) AS minimum_ride_minutes,

  ROUND(
    MAX(ride_length_minutes),
    2
  ) AS maximum_ride_minutes

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

GROUP BY
  member_casual

ORDER BY
  member_casual;


/* ---------------------------------------------------------
   3. Usage by day of the week
--------------------------------------------------------- */

SELECT
  member_casual,
  day_of_week,
  day_of_week_number,
  COUNT(*) AS total_rides,

  ROUND(
    AVG(ride_length_minutes),
    2
  ) AS average_ride_minutes

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

GROUP BY
  member_casual,
  day_of_week,
  day_of_week_number

ORDER BY
  day_of_week_number,
  member_casual;


/* ---------------------------------------------------------
   4. Weekday versus weekend behavior
--------------------------------------------------------- */

SELECT
  member_casual,
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
  day_type

ORDER BY
  member_casual,
  day_type;


/* ---------------------------------------------------------
   5. Monthly riding patterns
--------------------------------------------------------- */

SELECT
  member_casual,
  month_name,
  month_number,
  COUNT(*) AS total_rides,

  ROUND(
    AVG(ride_length_minutes),
    2
  ) AS average_ride_minutes

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

GROUP BY
  member_casual,
  month_name,
  month_number

ORDER BY
  month_number,
  member_casual;


/* ---------------------------------------------------------
   6. Weekday hourly riding patterns
--------------------------------------------------------- */

SELECT
  member_casual,
  start_hour,
  COUNT(*) AS total_rides,

  ROUND(
    AVG(ride_length_minutes),
    2
  ) AS average_ride_minutes

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

WHERE
  day_type = 'Weekday'

GROUP BY
  member_casual,
  start_hour

ORDER BY
  member_casual,
  start_hour;


/* ---------------------------------------------------------
   7. Bike-type preferences
--------------------------------------------------------- */

SELECT
  member_casual,
  rideable_type,
  COUNT(*) AS total_rides,

  ROUND(
    COUNT(*) * 100.0
    / SUM(COUNT(*)) OVER (
        PARTITION BY member_casual
      ),
    2
  ) AS percent_of_rider_type_rides

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

GROUP BY
  member_casual,
  rideable_type

ORDER BY
  member_casual,
  total_rides DESC;


/* ---------------------------------------------------------
   8. Top casual-rider starting stations
--------------------------------------------------------- */

SELECT
  start_station_name,
  COUNT(*) AS casual_rides

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

WHERE
  member_casual = 'casual'
  AND start_station_name IS NOT NULL
  AND TRIM(start_station_name) != ''

GROUP BY
  start_station_name

ORDER BY
  casual_rides DESC

LIMIT 10;


/* ---------------------------------------------------------
   9. Top member starting stations
--------------------------------------------------------- */

SELECT
  start_station_name,
  COUNT(*) AS member_rides

FROM
  `learning-sql-498907.cyclistic_data.tripdata_2025_clean`

WHERE
  member_casual = 'member'
  AND start_station_name IS NOT NULL
  AND TRIM(start_station_name) != ''

GROUP BY
  start_station_name

ORDER BY
  member_rides DESC

LIMIT 10;
