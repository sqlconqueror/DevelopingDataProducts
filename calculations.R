library(rCharts)
library(data.table)
library(dplyr)
library(markdown)

eqs <- fread("data\\signif.txt", sep = "\t", header = TRUE)
regions <- read.csv("data\\regions.csv", header = TRUE)

eqs <- filter(eqs, YEAR >= 1900)
eqs <- select(eqs, I_D:YEAR, FOCAL_DEPTH, EQ_PRIMARY, INTENSITY:REGION_CODE, TOTAL_DEATHS)

eqs$FLAG_TSUNAMI <- ifelse(eqs$FLAG_TSUNAMI == "Tsu", 1, 0)

data <- merge(eqs,regions, by = "REGION_CODE")


# data set groups

groupbyYear <- function(dt, minYear, maxYear) {
  result <- dt %>% 
    filter(YEAR >= minYear, YEAR <= maxYear) %>% 
    group_by(YEAR) %>% 
    summarise(Earthquakes = n()) %>%
    arrange(YEAR)
  return(result)
}

groupbyRegion <- function(dt, minYear, maxYear, rCode) {
  result <- dt %>% 
    filter(YEAR >= minYear, YEAR <= maxYear, REGION_CODE == rCode) %>% 
    group_by(YEAR, REGION_CODE, REGION_NAME) %>% 
    summarise(Earthquakes = n()) %>%
    arrange(YEAR, REGION_CODE)
  return(result)
}

groupTsunamiesbyRegion <- function(dt, minYear, maxYear, rCode) {
  result <- dt %>% 
    filter(YEAR >= minYear, YEAR <= maxYear, REGION_CODE == rCode, FLAG_TSUNAMI == 1) %>% 
    group_by(YEAR) %>% 
    summarise(Tsunami = n()) %>%
    arrange(YEAR)
  return(result)
}

# plot handlers

plotEqsbyYear <- function(dt, dom = "EqsByYear", 
                                xAxisLabel = "Year",
                                yAxisLabel = "Total Earthquakes") {
  EqsByYear <- nPlot(
    Earthquakes ~ YEAR,
    data = dt,
    type = "multiBarChart",
    dom = dom, width = 650
  )
  EqsByYear 
}

plotEqsbyRegion <- function(dt, dom = "EqsbyRegion", 
                          xAxisLabel = "Year",
                          yAxisLabel = "Total Earthquakes") {
  EqsbyRegion <- nPlot(
    Earthquakes ~ YEAR,
    data = dt,
    type = "multiBarChart",
    dom = dom, width = 650
  )
  EqsbyRegion 
}

plotTsunamiesbyRegion <- function(dt, dom = "TsunamiesbyRegion", 
                            xAxisLabel = "Year",
                            yAxisLabel = paste("Total Tsunamies",REGION_NAME)) {
  TsunamiesbyRegion <- nPlot(
    Tsunami ~ YEAR,
    data = dt,
    type = "stackedAreaChart",
    dom = dom, width = 650
  )
  TsunamiesbyRegion 
}
