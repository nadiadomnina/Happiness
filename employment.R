

#load packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)
library(rworldmap)
library(plotly)
library(leaflet)
library(ggpmisc)

#load csv file
happy_df<- read.csv("data/happy_df.csv", stringsAsFactors = FALSE)

