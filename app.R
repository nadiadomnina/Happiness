
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


# ______________________
# Define UI for Application




main_page <- tabPanel(
  "Main", # label for the tab in the navbar
  # show with a displayed title
  # This content uses a sidebar layout
  titlePanel("What Makes Us Happy?"),

  p("WHAT NEEDS TO GET DONE EVERYWHERE:"),
  p("1.Split up code documents so that we can source() different documents as opposed to having EVERYTHING in the app.R"),
  p("2.Make the pull down tabs work on the Main page and on the Employment page"),
  p("3.Add unit labels into all graphs. "),
  p("4.fill in the missing pieces within all pages"),


  fluidRow(
    column(
      12,
      mainPanel(
        wellPanel(
          p("insert brief intro paragraph here")
        ),

        wellPanel(
          selectInput(
            inputId = "category",
            label = "Pick a Category to View",
            choices = c(
              "Happiness Scores",
              "GDP",
              "Health",
              "Economy",
              "Government Tust"
            ),
          ),

          wellPanel(
            p("choice of rendered map goes here"),
            plotOutput("world_happy_map"),
            plotOutput("gdp_heat_map"),
            plotOutput("health_heat_map"),
            plotOutput("trust_heat_map"),
            p("need to create a heat map for employment")
          ),
        )
      )
    )
  )
)





page_one <- tabPanel(
  "GDP", # label for the tab in the navbar
  titlePanel("      GDP"), # show with a displayed title



  fluidRow(
    column(
      12,
      mainPanel(
        wellPanel(
          plotOutput("gdp_plot") # reactive output provided by leaflet
        ),
        wellPanel(
          p("insert findings and r sqaured value here")
        )
      )
    )
  )
)


page_two <- tabPanel(
  "Health", # label for the tab in the navbar
  titlePanel("Health"), # show with a displayed title
  # This content uses a sidebar layout

  fluidRow(
    column(
      12,
      mainPanel(
        wellPanel(
          plotOutput("health_plot") # reactive output provided by leaflet
        ),
        wellPanel(
          p("insert findings and r sqaured value here")
        )
      )
    )
  )
)

page_three <- tabPanel(
  "Economy", # label for the tab in the navbar
  titlePanel("Economy"), # show with a displayed title


  fluidRow(
    column(
      12,
      mainPanel(
        wellPanel(
          selectInput(
            inputId = "variable",
            label = "Pick a Category to View",
            choices = c(
              "% Unemployed Labor Force vs. Happiness Score",
              "% Employed in Agriculture vs. Happiness Score",
              "% Employed in Industry vs. Happiness Score",
              "% Employed in Services vs. Happiness Score"
            )
          ),



          wellPanel(
            plotOutput("economy_plot1"),
            plotOutput("economy_plot2"),
            plotOutput("economy_plot3"),
            plotOutput("economy_plot4")
          ),
          wellPanel(
            p("insert findings and r sqaured value here")
          )
        )
      )
    )
  )
)






page_four <- tabPanel(
  "Government Trust", # label for the tab in the navbar
  titlePanel("Government Trust"), # show with a displayed title




  fluidRow(
    column(
      12,
      mainPanel(
        wellPanel(
          plotOutput("trust_plot") # reactive output provided by leaflet
        ),
        wellPanel(
          p("insert findings and r sqaured value here")
        )
      )
    )
  )
)


research_question_page <- tabPanel(
  "Information", # label for the tab in the navbar

  # This content uses a column layouut
  fluidRow(
    column(10, mainPanel(
      h2("Background Information:"),
      wellPanel("insert background info here"),
      h2("Research Question:"),
      wellPanel("insert research question here")
    ))
  )
)




