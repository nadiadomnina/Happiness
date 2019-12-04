source("analysis_2.R")
library(shinyWidgets)

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
          "2. write about what the happiness scores are, where they come from, how theyre calculated in the Background Information panel", br(),
          strong("3. everyone needs to fill out the last about page!!!!!!!"), br(),
          strong("4. Economy analysis"), br(),
          "3. Andrey said we should consider adding more interactivity on the maps. For example by displaying only
      a certain continent at a time or something. I think it would be nice to display the top 10 countries,
      then those ranked 11-20, 21-30, and so on, you get my point.", br(),
          "7. maybe add photos of us to the last page if we have the time", br(),
          "8. make the analysis more reader - friendly.", br(),
          "9. Add labels to plots. What does .75 life expectancy mean? thaose things"
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
              "Government Trust" = 5
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
          p("In GDP per Capita scatterplot, we found R-squared vale of 0.66 with the independent variable of GDP per Capita is associated with dependent variable of Happiness Score.
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
          p("In Health and Life expectancy scatterplot, we found R-squared value of 0.61 with the independent variable of Health and Life expectancy is associated with dependent variable of Happiness score.
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
          style = "background:white",
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
          style = "background:white",
          plotOutput("economy_plot")
        ),

        wellPanel(
          style = "background:pink",
          textOutput("economy_analysis")
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
          style = "background:white",
          plotOutput("trust_plot") # reactive output provided by leaflet
        ),
        wellPanel(
          style = "background:#AB82FF",
          p(strong("R-Squared:"), gov_trust_r_squared)
        ),
        wellPanel(
          style = "background:white",
          p("In Government trust scatterplot, we found R-squared value of 0.18 with the independent variable of Government trust which have low association with Happiness score. 
                      This represents government trust does not have any correlation with Happiness score.")
        )
      )
    )
  )
)


research_question_page <- tabPanel(
  "Information", # label for the tab in the navbar

  # This content uses a column layouut
  fluidRow(
    column(10, 
      mainPanel(
        h2("Background Information:"),
        wellPanel(
          p("Happiness scores and rankings are from the Gallup World Poll data over different countries. Happiness scores are based on answer evaluation question such as rate individual’s current lives on scale between 0 to 10. 
            The scores are nationally representative samples between years 2013 to 2016 in six factors of economic production, social support, life expectancy, freedom, absence of corruption, and generosity. 
            We also combined this Happiness scores with UN data that shows more characteristics of different countries such as GDP, economy, employment, population growth rate, etc. We used these data to integrate several factors to answer our research question below. 
            We used coefficient of determination, denoted R squared, to analyze how dependent variable of factors can correlate to the independent variable of Happiness score.", style = "font-size:20px")
        ),
      
        h2("Research Question:"),
        wellPanel(
          p("What effect do different country characteristics have on people's happiness?
            Is country happiness calculated based on the same characteristics as other countries,
            or does each country have a different set of characteristics leading to its happiness", style = "font-size:20px")
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
          strong("Major/ Intended Major:"),
          p("Intended Double Major in Informatics and Economics")
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
          strong("Major/ Intended Major:"),
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
