
# ______________________
# Define UI for Application




main_page <- tabPanel(
  "Main", # label for the tab in the navbar
  titlePanel("Main Page"), # show with a displayed title
  # This content uses a sidebar layout
  titlePanel("What Makes Us Happy?"),
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      p("To do:
              1)make the drop down menu actually display different results
              2) figure out whats wrong with the maps,"),
      p("Can you guess which category impacts happiness the most?"),
      p("Select different categories from the drop down menu to aid your guess"),
      
      selectInput(
        inputId = "variable",
        label = "Please select a category",
        choices = c("Happiness Scores", "GDP", "Health",
                    "Economy", "Government Tust")
      )
    ),
    mainPanel(
      
      plotOutput("map")
    )
  ))


page_one <- tabPanel(
  "GDP", # label for the tab in the navbar
  titlePanel("GDP"), # show with a displayed title
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      p("Testing to see if this works?")
    ),
    mainPanel(
      plotOutput("gdp_plot"), # reactive output provided by leaflet
      plotOutput("gdp_heat_map")
    )
  )
)


page_two <- tabPanel(
  "Health", # label for the tab in the navbar
  titlePanel("Health"), # show with a displayed title
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      p("To Do: fix the color scale label. its not showing happiness scores.")
    ),
    mainPanel(
      plotOutput("health_plot"), # reactive output provided by leaflet
      plotOutput("health_heat_map")
    )
  )
)


page_three <- tabPanel(
  "Economy", # label for the tab in the navbar
  titlePanel("Economy"), # show with a displayed title
  
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      p("To Do:
              1) fix the color scale label. its not showing happiness scores.
              2) make a map of the category with the highest r squared value"),
      selectInput(
        inputId = "variable",
        label = "Title of sidebar",
        choices = c("own_choices")
      )
    ),
    mainPanel(
      plotOutput("economy_plot1"),
      plotOutput("economy_plot2"),
      plotOutput("economy_plot3"),
      plotOutput("economy_plot4")
    )
  )
)


page_four <- tabPanel(
  "Government Trust", # label for the tab in the navbar
  titlePanel("Government Trust"), # show with a displayed title
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      p("To Do: fix the color scale label. its not showing happiness scores.")
    ),
    mainPanel(
      plotOutput("trust_plot"), # reactive output provided by leaflet
      plotOutput("trust_heat_map")
    )
  )
)



research_question_page <- tabPanel(
  "Information", # label for the tab in the navbar
  
  # This content uses a column layouut
  fluidRow(
    column(10,      mainPanel(
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
    column(10,
           mainPanel(
             wellPanel("talk about which factor turned out to be most
                      relevant to happiness and inferenes about why
                      and how this information can help people")
           ))
  )
)



about_us_page <- tabPanel(
  "About Us", # label for the tab in the navbar
  titlePanel("The Team"), # show with a displayed title
  
  # This content uses a column layouut
  fluidRow(
    column(10,
           mainPanel(
             
             # Nadia
             wellPanel(
               h2("Nadia Domnina"),
               p("insert info about me")
             ),
             
             # Vinay
             wellPanel(
               h2("Vinay Patel"),
               p("insert info about me")
             ),
             
             # Hanna
             wellPanel(
               h2("Hanna Song"),
               p("insert info about me")
             ),
             
             # Vincent
             wellPanel(
               h2("Vincent Vo"),
               p("insert info about me")
             )
           ))
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






