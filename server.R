library(shiny)
library(rCharts)
library(markdown)

source("calculations.R")


shinyServer(
  function(input, output) {

    values <- reactiveValues()
    
    dataEqsbyYear <- reactive({groupbyYear(data, input$timeframe[1], input$timeframe[2])})
    dataEqsbyRegion <- reactive({groupbyRegion(data, input$timeframe[1], input$timeframe[2], input$select[1])})
    dataTsunamiesbyRegion <- reactive({groupTsunamiesbyRegion(data, input$timeframe[1], input$timeframe[2], input$select[1])})
    
    output$EqsByYear <- renderChart({plotEqsbyYear(dataEqsbyYear())})
    output$EqsbyRegion <- renderChart({plotEqsbyRegion(dataEqsbyRegion())})
    output$TsunamiesbyRegion <- renderChart({plotTsunamiesbyRegion(dataTsunamiesbyRegion())})
    
  }
)
