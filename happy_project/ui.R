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
  h3("Investigating possible causes of happiness and lack of happiness around the world.", br(), br(), ""),



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

  fluidRow(
    column(
      10,
      mainPanel(
        h2("Happiness Scores"),
        h4("What are they?"),
        wellPanel(
          style = "background: white",
          p("Happiness scores and ranking data used in this study originate from the Gallup World Poll data.
          Happiness scores are determined by peoples answers to evaluation questions such as those asking an individual to rank their current lives on a scale between 0 to 10.
          The scores used in this Happiness study are nationally representative samples of all countries of the world in 2017.", br(),
           style = "font-size:18px")
        ),

        h2("Research Question:"),
        h4("What are we trying to learn?"),
        wellPanel(
          style = "background: white",
          p("1. What effect do different country characteristics have on people's happiness?", br(),
            "2. On average, what characteristic has the highest correlation with happiness?",
            style = "font-size:20px"
          )
        ),
        h2("Our Approach:"),
        h4("How will we solve our problem?"),
        wellPanel(
          style = "background: white",

          p( "In our research, we combined the Gallup Happiness data with UN data that shows more characteristics of different countries (such as GDP, economy, employment, population growth rate, etc.).
          We then decided on the most likely categories that can effect happiness, settling on 4 different categories:", br(),
             "1. GDP", br(),
             "2. Health (Life Expectancy)", br(),
             "3. Economy (Employment Characteristics)", br(),
             "4. Trust in Government", br(),
             "We then created scatter plots of data that related to those categories and analyzed the relationship between them and the observed happiness scores.
             We calculated their coefficients of determination (R-squared values) and compared them to each other.",
             style = "font-size:18px")
        )

      )
    )
  )
)






page_one <- tabPanel(
  "GDP", # label for the tab in the navbar

  titlePanel("GDP"), # show with a displayed title

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
          p("In this section we explored the relationshiop between a country's Gross Domestic product(GDP) and their happiness Score.
          There is a clear positive correlation between the two variables.
          A .66 r-squared value isnt ideal, but given such a subjective variable as happiness, it is quite a remarkable one.")
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
          p("In this section we explored the relationship between a country's average Life Expectancy (unit unknown) and their Happiness score.
          The results of this were as expected, the higher the life expecancy, the greater the happiness. The coefficient of determination is 0.61, also showing a positive correaltion.
          This only makes sense, since people who arent in constant fear for their and their family's life can focus on life goals and dreams, making their life more satisfactory.")
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
          style = "background: pink",
          textOutput("economy_r_squared")
        ),

        wellPanel(
          style = "background: white",
          textOutput("economy_r_sqaured"),
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

          style = "background: white",
          p("In this section we explored the relationship between a country's trust in government (unit unknown) and their Happiness score. Although we expected a high correlation between government corruption rates and happiness, our results proved otherwise. The found coefficient of determination
          was only 0.18. This number is too low to be considered valuable, especially given that there are less than 200 samples.
          This shows that government trust does not have a strong correlation with Happiness scores.")
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
          p("Our research concluded that within our world, GDP per Capita controls happiness the most.
          A .66 r-squared value isnt ideal, but given such a subjective variable as happiness, it is quite a remarkable one.
          Seeing that GDP has a clear correlation with happiness is important, giving us insight into the workings of our world. Most of the unhappiest countries
          are located in Africa and the Middle East. These are also the least developed countries. Pairing this knowledge with the fact that underdeveloped countries also tend to have low GDP's,
          may give governments of those countries further motivation to grow, since doing so will make their residents happier individuals.", br(), br(),

          "The second-most relevant category to happiness is life expectancy. This conclusion also makes sense because longer life spans
          mean safer environments and better technology, almost going hand-in hand with GDP.", br(), br(),

          "Other than that, employment of individuals also had a large impact on happiness: we concluded that the percentage of people working in services has a correlation of 58
          percent with happiness scores, a meaningful value. Finally, and surprisingly, trust in government seemed to have
          no correlation with happiness. This result may be due to faulty data, and should be further investigated for more insight.", style = "font-size:20px")
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
  "Ingredients of Happiness", # application title
  main_page,
  research_question_page,
  page_one,
  page_two,
  page_three,
  page_four,
  conclusion_page,
  about_us_page
))
