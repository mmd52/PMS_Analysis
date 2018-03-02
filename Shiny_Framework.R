# @ Author MMD
# Date 02/03/2018
# Shiny Framework

## app.R ##
library(shinydashboard)
library(plotly)

ui <- dashboardPage(
  dashboardHeader(title = "3X PMS Analysis"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Predictor", tabName = "Predictor", icon = icon("Predictor")),
      menuItem("Important Findings", tabName = "IF", icon = icon("Important Findings"))
      
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # Data Loader Contents =========================================================================================
      tabItem(tabName = "Predictor",tags$style(type="text/css",
                                                 ".shiny-output-error { visibility: hidden; }",
                                                 ".shiny-output-error:before { visibility: hidden; }"),
              fluidPage(":)",fluidRow(
                numericInput('Total_Turnover','Enter expected turnover',value=0),
                tags$hr(),
                textInput('Country','Enter country client is in',value=""),
                tags$hr(),
                infoBoxOutput("Load_Info")
              )
              )
      ),
      tabItem(tabName = "IF",tags$style(type="text/css",
                                            ".shiny-output-error { visibility: hidden; }",
                                            ".shiny-output-error:before { visibility: hidden; }")
              ,dataTableOutput("hd")
              )
              
    )       
      
    
  )
)


server <- function(input, output) {
  
  data_l<-reactive({
    data<-read.csv("FinalPMSData.csv",header=T)
    data<-data[,-1]
    return(data)
  })
  
  output$Load_Info <- renderInfoBox({
    infoBox("Machine is thinking please Wait :) ", icon = icon("thumbs-up", lib = "glyphicon"),color = "blue")
  })    
  
  output$hd <- renderDataTable(data_l())
  
}
shinyApp(ui, server)