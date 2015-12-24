library(shiny)
library(rCharts)
library(markdown)

shinyUI(
    navbarPage("NOAA Global Significant Earthquakes",
          tabPanel(p(icon("database"), "Database Explorer"),
            sidebarPanel(
                h3('Data filters:'),
                
                sliderInput("timeframe", 
                            "Timeframe:", 
                            min = 1900,
                            max = 2015,
                            value = c(2000, 2015)),
                
                selectInput("select", label = "Select Region", 
                    choices = list("Central, Western and S. Africa" = 10, 
                                   "Northern Africa" = 15,
                                   "Antarctica" = 20,
                                   "East Asia" = 30,
                                   "Central Asia and Caucasus" = 40,
                                   "Kamchatka and Kuril Islands" = 50,
                                   "S. and SE. Asia and Indian Ocean" = 60,
                                   "Atlantic Ocean" = 70,
                                   "Bering Sea" = 80,
                                   "Caribbean" = 90,
                                   "Central America" = 100,
                                   "Eastern Europe" = 110,
                                   "Northern and Western Europe" = 120,
                                   "Southern Europe" = 130,
                                   "Middle East" = 140,
                                   "North America and Hawaii" = 150,
                                   "South America" = 160,
                                   "Central and South Pacific" = 170
                    ), selected = 60)
            ),
          
            mainPanel(
              tabsetPanel(
                
                tabPanel(p(icon("line-chart"), "Visualizer"),
                    h4('Total Earthquakes by Year', align = "center"),
                    showOutput("EqsByYear", "nvd3"),
                    h4('Total Earthquakes by Region', align = "center"),
                    showOutput("EqsbyRegion", "nvd3"),
                    h4('Total Tsunamies by Region', align = "center"),
                    showOutput("TsunamiesbyRegion", "nvd3")
                )
              )
            )
          ),
            
          tabPanel(p(icon("inbox"), "Documentation"),
              mainPanel(
                includeMarkdown("documentation.md")
              )
          ),
          
          tabPanel(p(icon("info-circle"), "About"),
              mainPanel(
                includeMarkdown("about.md")
                   )
          )
          
    )
)
