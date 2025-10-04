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
Copy code
kaggle --version

### Step 2: Authenticate Kaggle
Log in to Kaggle → Go to Account → API → Create New Token.

This downloads a kaggle.json file.

Place it in the correct directory:

- Windows:

makefile
Copy code
C:\Users\<YourUser>\.kaggle\kaggle.json
Linux/Mac:

bash
Copy code
~/.kaggle/kaggle.json
Fix permissions (Linux/Mac):

bash
Copy code
chmod 600 ~/.kaggle/kaggle.json

## 2. Download a Dataset from Kaggle
Example: Titanic dataset

bash
Copy code
mkdir -p data
kaggle competitions download -c titanic -p data
unzip data/titanic.zip -d data/

## 3. Transform Data in R
R
Copy code
- Load libraries
library(dplyr)
library(readr)

### Load dataset
titanic <- read_csv("data/train.csv")

### Example transformation: rename + clean
titanic_clean <- titanic %>%
  rename("Passenger ID" = PassengerId) %>%
  mutate(Survived = ifelse(Survived == 1, "Yes", "No"))
## Import Data into ActivityInfo
Install required packages:

R
Copy code
install.packages("httr")
install.packages("jsonlite")
Example API request in R:

R
Copy code
library(httr)
library(jsonlite)

### 4. Replace with your ActivityInfo API token
token <- "YOUR_ACTIVITYINFO_TOKEN"
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
### 5. Extract Data from ActivityInfo into R
R
Copy code
url <- "https://www.activityinfo.org/resources/form/YOUR_FORM_ID/records"

records <- GET(
  url,
  add_headers(Authorization = paste("Bearer", token))
)

data <- fromJSON(content(records, "text"))

- Convert to dataframe
activityinfo_df <- as.data.frame(data$records)
### 6. Connect R Output to Power BI
Two options:

Export CSV from R and import into Power BI:

R
Copy code
write.csv(activityinfo_df, "activityinfo_data.csv", row.names = FALSE)
Direct API Connection in Power BI:
Use Web API connector with the ActivityInfo endpoint and provide your API token.

### 7. Build Final Dashboards in Power BI
Import dataset(s)

Create dashboards with filters, slicers, and KPIs

Set scheduled refresh for automated updates

# 📌 Summary

✅ Kaggle API → Download datasets

✅ R → Clean and transform data

✅ ActivityInfo API → Store structured data

✅ Power BI → Extract, analyze, and visualize
