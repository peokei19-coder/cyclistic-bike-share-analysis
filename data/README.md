# Data

## Data Source

This analysis uses 12 months of publicly available Divvy trip data covering January through December 2025. Divvy is the real-world bike-share service represented by the fictional company Cyclistic in the Google Data Analytics Certificate case study.

The original trip files were downloaded from the official Divvy system data archive:

https://divvybikes.com/system-data

The data is made available for public use under the Divvy Data License Agreement.

## Files Used

The analysis included the following monthly files:

- `202501-divvy-tripdata.csv`
- `202502-divvy-tripdata.csv`
- `202503-divvy-tripdata.csv`
- `202504-divvy-tripdata.csv`
- `202505-divvy-tripdata.csv`
- `202506-divvy-tripdata.csv`
- `202507-divvy-tripdata.csv`
- `202508-divvy-tripdata.csv`
- `202509-divvy-tripdata.csv`
- `202510-divvy-tripdata.csv`
- `202511-divvy-tripdata.csv`
- `202512-divvy-tripdata.csv`

The 12 files contained 5,552,994 trip records before cleaning.

## Raw Data

The original monthly CSV files are not included in this repository because of their combined size. They can be downloaded directly from the official Divvy data archive using the link above.

The raw files were preserved unchanged locally and loaded into Google Cloud Storage before being combined into a single BigQuery table.

## Processed Data

The `processed` folder contains five aggregated CSV files created in BigQuery for Tableau:

- `tableau_rider_overview.csv`
- `tableau_monthly_summary.csv`
- `tableau_day_summary.csv`
- `tableau_hourly_summary.csv`
- `tableau_station_summary.csv`

These files contain summarized results rather than individual trip records.

## Privacy and Limitations

The public dataset does not include personally identifiable rider information. Therefore, the analysis cannot determine:

- Whether multiple casual rides were completed by the same person
- Whether casual riders live within the Cyclistic service area
- Why an individual rider chose to take a trip
- Whether a casual rider later purchased a membership

Station information is also missing from approximately one-fifth of the trips. Those records were retained for rider-type, duration, date, and time analysis but excluded from station-specific visualizations.
