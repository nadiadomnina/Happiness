

# ______________________
# Define UI for Application

#test <- file.choose("data/happy_df.csv")
#happy_df <- read.csv(test)


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
                    p("Investigating possible causes of happiness and lack of happiness around the world.")
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
                    plotOutput("gdp_plot") # reactive output provided by leaflet
                ),
                wellPanel(
                    p("In GDP per Capita scatterplot, we found R-squared vale of 0.66 with the independent variable of GDP per Capita is associated with dependent variable of Happiness Score.
                    This represents GDP per Capita has 66 percent of an acceptable correlation with Happiness score that shows GDP per Capita can determine Happiness of people. ")
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
                        p("For economy, we found four different scatterplot of unemployed labor force, employed in agriculture, employed in industry, and employed in services. These independent variables of different work fields have different R-squared value. 
                        For unemployed labor force, (error)
                        For employed in agriculture, we found R-squared value of 0.56 with the independent variable of employed in agriculture associated with Happiness score. This represents employed in agriculture work field has 56 percent of an acceptable correlation with Happiness score. However, our R value of employed in agriculture seems negative that have negative association where people work in agriculture work fields have less happiness score. 
                        For employed in industry, we found R-squared value of 0.19 with the independent variable of employed in industry which have low association with Happiness score. This represents employed in industry has no correlation with happiness of people. 
                        For the last scatterplot, we found R-squared value of 0.58 with the independent variable of employed in service associated with happiness score. This represents employed in service has 58 percent of an acceptable correlation with Happiness score. ")
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
        column(10, mainPanel(
            h2("Background Information:"),
            wellPanel("insert background info here"),
            h2("Research Question:"),
            wellPanel("What effect do different country characteristics have on people's happiness?
                      Is country happiness calculated based on the same characteristics as other countries,
                      or does each country have a different set of characteristics leading to its happiness")
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
                wellPanel("In conclusion, GDP per Capita, and Health and Life expectancy have the most relevant to happiness of people which both have about 60 percent of R-square value.
                 Other than that, employment of individuals also impact on happiness that people in service have the highest correlation of 58 percent between employment of industry, agriculture, service, and unemployment. ")
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







