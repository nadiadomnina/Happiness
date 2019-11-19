
library(shiny)

source("group_ui.R")
source("group_server.R")

# Start running the application
shinyApp(ui = group_ui, server = group_server)
