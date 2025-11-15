library(tidyverse)
library(activityinfo)
source("SpotifyAPI.R")

# Creates a folder data

dir.create("./data", showWarnings = FALSE)

#This command will download the dataset as a ZIP file into the ./data folder.

system("kaggle datasets download -d nabihazahid/spotify-dataset-for-churn-analysis -p ./data")

system("kaggle datasets download -d nabihazahid/spotify-dataset-for-churn-analysis -p ./data --force")


# Unzip the downloaded file
#This will extract the contents of the ZIP file into the ./data folder.

unzip("./data/spotify-dataset-for-churn-analysis.zip", exdir = "./data")

library(readr)
spotify_churn_dataset <- read_csv("spotify_churn_dataset.csv")

View(spotify_churn_dataset)

colnames(spotify_churn_dataset)

head(spotify_churn_dataset)

# Transforming the dataset using

spotify_churn_dataset_transformed <- spotify_churn_dataset |>
  rename("User ID" = user_id,
  "Gender" = gender,
  "Age" = age,
  "country" = country,
  "Subscription Type" = subscription_type,
  "Listening Time" = listening_time,
  "Songs Played Per Day" = songs_played_per_day,
  "Skip Rate" = skip_rate,
  "Device Type" = device_type,
  "Ads Listened Per Week" = ads_listened_per_week,
  "Offline Listening" = offline_listening,
  "Is Churned" = is_churned)|>
  mutate(`Is Churned` = ifelse(`Is Churned` == 1, "Yes", "No"))|>
  mutate(`Offline Listening` = ifelse(`Offline Listening` == 1, "Yes", "No"))

view(spotify_churn_dataset_transformed)

# Checking the number of records

nrow(spotify_churn_dataset_transformed)


databaseId <- 'caqvh9omg6lmiip2'
spotifyformid<-"cvw96bumg6loanq3"

# Start the import into ActivityInfo

importRecords(formId = spotifyformid, data = spotify_churn_dataset_transformed, 
              recordIdColumn = "RecordID")
