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
      menuItem("Results", tabName = "IF", icon = icon("Important Findings"))
      
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
                fileInput('TextFile', 'Choose Text file to upload',
                          accept = c(
                            'text/csv',
                            'text/comma-separated-values',
                            'text/tab-separated-values',
                            'text/plain'
                          )
                ),
                tags$hr(),
                numericInput('Gross_Margin_IN','Enter expected Gross Margin',value=1),
                tags$hr(),
                selectInput("Geographical_Region_IN", "Select country",
                            c("APA"="APA","CEU"="CEU","CIN"="CIN","CSI"="CSI","FRA"="FRA",
                              "IAM"="IAM","ITA"="ITA"
                              ,"NAM"="NAM","SAM"="SAM","SCA"="SCA","UKE"="UKE")),
                tags$hr(),
                selectInput("Customer_Class_IN", "Select Customer Class",
                            c("Nationals"="Nationals","Others"="Others","Strategic"="Strategic")),
                tags$hr(),
                selectInput("Turnover_Range_IN", "Select Turnover Range",
                            c("a 0-20"="a 0-20","b 20-100"="b 20-100","c 100-250"="c 100-250",
                              "d 250-500"="d 250-500","e >500"="e >500","Strategic","Strategic")),
                tags$hr(),
                selectInput("Plant_IN", "Select Plant Location",
                            c("Brasil"="Brasil","China"="China","FRA"="FRA","IND"="IND",
                              "Northern"="Northern","Italy"="Italy",
                              "Southern"="Southern","Italy"="Italy","Spain"="Spain","UK"="UK","USA"="USA")),
                tags$hr(),
                textInput('Product_Line_IN','Enter Product Line',value="Springs"),
                tags$hr(),
                textInput('Product_Type_IN','Enter Product Line',value="Air Springs"),
                tags$hr(),
                infoBoxOutput("Load_Info"),
                textOutput("MLOP")
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

options(shiny.maxRequestSize=30*1024^2)
server <- function(input, output) {
  
  data_l<-reactive({
    inFile <- input$TextFile
    if (is.null(inFile))
      return(NULL)
    data<-read.csv(inFile$datapath,header=T)
    data<-data[,-1]
    return(data)
  })
  
  
  output$Load_Info <- renderInfoBox({
    
    print("2")
    infoBox("Machine has thought  : ", icon = icon("thumbs-up", lib = "glyphicon"),color = "blue")
  })  
  
  output$MLOP <- renderText({
    dat<-data_l()
    mlr<-lm(Cost_of_Goods_Sold_EURO~Gross_Margin+Geographical_Area
            +Customer_Class+Turnover_Range_EURO+Plant+Product_Line+Product_Type,dat=dat)
    summary(mlr)
    a<-predict(mlr,newdata=data.frame(Gross_Margin=input$Gross_Margin_IN,
                                      Geographical_Area=input$Geographical_Region_IN,
                                      Customer_Class=input$Customer_Class_IN,
                                      Turnover_Range_EURO=input$Turnover_Range_IN,
                                      Plant=input$Plant_IN,
                                      Product_Line=input$Product_Line_IN,
                                      Product_Type=input$Product_Type_IN))
    a<-toString(a)
    paste("Total cost would be: ",a)
    
    
  })
  
  output$hd <- renderDataTable(data_l())
  
}
shinyApp(ui, server)