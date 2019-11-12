
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
  select(Country, Happiness.Score, Happiness.Rank, Freedom, Trust..Government.Corruption.) %>%
  arrange(desc(Trust..Government.Corruption.))


trust <- gov_trust_df %>% select(Country, Trust..Government.Corruption.)



# Scatter Plot
gov_trust_scatter_plot = ggplot(gov_trust_df,
                                aes(x = Happiness.Score,
                                    y = Trust..Government.Corruption.,
                                    color = Freedom )) +
  geom_point(shape = 20, size = 4) +
  stat_smooth(method = "lm", col = "black") +
  theme_light()+
  scale_color_gradient("Degree of Country Freedom", 
                       low = "grey", high = "purple2") +
  labs(x = "Happiness Score", y = "Government Trust",
       Title = "Happiness Score vs. Gov. Trust Scatterplot")


#r squared value
gov_trust.lm = lm(Happiness.Score ~Trust..Government.Corruption., data = gov_trust_df)
gov_trust_r_squared = summary(gov_trust.lm)$r.squared 






# Creates map based on aggregated data
world_shape <- map_data(map = "world") %>% 
  rename(Country = region) %>%
  full_join(gov_trust_df, by = "Country") %>%
  rename(
    Longitude = long,
    Latitude = lat
  )

heat_map <- ggplot(world_shape) +
  geom_polygon(
    mapping = aes(x = Longitude, y = Latitude, group = group, fill = Trust..Government.Corruption.),
    color = "black"
  ) +
  coord_map() +
  scale_fill_continuous(low = "#431338", high = "431338", na.value = "white") +
  labs(fill = "Percent of Corruption",
       title = "Percent of Corruption in each Country, 2017")
