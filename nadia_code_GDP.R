#Nadia's code GDP anaylysis


#load packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)
library(rworldmap)
library(plotly)
library(leaflet)
library(ggpmisc)


#load csv
happy_df <- read.csv("data/happy_df.csv", stringsAsFactors = FALSE)
View(happy_df)

#look at only GDP related columns
gdp_only_df = happy_df %>% 
  select(contains("GDP"))
         
#data frame with country namesm happy rank, and gdp info
gdp_happy_df = happy_df %>% 
  select(2:4) %>% 
  bind_cols(gdp_only_df)


# SCATTER PLOT: GDP PER CAPITA VS HAPPINESS SCORE 
gdp_scatter_plot = ggplot(gdp_happy_df,aes(x = Economy..GDP.per.Capita., y = Happiness.Score, color = Happiness.Rank ))+
  geom_point(shape = 19, size = 5)+
  stat_smooth(method = "lm", col = "black")+
  theme_light()+
  scale_color_gradient("Happiness Rank", low = "limegreen", high = "black", na.value = "white") +
  labs(x = "GDP per Capita", 
       y = "Happiness Score", 
       Title = "GDP vs Happiness Score Scatterplot")

#r squared value
gdp.lm = lm(Economy..GDP.per.Capita. ~ Happiness.Score, data=gdp_happy_df)
gdp_r_squared = summary(gdp.lm)$r.squared 

# CHLOROPLETH MAPS
# change United States to USA
gdp_happy_df$Country[gdp_happy_df$Country == "United States"] = "USA"

# join map data and gdp data summary together
world_shape <- map_data(map = "world") %>% 
  rename(Country = region) %>%
  full_join(gdp_happy_df, by = "Country") %>%
  rename(
    Longitude = long,
    Latitude = lat
  )

# 1. WORLD GDP

#function to make GDP map
make_gdp_map <- function(state_shape) {
  ggplot(world_shape) +
    geom_polygon(
      mapping = aes(x = Longitude, y = Latitude, group = group, fill = Economy..GDP.per.Capita.),
      color = "gray", # show country outlines
      size = .1 # thinly stroked
    ) +
    coord_map() + # use a map-based coordinate system
    scale_fill_gradient(low = "black", high = "lightskyblue", na.value = "white") +
    labs(
      fill = "GDP Per Capita",
      title = "World Map: GDP per Capita "
    )

}
interactive_gdp_map <- ggplotly(make_gdp_map(world_shape))
interactive_gdp_map



# WORLD HAPPINESS
make_happy_map <- function(state_shape) {
  ggplot(world_shape) +
    geom_polygon(
      mapping = aes(x = Longitude, y = Latitude, group = group, fill = Happiness.Score),
      color = "gray", # show country outlines
      size = .1 # thinly stroked
    ) +
    coord_map() + # use a map-based coordinate system
    scale_fill_gradient(low = "black", high = "greenyellow", na.value = "white") +
    labs(
      fill = "Happiness Score",
      title = "World Map: of Happiness Scores"
    )
}

interactive_happy_map <- ggplotly(make_happy_map(world_shape))
interactive_happy_map










