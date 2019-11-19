
library(dplyr)
library(stringr)
library("knitr")
library(tidyr)
library(ggplot2)
library(maps)
library(leaflet)
library(ggpmisc)
library(plotly)

# setwd("~/Documents/GitHub/project")


# Set up

country_2017_data <- read.csv("data/2017.csv", stringsAsFactors = FALSE)
country_data <- read.csv("data/country_variabels.csv", stringsAsFactors = FALSE)
colnames(country_data)[colnames(country_data) == "country"] <- "Country"
happy_data <- left_join(country_2017_data, country_data, by = "Country")
write.csv(happy_data, file = "data/happy_df.csv")

happy_df <- read.csv("data/happy_df.csv", stringsAsFactors = FALSE)


# Heat map of world happiness ranking
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




# GOVERNMENT
gov_trust_df <- happy_df %>%
  select(Country, Happiness.Score, Happiness.Rank, Freedom, Trust..Government.Corruption.) %>%
  arrange(desc(Trust..Government.Corruption.))

trust <- gov_trust_df %>% select(Country, Trust..Government.Corruption.)


# Scatter Plot
gov_trust_scatter_plot <- ggplot(
  gov_trust_df,
  aes(
    x = Trust..Government.Corruption.,
    y = Happiness.Score,
    color = Happiness.Rank
  )
) +
  geom_point(shape = 19, size = 5) +
  stat_smooth(method = "lm", col = "black") +
  theme_light() +
  scale_color_gradient("Happiness Rank",
    low = "limegreen", high = "black"
  ) +
  labs(
    x = "Government Trust", y = "Happiness Score",
    Title = "Happiness Score vs. Gov. Trust Scatterplot"
  )


# r squared value
gov_trust.lm <- lm(Happiness.Score ~ Trust..Government.Corruption., data = gov_trust_df)
gov_trust_r_squared <- summary(gov_trust.lm)$r.squared


# heat map
gov_trust_df$Country[gov_trust_df$Country == "United States"] <- "USA"

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
    color = "gray",
    size = .1
  ) +
  coord_map() +
  scale_fill_continuous(low = "#431338", high = "431338", na.value = "white") +
  labs(
    fill = "Percent of Corruption",
    title = "Percent of Corruption in each Country, 2017"
  )


#-----------------------------------------------------------------------------------------------------------------------

# GDP

# make a data frame with only gdp and happiness ranks
gdp_only_df <- happy_df %>%
  select(contains("GDP"))

gdp_happy_df <- happy_df %>%
  select(2:4) %>%
  bind_cols(gdp_only_df)


# Scatter Plot
gdp_scatter_plot <- ggplot(gdp_happy_df, aes(x = Economy..GDP.per.Capita., y = Happiness.Score, color = Happiness.Rank)) +
  geom_point(shape = 19, size = 5) +
  stat_smooth(method = "lm", col = "black") +
  theme_light() +
  scale_color_gradient("Happiness Rank", low = "limegreen", high = "black", na.value = "white") +
  labs(
    x = "GDP per Capita",
    y = "Happiness Score",
    Title = "GDP vs Happiness Score Scatterplot"
  )

# r squared value
gdp.lm <- lm(Economy..GDP.per.Capita. ~ Happiness.Score, data = gdp_happy_df)
gdp_r_squared <- summary(gdp.lm)$r.squared

# heat map
# data frame manipulation
gdp_happy_df$Country[gdp_happy_df$Country == "United States"] <- "USA"

world_shape <- map_data(map = "world") %>%
  rename(Country = region) %>%
  full_join(gdp_happy_df, by = "Country") %>%
  rename(
    Longitude = long,
    Latitude = lat
  )


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



#-----------------------------------------------------------------------------------------------------------------------

# HEALTH


# make a data frame with only health related column
health_df <- happy_df %>%
  select(Country, Happiness.Score, Happiness.Rank, Health..Life.Expectancy.) %>%
  arrange(desc(Health..Life.Expectancy.))


# Scatter plot
health_scatter_plot <- ggplot(health_df, aes(x = Health..Life.Expectancy., y = Happiness.Score, color = Happiness.Rank)) +
  geom_point(shape = 19, size = 5) +
  stat_smooth(method = "lm", col = "black") +
  theme_light() +
  scale_color_gradient("Happiness Rank", low = "yellow", high = "Red") +
  labs(
    x = "Health & Life Expectancy",
    y = "Happiness Score",
    Title = "Health & Life Expectancy vs Happiness Score Scatterplot"
  )

