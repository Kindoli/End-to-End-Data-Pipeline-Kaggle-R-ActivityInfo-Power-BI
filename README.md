# End-to-End-Data-Pipeline-Kaggle-R-ActivityInfo-Power-BI
This guide demonstrates how to build an end-to-end pipeline that extracts datasets from Kaggle, transforms them in R, imports the cleaned data into ActivityInfo, and finally extracts and visualizes the results in Power BI.

# Data architecture Diagram
![KaggleAPI3](https://github.com/user-attachments/assets/7b27be49-db7c-40eb-b9ed-5fee57ef579b)

# 1. Install and Configure Kaggle API
Step 1: Install Kaggle API

Make sure you have Python installed, then run:

pip install --upgrade kaggle


-- Check the version:

kaggle --version

Step 2: Authenticate Kaggle

Log in to Kaggle
.

Go to Account → API → Create New Token.

A file named kaggle.json will be downloaded.

Place it in the correct directory:

## Windows:

C:\Users\<YourUser>\.kaggle\kaggle.json


## Linux/Mac:

~/.kaggle/kaggle.json


Make sure the file has the correct permissions:

chmod 600 ~/.kaggle/kaggle.json

2. Download Dataset from Kaggle

Example: Titanic dataset

# Create data folder
mkdir -p data

# Download dataset (zip file)
kaggle competitions download -c titanic -p data


Unzip:

unzip data/titanic.zip -d data/

3. Load Data in R for Transformation
# Load libraries
library(dplyr)
library(readr)

# Load dataset
titanic <- read_csv("data/train.csv")

# Transform example: Rename & Clean
titanic_clean <- titanic %>%
  rename("Passenger ID" = PassengerId) %>%
  mutate(Survived = ifelse(Survived == 1, "Yes", "No"))

4. Import Data into ActivityInfo

You can use the ActivityInfo API to bulk upload your transformed data.

Step 1: Install R Packages
install.packages("httr")
install.packages("jsonlite")

Step 2: Push Data to ActivityInfo
library(httr)
library(jsonlite)

# Replace with your ActivityInfo API token
token <- "YOUR_ACTIVITYINFO_TOKEN"

# Example: Upload one record
url <- "https://www.activityinfo.org/resources/form/YOUR_FORM_ID/record"

payload <- list(
  field1 = "Example Value",
  field2 = 123
)

response <- POST(
  url,
  add_headers(Authorization = paste("Bearer", token)),
  body = toJSON(payload, auto_unbox = TRUE),
  encode = "json"
)

print(content(response))

5. Extract Data from ActivityInfo into R
# Example: Fetch all records from a form
url <- "https://www.activityinfo.org/resources/form/YOUR_FORM_ID/records"

records <- GET(
  url,
  add_headers(Authorization = paste("Bearer", token))
)

data <- fromJSON(content(records, "text"))

# Convert to dataframe
activityinfo_df <- as.data.frame(data$records)

6. Connect R Output to Power BI

You can either:

Export CSV from R and load into Power BI:

write.csv(activityinfo_df, "activityinfo_data.csv", row.names = FALSE)


Or use Power BI Web API Connector with the ActivityInfo API endpoint directly, by providing your API token.

7. Final Visualization in Power BI

Import your dataset into Power BI.

Build dashboards (filters, slicers, KPIs).

Set scheduled refresh to keep your reports updated.

📌 Summary

✅ Kaggle API → Download datasets
✅ R → Clean and transform data
✅ ActivityInfo API → Store structured data
✅ Power BI → Extract, analyze, and visualize
