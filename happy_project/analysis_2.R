# DF Manipulation Document
library(dplyr)
library(stringr)
library("knitr")
library(tidyr)
library(ggplot2)
library(maps)
library(leaflet)
library(ggpmisc)
library(plotly)
library(rworldmap)
library(fields)
library(mapproj)

#read in the data 
happy_df <- read.csv("data/happy_df.csv", stringsAsFactors = FALSE)

#change United States to USA for future joining reasons
  happy_df$Country[happy_df$Country == "United States"] = "USA"

#combine the world shape data with the happy_df
world_shape = map_data(map = "world") %>%
    rename(Country = region) %>%
    full_join(happy_df, by = "Country") %>%
    rename(
      Longitude = long,
      Latitude = lat
    )

#GOVERNMENT DF
gov_trust_df <- happy_df %>%
  select(Country, Happiness.Score, Happiness.Rank, Freedom,
         Trust..Government.Corruption.) %>%
  arrange(desc(Trust..Government.Corruption.))

#r sqaured
gov_trust.lm <- lm(Happiness.Score ~ Trust..Government.Corruption., data = gov_trust_df)
gov_trust_r_squared <- summary(gov_trust.lm)$r.squared


#GPD DF
gdp_only_df <- happy_df %>% select(contains("GDP"))
gdp_happy_df <- happy_df %>%
  select(2:4) %>%
  bind_cols(gdp_only_df)

#r sqaured
gdp.lm <- lm(Economy..GDP.per.Capita. ~ Happiness.Score, data = gdp_happy_df)
gdp_r_squared <- summary(gdp.lm)$r.squared

#Health DF
health_df <- happy_df %>%
  select(Country, Happiness.Score, Happiness.Rank,
         Health..Life.Expectancy.) %>%
  arrange(desc(Health..Life.Expectancy.))

# r squared value
health.lm <- lm(Health..Life.Expectancy. ~ Happiness.Score, data = health_df)
health_r_squared <- summary(health.lm)$r.squared

#Employment DF
employment_df <- happy_df %>%
  mutate(Employment..Agriculture....of.employed. =
           ifelse(Employment..Agriculture....of.employed. >= 0,
                  Employment..Agriculture....of.employed., NA),
         Employment..Industry....of.employed. =
           ifelse(Employment..Industry....of.employed. >= 0,
                  Employment..Industry....of.employed., NA),
         Employment..Services....of.employed. =
           ifelse(Employment..Services....of.employed. >= 0,
                  Employment..Services....of.employed., NA),
  )
employment_df <- na.omit(employment_df)

 # employment r squared value 
 # 1.
 employment1.lm = lm(as.numeric(Unemployment....of.labour.force.) ~ Happiness.Score, data=employment_df)
 employment1_r_squared = summary(employment1.lm)$r.squared
 # 2.
 employment2.lm <- lm(as.numeric(Employment..Agriculture....of.employed.) ~ Happiness.Score, data = employment_df)
 employment2_r_squared <- summary(employment2.lm)$r.squared
 # 3.
 employment3.lm <- lm(as.numeric(Employment..Industry....of.employed.) ~ Happiness.Score, data = employment_df)
 employment3_r_squared <- summary(employment3.lm)$r.squared
 # 4. Highest
 employment4.lm <- lm(as.numeric(Employment..Services....of.employed.) ~ Happiness.Score, data = employment_df)
 employment4_r_squared <- summary(employment4.lm)$r.squared
 
 




