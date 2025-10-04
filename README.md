# End-to-End-Data-Pipeline-Kaggle-R-ActivityInfo-Power-BI
This repository demonstrates how to build a complete data pipeline by:  
1. Extracting datasets from **Kaggle** using the Kaggle API.  
2. Transforming data in **R**.  
3. Uploading data to **ActivityInfo** via API.  
4. Visualizing results in **Power BI**. 

## Data architecture Diagram
![KaggleAPI3](https://github.com/user-attachments/assets/7b27be49-db7c-40eb-b9ed-5fee57ef579b)

---

## 1. Install and Configure Kaggle API  

### Step 1: Install Kaggle API  

Make sure Python is installed, then run:  

-- bash
pip install --upgrade kaggle
Check version:

bash
Check kaggle installed version
kaggle --version

### Step 2: Authenticate Kaggle

Log in to Kaggle → Go to Account → API → Create New Token.

This downloads a kaggle.json file.

Place it in the correct directory:

- Windows:

makefile
C:\Users\<YourUser>\.kaggle\kaggle.json
Linux/Mac:

bash
~/.kaggle/kaggle.json

- Creates a folder data in R

dir.create("./data", showWarnings = FALSE)

## 2. Download a Dataset from Kaggle

- spotify-dataset

- This command will download the dataset as a ZIP file into the ./data folder.

system("kaggle datasets download -d nabihazahid/spotify-dataset-for-churn-analysis -p ./data")

- This will extract the contents of the ZIP file into the ./data folder.

unzip("./data/spotify-dataset-for-churn-analysis.zip", exdir = "./data")

### Load R packages to read and transform the sportify dataset

- library(tidyverse)
- library(activityinfo)
- source("SpotifyAPI.R")
- library(readr)


spotify_churn_dataset <- read_csv("spotify_churn_dataset.csv")

#view the spotify churn dataset in R

View(spotify_churn_dataset)

#view the column names in R

colnames(spotify_churn_dataset)

#View the first 5 rows in R

head(spotify_churn_dataset)

## 3. Transform Sportify Dataset in R

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

### Indentify the database to import the dataset in ActivityInfo 

databaseId <- 'caqvh9omg6lmiip2'

### Identify the formid to load the spotify dataset in ActivityInfo

spotifyformid<-"cvw96bumg6loanq3"


### Start the importing process into ActivityInfo

importRecords(formId = spotifyformid, data = spotify_churn_dataset_transformed, 
              recordIdColumn = "RecordID")

### 7. Build Spotify Dashboard in Power BI

### Streaming Insights: Spotify Analysis

- Data Extracted via Kaggle API and ActivityInfo API

![Picture2](https://github.com/user-attachments/assets/9e39b7bd-a549-4d2b-9321-824fbc527d55)


## 📌 Summary

✅ Kaggle API → Download datasets

✅ R → Clean and transform data

✅ ActivityInfo API → Store structured data

✅ Power BI → Extract, analyze, and visualize
