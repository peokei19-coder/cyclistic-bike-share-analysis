# Cyclistic Bike-Share Analysis

## Project Overview: 
This case study analyzes how casual riders and annual members use Cyclistic bikes differently. The goal is to identify patterns in ride frequency, duration, timing, and location that can help Cyclistic develop marketing strategies for converting casual riders into annual members.

## Business Task: 
Cyclistic’s director of marketing wants to increase the number of annual memberships because annual members are more profitable than casual riders. The business task is to analyze Cyclistic’s historical bike-trip data to determine how casual riders and annual members use the bike-share service differently. The findings will be used to develop three data-driven marketing recommendations aimed at encouraging casual riders to purchase annual memberships.

### Primary Business Question: 
How do annual members and casual riders use Cyclistic bikes differently?

## Key Stakeholders
- Lily Moreno, Director of Marketing
- Cyclistic Marketing Analytics Team
- Cyclistic Executive Team

## Tools
- Google BigQuery:Data storage, cleaning, transformation, and analysis
- Tableau: Data visualization and dashboard development
- GitHub:Project documentation and portfolio presentation

## Interactive Dashboard
Explore the full interactive Tableau dashboard:
[View the Cyclistic Rider Behavior Analysis Dashboard](https://public.tableau.com/app/profile/peace.okei/viz/cyclistic_rider_analysis_2025/CyclisticRiderBehaviorAnalysis2025)

## Dashboard Preview
![Cyclistic Rider Behavior Analysis Dashboard](images/cyclistic_dashboard_2025.png.png)

## Data Preparation and Cleaning

The 12 monthly CSV files were uploaded to Google Cloud Storage and combined into one raw BigQuery table containing **5,552,994 trip records**.

Before analysis, I completed the following quality checks:

- Verified that all `ride_id` values were unique
- Confirmed that `member_casual` contained only `member` and `casual`
- Checked essential fields for null or blank values
- Reviewed missing station and coordinate information
- Investigated negative, zero, unusually short, and unusually long ride durations
- Confirmed the dataset’s date range

### Cleaning Decisions

The cleaned dataset:
- Includes only trips beginning between January 1 and December 31, 2025
- Excludes rides lasting less than one minute
- Excludes rides lasting 24 hours or longer
- Retains trips with missing station information because they remain useful for time, duration, bike-type, and rider-group analysis
- Excludes missing station records only from station-specific visualizations
After cleaning, the final analysis table contained **5,399,955 unique rides**.

Additional calculated fields included:
- Ride length in seconds and minutes
- Ride date
- Day of the week
- Weekday or weekend classification
- Month name and number
- Starting hour

## Key Findings

### 1. Members Complete Most Cyclistic Trips
Annual members completed 3,484,186 rides, representing 64.52% of all cleaned trips. Casual riders completed 1,915,769 rides, accounting for **35.48%**.

### 2. Casual Riders Take Longer Trips
Casual rides lasted 19.90 minutes on average, compared with 12.17 minutes for member rides. The median casual ride was also longer, at 11.88 minutes, compared with 8.73 minutes for members.
This indicates that casual riders generally use Cyclistic for longer periods, even after extreme ride durations were removed.

### 3. Casual Riders Are More Active on Weekends
Weekends accounted for 37.19% of casual rides, compared with only 23.37% of member rides. Members completed 76.63% of their rides on weekdays, suggesting more consistent use for routine transportation. Casual riders showed stronger weekend activity and longer weekend ride durations.

### 4. Member Usage Follows Weekday Commuting Patterns
Member ridership showed distinct weekday peaks around:
- 7:00–8:00 AM
- 4:00–6:00 PM
Casual-rider activity was concentrated later in the day, primarily between 3:00 PM and 7:00 PM, without a comparable morning peak. These patterns are consistent with members using Cyclistic more frequently for routine weekday transportation, although the dataset does not identify individual trip purposes.

### 5. Casual Ridership Is More Seasonal
Ridership increased for both groups during warmer months, but casual usage changed more dramatically throughout the year. Casual rides increased from 23,405 in January to 323,533 in August, before declining to 27,075 in December. Members also peaked during the summer but demonstrated more consistent year-round usage.

### 6. Casual Trips Concentrate Near Recreational Destinations
The most popular casual-rider starting stations included locations near:
- Navy Pier
- Millennium Park
- Shedd Aquarium
- Theater on the Lake
- DuSable Harbor
- Michigan Avenue
The concentration of casual trips around Chicago’s lakefront and visitor destinations suggests that many casual riders use Cyclistic for recreational or sightseeing-related travel. Because trip purpose is not included in the dataset, this interpretation is based on location and usage patterns rather than direct rider feedback.

### 7. Bike Preferences Are Similar
Electric bikes were the most frequently used option for both groups:
- 65.13% of casual rides
- 63.42% of member rides
Because the difference is small, bike type does not appear to be one of the strongest distinctions between casual riders and members.

## Recommendations
### 1. Launch Seasonal Weekend Membership Campaigns
Casual ridership is highest during warmer months and is more concentrated on weekends. Cyclistic should prioritize membership-conversion campaigns from late spring through early fall, particularly on Saturdays and Sundays. Campaign messaging should emphasize:
- The value of unlimited or frequent rides during the summer
- Cost savings compared with repeatedly purchasing single-ride or day passes
- The convenience of having an annual membership available for spontaneous weekend trips
Digital campaigns should be scheduled most heavily during the afternoon and early evening, when casual-rider activity is highest.

### 2. Promote Memberships at High-Traffic Casual-Rider Locations
Cyclistic should focus location-based marketing around stations with high casual-rider activity, especially near Navy Pier, Millennium Park, Shedd Aquarium, the lakefront, and other major visitor destinations. Possible tactics include:
- Station signage with QR codes linking to a membership offer
- In-app or post-ride membership prompts
- Geographically targeted social and mobile advertisements
- Partnerships with nearby attractions, hotels, and tourism organizations
- Limited-time membership incentives promoted at high-volume stations
These locations provide an opportunity to reach casual riders while they are actively using the service.

### 3. Position Membership as an Everyday Transportation Option
Member activity shows strong weekday morning and evening peaks, while casual riders are more concentrated during weekends and later hours. Cyclistic should develop messaging that helps casual riders see the service as useful beyond recreational trips. Campaigns could demonstrate how an annual membership supports:
- Commuting to work or school
- Short weekday errands
- Connections to public transportation
- Regular neighborhood travel
- Reliable transportation without car ownership or parking costs
A limited-time membership trial or introductory discount could encourage leisure-oriented casual riders to test Cyclistic for weekday transportation.
