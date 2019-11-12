
library(dplyr)
library(stringr)
library("leaflet")
library("ggplot2")
library("knitr")

setwd("~/Documents/GitHub/project")

country_2017_data <- read.csv("data/2017.csv", stringsAsFactors = FALSE)

country_data <- read.csv("data/country_variabels.csv", stringsAsFactors = FALSE)

colnames(country_data)[colnames(country_data)=="country"] <- "Country"

happy_data <- left_join(country_2017_data, country_data, by = "Country")

write.csv(happy_data, file = "data/happy_df.csv")




gov_trust_df <- happy_data %>% 
  select(Country, Happiness.Rank, Freedom, Trust..Government.Corruption.) %>%
  arrange(desc(Trust..Government.Corruption.))


trust <- gov_trust_df %>% select(Country, Trust..Government.Corruption.)


world_shape <- map_data("world") %>%
  rename(Country = region) %>%
  left_join(trust, by = "Country")


# Creates map based on aggregated data
heat_map <- ggplot(world_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = Trust..Government.Corruption.),
    color = "black"
  ) +
  coord_map() +
  scale_fill_continuous(low = "#431338", high = "431338") +
  labs(fill = "Percent of Corruption",
       title = "Percent of Corruption in each Country, 2017")
