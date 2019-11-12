#Health code R

#load packages
library(dplyr)
library(tidyr)
library(ggplot2)
library("leaflet")

setwd("~/Documents/GitHub/project")


#csv
happy_df <- read.csv("happy_df.csv", stringsAsFactors = FALSE)
country_2017_data <- read.csv("2017.csv", stringsAsFactors = FALSE)
country_data <- read.csv("country_variabels.csv", stringsAsFactors = FALSE)


#Health related column
health_df <- happy_df %>% 
  select(Country, Happiness.Score, Happiness.Rank, Health..Life.Expectancy.) %>% 
  arrange(desc(Health..Life.Expectancy.))


# Health vs Happiness scatter plot

 health_scatter_plot = ggplot(health_df,aes(x = Health..Life.Expectancy., y = Happiness.Score, color = Happiness.Rank ))+
  geom_point(shape = 20, size = 5)+
  stat_smooth(method = "lm", col = "black")+
  theme_light()+
  scale_color_gradient("Happiness Rank", low = "yellow", high = "Red") +
  labs(x = "Health & Life Expectancy", 
       y = "Happiness Score", 
       Title = "Health & Life Expectancy vs Happiness Score Scatterplot")

 
#r squared value
 
health.lm = lm(Health..Life.Expectancy. ~ Happiness.Score, data=health_df)
health_r_squared = summary(health.lm)$r.squared 


# Health & Life expectancy map

world_shape <- map_data(map = "world") %>% 
  rename(Country = region) %>%
  full_join(health_df, by = "Country") %>%
  rename(
    Longitude = long,
    Latitude = lat
  )


health_map <- ggplot(world_shape) +
  geom_polygon(
    mapping = aes(x = Longitude, y = Latitude, group = group, fill = Health..Life.Expectancy.),
    color = "black"
  ) +
  coord_map() +
  scale_fill_continuous(low = "#132B43", high = "Red", na.value = "white") +
  labs(
    fill = "Health & Life expectancy",
    title = "Map of Health & Life expectancy"
  )


