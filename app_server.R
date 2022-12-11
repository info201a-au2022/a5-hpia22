library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)

co2emissions <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Calculate three relevant values of interest

# 1st value of interest
# Annual total CO2 emission and the CO2 growth percentage of every country in the past two decades
co2emissions_two_decades <- co2emissions %>%
  filter(year > 2000) %>%
  select (country, year, co2, co2_growth_prct)

# 2nd value of interest
# Average total CO2 emission of every country within the time range of the past two decades
avg_co2_by_country <- co2emissions_two_decades %>%
  group_by(country) %>%
  summarise (avg_co2 = round(mean(co2, na.rm = TRUE), digits = 2))

# 3rd value of interest
# The maximum value of CO2 emission: 37123.852
max_co2emissions <- max(co2emissions$co2, na.rm = TRUE)


# A shiny server that creates the interactive chart
my_server <- function(input, output) {
  
  unit <- reactive({
    if ("co2" %in% input$variable) return("Million Tonnes CO2")
    if ("co2_growth_prct" %in% input$variable) return("CO2 Growth Percentage (%)")
  })
  
  output$first_chart <- renderPlotly(return ({
      title <- paste0(input$variable, " in the year ", input$year)
      p <- ggplot(data = co2emissions_two_decades %>% filter (year == input$year)) +
        geom_bar(mapping = aes(x = country, y = co2), stat = "identity", width = 0.5, fill = "steelblue") + 
        theme_minimal() +
        labs(x = "Country",
             y = unit(), 
             title = title)
      ggplotly(p)
})
)}