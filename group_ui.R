
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







