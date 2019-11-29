# DF Manipulation Document


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


#GPD DF
gdp_only_df <- happy_df %>% select(contains("GDP"))
gdp_happy_df <- happy_df %>%
  select(2:4) %>%
  bind_cols(gdp_only_df)

#Health DF
health_df <- happy_df %>%
  select(Country, Happiness.Score, Happiness.Rank,
         Health..Life.Expectancy.) %>%
  arrange(desc(Health..Life.Expectancy.))

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



