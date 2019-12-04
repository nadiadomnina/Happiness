source("analysis_2.R")

# ______________________
# Define UI for Application

# test <- file.choose("data/happy_df.csv")
# happy_df <- read.csv(test)


main_page <- tabPanel(
  "Main", # label for the tab in the navbar
  setBackgroundColor(
    color = c("#CCFF99"),
    shinydashboard = FALSE
  ),

  # show with a displayed title
  # This content uses a sidebar layout


  titlePanel("What Makes Us Happy?"),


  wellPanel(
    p(
      "our to-do list:", br(),
      "1. make the analysis more reader - friendly.", br(),
      strong("2. Add labels to plots AND describe the avriables in the analysis. What does .75 life expectancy mean? those things")
    )
  ),

  wellPanel(
    style = "background: white",
    p("Investigating possible causes of happiness and lack of happiness around the world.")
  ),

  # sidebarLayout(
  fluidPage(
    fluidRow(
      column(
        3,

        # sidebarPanel(
        wellPanel(
          radioButtons(
            inputId = "category",
            label = "Pick a Category to View",
            choices = c(
              "Happiness Scores" = 1,
              "GDP" = 2,
              "Health" = 3,
              "Economy" = 4,
              "Government Corruption" = 5
            ),
            selected = 1
          )
        )
      ),
      # mainPanel(
      column(
        9,
        plotlyOutput("heat_map")
      )
    )
  )
)


research_question_page <- tabPanel(
  "Information", # label for the tab in the navbar

  # This content uses a column layouut
  fluidRow(
    column(
      10,
      mainPanel(
        h2("Background Information:"),
        wellPanel(
          style = "background: white",
          p("Happiness scores and rankings are from the Gallup World Poll data over different countries. Happiness scores are based on answer evaluation question such as rate individual’s current lives on scale between 0 to 10. 
            The scores are nationally representative samples between years 2013 to 2016 in six factors of economic production, social support, life expectancy, freedom, absence of corruption, and generosity. 
            We also combined this Happiness scores with UN data that shows more characteristics of different countries such as GDP, economy, employment, population growth rate, etc. We used these data to integrate several factors to answer our research question below. 
            We used coefficient of determination, denoted R squared, to analyze how dependent variable of factors can correlate to the independent variable of Happiness score.
            For scatterplot of each factors based on happiness score from dystopia residual metric which dystopia happiness score of 1.85 which our scatterplots have x values of dystopia residual of each factors,
            and y value of happiness score.
            ", style = "font-size:20px")
        ),

        h2("Research Question:"),
        wellPanel(
          style = "background: white",
          p("1. What effect do different country characteristics have on people's happiness?", br(),
            "2. Is country happiness calculated based on the same characteristics as other countries,
            or does each country have a different set of characteristics leading to its happiness?",
            style = "font-size:20px"
          )
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
          style = "background: white",
          plotOutput("gdp_plot") # reactive output provided by leaflet
        ),
        wellPanel(
          style = "background: lightskyblue",
          p(strong("R-Squared:"), gdp_r_squared)
        ),
        wellPanel(
          style = "background: white",
          p("Under x value of dystopia residual of GDP per Capita, and y value of happiness score, we found R-squared vale of 0.66 with the independent variable of GDP per Capita is associated with dependent variable of Happiness Score.
                    This represents GDP per Capita has 66 percent of an acceptable correlation with Happiness score that shows GDP per Capita can determine Happiness of people. 
                    This further lead government of each countries to understand how GDP of country can affect to individual’s happiness that higher GDP can lead to have higher satisfaction of individuals.")
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
          style = "background: white",
          plotOutput("health_plot") # reactive output provided by leaflet
        ),
        wellPanel(
          style = "background: orange",
          p(strong("R-Squared:"), health_r_squared)
        ),
        wellPanel(
          style = "background: white",
          p("Under x value of dystopia residual of health and life expectancy, and y value of happiness score, we found R-squared value of 0.61 with the independent variable of Health and Life expectancy is associated with dependent variable of Happiness score.
                    This represents Health and Life expectancy has 61 percent of an acceptable correlation with Happiness score which Health and Life expectancy affects Happiness of people. ")
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
          style = "background: white",
          p("For economy, we researched the correlations between Happiness Scores and the following 4 different categories:"),
          radioButtons(
            inputId = "economy_choice",
            label = "Pick a Category to View",
            choices = c(
              "% Unemployed Labor Force vs. Happiness Score" = 1,
              "% Employed in Agriculture vs. Happiness Score" = 2,
              "% Employed in Industry vs. Happiness Score" = 3,
              "% Employed in Services vs. Happiness Score" = 4
            ),
            selected = 2
          )
        ),


        wellPanel(
          style = "background: white",
          plotOutput("economy_plot")
        ),
        wellPanel(
          style = "background: pink",
          textOutput("economy_r_squared")
        ),

        wellPanel(
          style = "background: white",
          textOutput("economy_r_sqaured"),
          textOutput("economy_analysis"),
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
          style = "background: white",
          plotOutput("trust_plot") # reactive output provided by leaflet
        ),
        wellPanel(
          style = "background: #AB82FF",
          p(strong("R-Squared:"), gov_trust_r_squared)
        ),
        wellPanel(
          style = "background: white",
          p("Under x value of dystopia residual of government trust and y value of happiness score, we found R-squared value of 0.18 with the independent variable of Government trust which have low association with Happiness score. 
                      This represents government trust does not have any correlation with Happiness score.")
        )
      )
    )
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
        wellPanel(
          p("In conclusion, GDP per Capita, and Health and Life expectancy have the most relevant to happiness of people which both have about 60 percent of R-square value.
            Other than that, employment of individuals also impact on happiness that people in service have the highest correlation of 58 percent between employment of industry, agriculture, service, and unemployment.", style = "font-size:25px")
        )
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
          p("Industrial Design")
        ),

        # Vinay
        wellPanel(
          h2("Vinay Patel"),
          strong("Graduation Year:"),
          p("2020"),
          strong("Intended Major:"),
          p("Double Major in Informatics and Economics")
        ),

        # Hanna
        wellPanel(
          h2("Hanna Song"),
          strong("Graduation Year:"),
          p("2020"),
          strong("Major/ Minor:"),
          p("Sociology/Statistics")
        ),

        # Vincent
        wellPanel(
          h2("Vincent Vo"),
          strong("Graduation Year:"),
          p("2022"),
          strong("Intended Major:"),
          p("Informatics")
        )
      )
    )
  )
)




shinyUI(navbarPage(
  "Happiness Report", # application title
  main_page,
  research_question_page,
  page_one,
  page_two,
  page_three,
  page_four,
  conclusion_page,
  about_us_page
))