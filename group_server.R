
library(shiny)
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

# Server
group_server <- function(input, output) {
  # DF Manipulation
  happy_df <- read.csv("data/happy_df.csv", stringsAsFactors = FALSE)
  # Trust DATAFRAME
  gov_trust_df <- happy_df %>%
    select(Country, Happiness.Score, Happiness.Rank, Freedom,
           Trust..Government.Corruption.) %>%
    arrange(desc(Trust..Government.Corruption.))
  gov_trust_df$Country[gov_trust_df$Country == "United States"] <- "USA"
  #GPD DATAFRAME
  #data frame with country namesm happy rank, and gdp info
  gdp_only_df <- happy_df %>% select(contains("GDP"))
  gdp_happy_df <- happy_df %>%
    select(2:4) %>%
    bind_cols(gdp_only_df)
  gdp_happy_df$Country[gdp_happy_df$Country == "United States"] <- "USA"
  #Health DATAFRAME
  health_df <- happy_df %>%
    select(Country, Happiness.Score, Happiness.Rank,
           Health..Life.Expectancy.) %>%
    arrange(desc(Health..Life.Expectancy.))
  health_df$Country[health_df$Country == "United States"] <- "USA"
  #Economy dataframe
  
  
  # DATA FRAMES
  happy_df <- read.csv("data/happy_df.csv", stringsAsFactors = FALSE)
  
  # TRUST dataframe
  gov_trust_df <- happy_df %>%
    select(Country, Happiness.Score, Happiness.Rank, Freedom,
           Trust..Government.Corruption.) %>%
    arrange(desc(Trust..Government.Corruption.))
  gov_trust_df$Country[gov_trust_df$Country == "United States"] <- "USA"
  
  #GPD dataframe
  #data frame with country namesm happy rank, and gdp info
  gdp_only_df <- happy_df %>%
    select(contains("GDP"))
  
  gdp_happy_df <- happy_df %>%
    select(2:4) %>%
    bind_cols(gdp_only_df)
  gdp_happy_df$Country[gdp_happy_df$Country == "United States"] <- "USA"
  
  #HEALTH dataframe
  health_df <- happy_df %>%
    select(Country, Happiness.Score, Happiness.Rank,
           Health..Life.Expectancy.) %>%
    arrange(desc(Health..Life.Expectancy.))
  health_df$Country[health_df$Country == "United States"] <- "USA"
  
  #ECONOMY dataframe
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
  
  # WORLD MAP dataframes
  world_shape <- map_data(map = "world") %>%
    rename(Country = region) %>%
    full_join(gov_trust_df, by = "Country") %>%
    rename(
      Longitude = long,
      Latitude = lat
    )
  gdp_world_shape <- map_data(map = "world") %>%
    rename(Country = region) %>%
    full_join(gdp_happy_df, by = "Country") %>%
    rename(
      Longitude = long,
      Latitude = lat
    )
  health_world_shape <- map_data(map = "world") %>%
    rename(Country = region) %>%
    full_join(health_df, by = "Country") %>%
    rename(
      Longitude = long,
      Latitude = lat
    )
  # Define a map to render in the UI
  output$trust_plot <- renderPlot({
    ggplot(gov_trust_df,
           aes(x = Trust..Government.Corruption.,
               y = Happiness.Score,
               color = Freedom)) +
      geom_point(shape = 20, size = 4) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Degree of Country Freedom",
                           low = "grey", high = "purple2") +
      labs(x = "Government Trust",
           y = "Happiness Score",
           Title = "Happiness Score vs. Gov. Trust Scatterplot")
  })
  output$trust_heat_map <- renderPlot({
    ggplot(world_shape) +
      geom_polygon(
        mapping = aes(x = Longitude, y = Latitude, group = group,
                      fill = Trust..Government.Corruption.),
        color = "gray",
        size = .1
      ) +
      coord_map() +
      scale_fill_continuous(low = "#431338", high = "431338",
                            na.value = "white") +
      labs(fill = "Percent of Corruption",
           title = "Percent of Corruption in each Country, 2017")
  })
  output$gdp_plot <- renderPlot({
    ggplot(gdp_happy_df,
           aes(x = Economy..GDP.per.Capita.,
               y = Happiness.Score,
               color = Happiness.Rank)) +
      geom_point(shape = 19, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank", low = "limegreen",
                           high = "black", na.value = "white") +
      labs(x = "GDP per Capita",
           y = "Happiness Score",
           Title = "GDP vs Happiness Score Scatterplot")
  })
  output$gdp_heat_map <- renderPlot({
    ggplot(gdp_world_shape) +
      geom_polygon(
        mapping = aes(x = Longitude, y = Latitude, group = group,
                      fill = Economy..GDP.per.Capita.),
        color = "gray", # show country outlines
        size = .1 # thinly stroked
      ) +
      coord_map() + # use a map-based coordinate system
      scale_fill_gradient(low = "black", high = "lightskyblue",
                          na.value = "white") +
      labs(
        fill = "GDP Per Capita",
        title = "World Map: GDP per Capita "
      )
  })
  output$health_plot <- renderPlot({
    ggplot(health_df, aes(x = Health..Life.Expectancy.,
                          y = Happiness.Score, color = Happiness.Rank)) +
      geom_point(shape = 20, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank", low = "yellow",
                           high = "Red") +
      labs(x = "Health & Life Expectancy",
           y = "Happiness Score",
           Title = "Health & Life Expectancy vs Happiness Score Scatterplot")
  })
  output$health_heat_map <- renderPlot({
    ggplot(health_world_shape) +
      geom_polygon(
        mapping = aes(x = Longitude, y = Latitude, group = group,
                      fill = Health..Life.Expectancy.),
        color = "black")
  })
  
  output$health_plot <- renderPlot({
    ggplot(health_df, aes(x = Health..Life.Expectancy.,
                          y = Happiness.Score,
                          color = Happiness.Rank)) +
      geom_point(shape = 20, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank", low = "yellow",
                           high = "Red") +
      labs(x = "Health & Life Expectancy",
           y = "Happiness Score",
           Title = "Health & Life Expectancy vs Happiness Score Scatterplot")
  })
  
  #  if(input$variable == "Health") {
  output$health_heat_map <- renderPlot({
    ggplot(health_world_shape) +
      geom_polygon(
        mapping = aes(x = Longitude, y = Latitude, group = group,
                      fill = Health..Life.Expectancy.),
        color = "gray",
        size = .1
      ) +
      coord_map() +
      scale_fill_continuous(low = "#132B43", high = "Red",
                            na.value = "white") +
      labs(
        fill = "Health & Life expectancy",
        title = "Map of Health & Life expectancy"
      )
  })
  
  output$world_happy_map <- renderPlot({
    ggplot(world_shape) +
      geom_polygon(
        mapping = aes(x = Longitude, y = Latitude, group = group,
                      fill = Happiness.Score),
        color = "gray", # show country outlines
        size = .1 # thinly stroked
      ) +
      coord_map() + # use a map-based coordinate system
      scale_fill_gradient(low = "black", high = "greenyellow",
                          na.value = "white") +
      labs(
        fill = "Happiness Score",
        title = "World Map: of Happiness Scores"
      )
  })
  output$economy_plot1 <- renderPlot({
    ggplot(employment_df,
           aes(x = as.numeric(Unemployment....of.labour.force.),
               y = Happiness.Score, color = Happiness.Rank,
               na.rm = TRUE)) +
      geom_point(shape = 19, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank", low = "limegreen",
                           high = "black", na.value = "white") +
      # scale_x_discrete("Unemployed Labor Force", seq(-100, 100, 50),
      # seq(-100, 100, 50), c(-100, 100)) +
      labs(x = "Unemployed Labor Force",
           y = "Happiness Score",
           Title = "Unemployment Rate vs Happiness Score Scatterplot")
  })
  output$economy_plot2 <- renderPlot({
    ggplot(employment_df, aes(x = Employment..Agriculture....of.employed.,
                              y = Happiness.Score, color = Happiness.Rank,
                              na.rm = TRUE)) +
      geom_point(shape = 19, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank", low = "limegreen",
                           high = "black", na.value = "white") +
      labs(x = "Employed in Agriculture",
           y = "Happiness Score",
           Title = "Agriculture Employment vs Happiness Score Scatterplot")
  })
  output$economy_plot3 <- renderPlot({
    ggplot(employment_df, aes(x = Employment..Industry....of.employed.,
                              y = Happiness.Score, color = Happiness.Rank,
                              na.rm = TRUE)) +
      geom_point(shape = 19, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank", low = "limegreen",
                           high = "black", na.value = "white") +
      labs(x = "Employed in Industry",
           y = "Happiness Score",
           Title = "Industry Employment vs Happiness Score Scatterplot")
  })
  output$economy_plot4 <- renderPlot({
    ggplot(employment_df, aes(x = Employment..Services....of.employed.,
                              y = Happiness.Score, color = Happiness.Rank,
                              na.rm = TRUE)) +
      geom_point(shape = 19, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank", low = "limegreen",
                           high = "black", na.value = "white") +
      labs(x = "Employed in Services",
           y = "Happiness Score",
           Title = "Services Employment vs Happiness Score Scatterplot")
  })
}

