
library(dplyr)
setwd("~/Documents/GitHub/project")

country_2017_data <- read.csv("data/2017.csv", stringsAsFactors = FALSE)

country_data <- read.csv("data/country_variabels.csv", stringsAsFactors = FALSE)

colnames(country_data)[colnames(country_data)=="country"] <- "Country"

happy_data <- left_join(country_2017_data, country_data, by = "Country")

write.csv(happy_data, file = "data/happy_df.csv")