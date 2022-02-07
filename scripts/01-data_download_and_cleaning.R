#### Preamble ####
# Purpose: Set up and clean the Toronto marriage license data from opendatatoronto
# Author: Zihao Liu
# Data: 6 February 2021
# Contact:zihaohans.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(opendatatoronto)
library(dplyr)

#### Code from opendatatoronto ####
# From https://open.toronto.ca/dataset/marriage-licence-statistics/
# get package
package <- show_package("e28bc818-43d5-43f7-b5d9-bdfb4eda5feb")
package

# get resources for the package
resources <- list_package_resources("e28bc818-43d5-43f7-b5d9-bdfb4eda5feb")

# load the first datastore resource as a sample
raw_data <- resources%>% get_resource()

### Save raw data ###
write_csv(raw_data, "inputs/data/raw_marriage_data.csv")

### Clean the raw data ###
# remove the id column
marriage_clean <- raw_data[-c(1)]

# Add two columns to represent month and year individually
marriage_clean<- marriage_clean|>mutate(month =substr(TIME_PERIOD,6,7),
                                        year = substr(TIME_PERIOD,1,4))

### Save the cleaned data ###
write_csv(marriage_clean, "inputs/data/cleaned_marriage_data.csv")  