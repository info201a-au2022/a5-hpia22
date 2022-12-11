install.packages("shinythemes")

library (shiny)
library(shinythemes)
library (ggplot2)
library (plotly)


# introduction page layout
introduction_page <- tabPanel(
  "Introduction",
  print("This application is an analysis of a dataset on Carbon Dioxide and Greenhouse Gas Emissions by **Our World in Data**.
  Specifically, this application compares the annual Carbon Dioxide emissions of all countries within the last two decades.
  Through visualization and data comparison, it can be seen that Carbon Dioxide emissions have grow rapidly throughout
  the past two decades, along with more factories, more cars, and the advancement of technology. In addition, upper to middle
  income countries generally produce more Carbon Dioxide emission than lower income countries. For this data analysis, three
  values of interest were calculated. The annual total CO2 emission and the CO2 growth percentage of every country in the
  past two decades allows for cross comparison between countries throughout the years; the average total CO2 emission of every
  country was calculated to identify the trend of the years of the countries below or above the average line; the highest amount
  of CO2 emission, a striking number for people to take action and reduce greenhouse gases to the best of our ability.")
)

# INTERACTIVE CHART
# side panel
bar_side <- sidebarPanel(
  selectInput(inputId = "variable", 
              label = "Choose a variable", 
              choices = list("Annual Total CO2 Emission" = "co2", "Annual Total CO2 Emission Growth Percentage" = "co2_growth_prct")
  ),
  sliderInput(inputId = "year",
              label = "Choose a year",
              min = 2001,
              max = 2021,
              value = 2010
  ),
  print("This is a bar chart that compares the annual total CO2 emission and its growth percentage for every country within 
        the past twenty years. As shown in the chart, North America has consistently produced the highest CO2 emission within
        this time range, following Asia as the second highest CO2 producer. In addition, upper-middle income countries takes
        the lead in producing CO2. As for individual countries, China stands out as producing the most CO2, due to its factories
        and manufacturing businesses. The second highest is the United States, which has shown to have a larger CO2 growth percentage
        every year as well. This chart allows for cross comparison among all the countries within one year, as the highest number
        of CO2 emission countries stands out easily in this bar chart. This would serve as a warning for upper-middle income 
        countries as they can take measures to slow down CO2 emission to protect our living environment. This chart also allows
        the users to choose between CO2 emission and CO2 growth percentage as they not only learn about the highest CO2 producing
        country, but also how rapidly they are, which implies how quickly they are developing over the past twenty years.")
)

# main panel
bar_main <- mainPanel(
  plotlyOutput("first_chart")
)

# interactive chart page layout
bar_page <- tabPanel(
  "CO2 Emission and Growth",
  titlePanel("CO2 Emission and Growth Percentage in Every Country Within the Past Twenty Years"),
  sidebarLayout(
    bar_side,
    bar_main
  )
)

my_ui <- navbarPage (
  theme = shinytheme("journal"), 
  "Global CO2 Emission Analysis",
  introduction_page,
  bar_page
)