conclusion_page <- tabPanel(
  "Conclusions", # label for the tab in the navbar
  titlePanel("Conclusions"), # show with a displayed title

  # This content uses a column layouut
  fluidRow(
    column(
      10,
      mainPanel(
        wellPanel("talk about which factor turned out to be most
                      relevant to happiness and inferenes about why
                      and how this information can help people")
      )
    )
  )
)



about_us_page <- tabPanel(
  "About Us", # label for the tab in the navbar
  titlePanel("The Team"), # show with a displayed title

  # This content uses a column layouut
  fluidRow(
    column(
      10,
      mainPanel(

        # Nadia
        wellPanel(
          h2("Nadia Domnina"),
          strong("Graduation Year:"),
          p("2022"),
          strong("Major:"),
          p("Industrial Design"),
          strong("Personal Statement:"),
          p("insert here")
        ),

        # Vinay
        wellPanel(
          h2("Vinay Patel"),
          strong("Graduation Year:"),
          p("insert here"),
          strong("Major/ Intended Major:"),
          p("insert here"),
          strong("Personal Statement:"),
          p("insert here")
        ),

        # Hanna
        wellPanel(
          h2("Hanna Song"),
          strong("Graduation Year:"),
          p("insert here"),
          strong("Major/ Intended Major:"),
          p("insert here"),
          strong("Personal Statement:"),
          p("insert here")
        ),

        # Vincent
        wellPanel(
          h2("Vincent Vo"),
          strong("Graduation Year:"),
          p("insert here"),
          strong("Major/ Intended Major:"),
          p("insert here"),
          strong("Personal Statement:"),
          p("insert here")
        )
      )
    )
  )
)






my_ui <- navbarPage(
  "Happiness Report", # application title
  main_page,
  research_question_page,
  page_one,
  page_two,
  page_three,
  page_four,
  conclusion_page,
  about_us_page
)










# Server


my_server <- function(input, output) {
  # DF Manipulation

  # main DATAFRAME
  happy_df <- read.csv("data/happy_df.csv", stringsAsFactors = FALSE)

  # Trust DATAFRAME
  gov_trust_df <- happy_df %>%
    select(
      Country, Happiness.Score, Happiness.Rank, Freedom,
      Trust..Government.Corruption.
    ) %>%
    arrange(desc(Trust..Government.Corruption.))
  gov_trust_df$Country[gov_trust_df$Country == "United States"] <- "USA"

  # GPD DATAFRAME
  gdp_only_df <- happy_df %>% select(contains("GDP"))
  gdp_happy_df <- happy_df %>%
    select(2:4) %>%
    bind_cols(gdp_only_df)
  gdp_happy_df$Country[gdp_happy_df$Country == "United States"] <- "USA"

  # Health DATAFRAME
  health_df <- happy_df %>%
    select(
      Country, Happiness.Score, Happiness.Rank,
      Health..Life.Expectancy.
    ) %>%
    arrange(desc(Health..Life.Expectancy.))
  health_df$Country[health_df$Country == "United States"] <- "USA"


  # ECONOMY dataframe
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
    ggplot(
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
  })
  output$trust_heat_map <- renderPlot({
    ggplot(world_shape) +
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
  })











  output$gdp_plot <- renderPlot({
    ggplot(
      gdp_happy_df,
      aes(
        x = Economy..GDP.per.Capita.,
        y = Happiness.Score,
        color = Happiness.Rank
      )
    ) +
      geom_point(shape = 19, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank",
        low = "limegreen",
        high = "black", na.value = "white"
      ) +
      labs(
        x = "GDP per Capita",
        y = "Happiness Score",
        Title = "GDP vs Happiness Score Scatterplot"
      )
  })
  output$gdp_heat_map <- renderPlot({
    ggplot(gdp_world_shape) +
      geom_polygon(
        mapping = aes(
          x = Longitude, y = Latitude, group = group,
          fill = Economy..GDP.per.Capita.
        ),
        color = "gray", # show country outlines
        size = .1 # thinly stroked
      ) +
      coord_map() + # use a map-based coordinate system
      scale_fill_gradient(
        low = "black", high = "lightskyblue",
        na.value = "white"
      ) +
      labs(
        fill = "GDP Per Capita",
        title = "World Map: GDP per Capita "
      )
  })
  output$health_plot <- renderPlot({
    ggplot(health_df, aes(
      x = Health..Life.Expectancy.,
      y = Happiness.Score, color = Happiness.Rank
    )) +
      geom_point(shape = 20, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank",
        low = "yellow",
        high = "Red"
      ) +
      labs(
        x = "Health & Life Expectancy",
        y = "Happiness Score",
        Title = "Health & Life Expectancy vs Happiness Score Scatterplot"
      )
  })
  output$health_heat_map <- renderPlot({
    ggplot(health_world_shape) +
      geom_polygon(
        mapping = aes(
          x = Longitude, y = Latitude, group = group,
          fill = Health..Life.Expectancy.
        ),
        color = "black"
      )
  })

  output$health_plot <- renderPlot({
    ggplot(health_df, aes(
      x = Health..Life.Expectancy.,
      y = Happiness.Score,
      color = Happiness.Rank
    )) +
      geom_point(shape = 20, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank",
        low = "yellow",
        high = "Red"
      ) +
      labs(
        x = "Health & Life Expectancy",
        y = "Happiness Score",
        Title = "Health & Life Expectancy vs Happiness Score Scatterplot"
      )
  })


  output$health_heat_map <- renderPlot({
    ggplot(health_world_shape) +
      geom_polygon(
        mapping = aes(
          x = Longitude, y = Latitude, group = group,
          fill = Health..Life.Expectancy.
        ),
        color = "gray",
        size = .1
      ) +
      coord_map() +
      scale_fill_continuous(
        low = "#132B43", high = "Red",
        na.value = "white"
      ) +
      labs(
        fill = "Health & Life expectancy",
        title = "Map of Health & Life expectancy"
      )
  })

  output$world_happy_map <- renderPlot({
    ggplot(world_shape) +
      geom_polygon(
        mapping = aes(
          x = Longitude, y = Latitude, group = group,
          fill = Happiness.Score
        ),
        color = "gray", # show country outlines
        size = .1 # thinly stroked
      ) +
      coord_map() + # use a map-based coordinate system
      scale_fill_gradient(
        low = "black", high = "greenyellow",
        na.value = "white"
      ) +
      labs(
        fill = "Happiness Score",
        title = "World Map: of Happiness Scores"
      )
  })
  output$economy_plot1 <- renderPlot({
    ggplot(
      employment_df,
      aes(
        x = as.numeric(Unemployment....of.labour.force.),
        y = Happiness.Score, color = Happiness.Rank,
        na.rm = TRUE
      )
    ) +
      geom_point(shape = 19, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank",
        low = "limegreen",
        high = "black", na.value = "white"
      ) +
      # scale_x_discrete("Unemployed Labor Force", seq(-100, 100, 50),
      # seq(-100, 100, 50), c(-100, 100)) +
      labs(
        x = "Unemployed Labor Force",
        y = "Happiness Score",
        Title = "Unemployment Rate vs Happiness Score Scatterplot"
      )
  })
  output$economy_plot2 <- renderPlot({
    ggplot(employment_df, aes(
      x = Employment..Agriculture....of.employed.,
      y = Happiness.Score, color = Happiness.Rank,
      na.rm = TRUE
    )) +
      geom_point(shape = 19, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank",
        low = "limegreen",
        high = "black", na.value = "white"
      ) +
      labs(
        x = "Employed in Agriculture",
        y = "Happiness Score",
        Title = "Agriculture Employment vs Happiness Score Scatterplot"
      )
  })
  output$economy_plot3 <- renderPlot({
    ggplot(employment_df, aes(
      x = Employment..Industry....of.employed.,
      y = Happiness.Score, color = Happiness.Rank,
      na.rm = TRUE
    )) +
      geom_point(shape = 19, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank",
        low = "limegreen",
        high = "black", na.value = "white"
      ) +
      labs(
        x = "Employed in Industry",
        y = "Happiness Score",
        Title = "Industry Employment vs Happiness Score Scatterplot"
      )
  })
  output$economy_plot4 <- renderPlot({
    ggplot(employment_df, aes(
      x = Employment..Services....of.employed.,
      y = Happiness.Score, color = Happiness.Rank,
      na.rm = TRUE
    )) +
      geom_point(shape = 19, size = 5) +
      stat_smooth(method = "lm", col = "black") +
      theme_light() +
      scale_color_gradient("Happiness Rank",
        low = "limegreen",
        high = "black", na.value = "white"
      ) +
      labs(
        x = "Employed in Services",
        y = "Happiness Score",
        Title = "Services Employment vs Happiness Score Scatterplot"
      )
  })
}



# Start running the application
shinyApp(ui = my_ui, server = my_server)