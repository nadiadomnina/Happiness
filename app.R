
library(shiny)

source("group_ui.R")
source("group_server.R")

# Start running the application
shinyApp(ui = my_ui, server = my_server)