# r squared value
health.lm <- lm(Health..Life.Expectancy. ~ Happiness.Score, data = health_df)
health_r_squared <- summary(health.lm)$r.squared


# heat map
health_df$Country[health_df$Country == "United States"] <- "USA"


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


#-----------------------------------------------------------------------------------------------------------------------

# EMPLOYMENT

# make a data frame with employment related columns
employment_df <- happy_df %>%
  mutate(
    Employment..Agriculture....of.employed. =
      ifelse(Employment..Agriculture....of.employed. >= 0,
        Employment..Agriculture....of.employed., NA
      ),

    Employment..Industry....of.employed. =
      ifelse(Employment..Industry....of.employed. >= 0,
        Employment..Industry....of.employed., NA
      ),


    Employment..Services....of.employed. =
      ifelse(Employment..Services....of.employed. >= 0,
        Employment..Services....of.employed., NA
      ),
  )

# Scatterplot of Unemployment vs. Happiness
ggplot(employment_df, aes(x = as.numeric(Unemployment....of.labour.force.), y = Happiness.Score, color = Happiness.Rank, na.rm = TRUE)) +
  geom_point(shape = 19, size = 5) +
  stat_smooth(method = "lm", col = "black") +
  theme_light() +
  scale_color_gradient("Happiness Rank", low = "limegreen", high = "black", na.value = "white") +
  # scale_x_discrete("Unemployed Labor Force", seq(-100, 100, 50), seq(-100, 100, 50), c(-100, 100)) +
  labs(
    x = "Unemployed Labor Force",
    y = "Happiness Score",
    Title = "Unemployment Rate vs Happiness Score Scatterplot"
  )

# r squared value
# employment1.lm = lm(as.numeric(Unemployment....of.labour.force.) ~ Happiness.Score, data=employment_df)
# employment1_r_squared = summary(employment1.lm)$r.squared


# Scatterplot of Employment in Agriculture vs. Happiness
ggplot(employment_df, aes(x = Employment..Agriculture....of.employed., y = Happiness.Score, color = Happiness.Rank, na.rm = TRUE)) +
  geom_point(shape = 19, size = 5) +
  stat_smooth(method = "lm", col = "black") +
  theme_light() +
  scale_color_gradient("Happiness Rank", low = "limegreen", high = "black", na.value = "white") +
  labs(
    x = "Employed in Agriculture",
    y = "Happiness Score",
    Title = "Agriculture Employment vs Happiness Score Scatterplot"
  )

# r squared value
employment2.lm <- lm(as.numeric(Employment..Agriculture....of.employed.) ~ Happiness.Score, data = employment_df)
employment2_r_squared <- summary(employment2.lm)$r.squared

# Scatterplot of Employment in Industry vs. Happiness
ggplot(employment_df, aes(x = Employment..Industry....of.employed., y = Happiness.Score, color = Happiness.Rank, na.rm = TRUE)) +
  geom_point(shape = 19, size = 5) +
  stat_smooth(method = "lm", col = "black") +
  theme_light() +
  scale_color_gradient("Happiness Rank", low = "limegreen", high = "black", na.value = "white") +
  labs(
    x = "Employed in Industry",
    y = "Happiness Score",
    Title = "Industry Employment vs Happiness Score Scatterplot"
  )

# r squared value
employment3.lm <- lm(as.numeric(Employment..Industry....of.employed.) ~ Happiness.Score, data = employment_df)
employment3_r_squared <- summary(employment3.lm)$r.squared

# Scatterplot of Employment in Services vs. Happiness
ggplot(employment_df, aes(x = Employment..Services....of.employed., y = Happiness.Score, color = Happiness.Rank, na.rm = TRUE)) +
  geom_point(shape = 19, size = 5) +
  stat_smooth(method = "lm", col = "black") +
  theme_light() +
  scale_color_gradient("Happiness Rank", low = "limegreen", high = "black", na.value = "white") +
  labs(
    x = "Employed in Services",
    y = "Happiness Score",
    Title = "Services Employment vs Happiness Score Scatterplot"
  )

# r squared value
employment4.lm <- lm(as.numeric(Employment..Services....of.employed.) ~ Happiness.Score, data = employment_df)
employment4_r_squared <- summary(employment4.lm)$r.squared


# heat map

#-----------------------------------------------------------------------------------------------------------------------
