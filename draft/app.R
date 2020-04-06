## Create App
## -----------
pkgs <- c("usethis", "devtools", "rmarkdown", "here", "fs", "data.table", "shiny", "shinydashboard")
sapply(pkgs, require, character.only = TRUE)

ui <- dashboardPage(
    dashboardHeader(title = "Finn Housing"),
    dashboardSidebar(),
    dashboardBody()
)

server <- function(input, output){}

shinyApp(ui, server)
