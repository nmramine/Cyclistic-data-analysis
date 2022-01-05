install.packages('tidyverse')
install.packages('ggplot2')
install.packages('lubridate')

library(tidyverse)
library(lubridate)
library(janitor)

December_2020 <- read_csv("202012-divvy-tripdata.csv")
January_2021 <- read_csv("202101-divvy-tripdata.csv")
February_2021 <- read_csv("202102-divvy-tripdata.csv")
March_2021 <- read_csv("202103-divvy-tripdata.csv")
April_2021 <- read_csv("202104-divvy-tripdata.csv")
Mai_2021 <- read_csv("202105-divvy-tripdata.csv")
June_2021 <- read_csv("202106-divvy-tripdata.csv")
July_2021 <- read_csv("202107-divvy-tripdata.csv")
August_2021 <- read_csv("202108-divvy-tripdata.csv")
September_2021 <- read_csv("202109-divvy-tripdata.csv")
October_2021 <- read_csv("202110-divvy-tripdata.csv")
November_2021 <- read_csv("202111-divvy-tripdata.csv")

compare_df_cols_same(December_2020,January_2021, February_2021, March_2021, April_2021, Mai_2021,
                     June_2021, July_2021, August_2021, September_2021, October_2021, November_2021)

all_trips <- bind_rows(December_2020,January_2021, February_2021, March_2021, April_2021, Mai_2021,
                       June_2021, July_2021, August_2021, September_2021, October_2021, November_2021)


head(all_trips)
glimpse(all_trips)
str(all_trips)


all_trips$date <- as_date(all_trips$started_at)
all_trips$month <- format(as_date(all_trips$date), "%m")
all_trips$day <- format(as_date(all_trips$date), "%d")
all_trips$year <- format(as_date(all_trips$date), "%y")

all_trips$day_of_week <- format(as_date(all_trips$date), "%a")


glimpse(all_trips)


all_trips$trip_duration <- difftime(all_trips$ended_at, all_trips$started_at, 
                                    units = "secs")

all_trips$trip_duration <- as.numeric(all_trips$trip_duration)
all_trips$year <- as.numeric(all_trips$year)
all_trips$month <- as.numeric(all_trips$month)
all_trips$day <- as.numeric(all_trips$day)

all_trips_v2 <- all_trips[!(all_trips$trip_duration < 60),]

summary(all_trips_v2$trip_duration)

aggregate(all_trips_v2$trip_duration ~ all_trips_v2$member_casual, FUN = max)

aggregate(trip_duration ~ member_casual + day_of_week, data = all_trips_v2, mean)

aggregate(trip_duration ~ member_casual + rideable_type, data = all_trips_v2, sum)

aggregate(trip_duration ~ member_casual + month, data = all_trips_v2, sum)


