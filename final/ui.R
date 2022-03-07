#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

test <- read.csv("data/europedata.csv")
# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Covid Variants"),

    tabsetPanel(
      tabPanel(
        "Introduction",
        titlePanel("Introduction")
      ),
      
      tabPanel(
        "Covid Variant and Percentage Sequenced vs Time",
        sidebarLayout(
          sidebarPanel(
            selectInput("selectV", label = h3("Variant"), 
                        choices = list("Alpha" = "B.1.1.7", "Beta" = "B.1.351", "Gamma" = "P.1", 
                                   "Delta" = "B.1.617.2", "Omicron" = "B.1.1.529", "Other" = "Other"), 
                        selected = "B.1.1.7"),
            selectInput("selectC", label = h3("Country"), 
                        choices = list("Austria" = "AT", "Belgium" = "BE", "Bulgaria" = "BG", "Cyprus" = "CY", 
                                       "Czechia" = "CZ", "Denmark" = "DK", "Germany" = "DE", "Estonia" = "EE",
                                       "Greece" = "EL", "Spain" = "ES", "Finland" = "FI", "France" = "FR",
                                       "Croatia" = "HR", "Hungary" = "HU", "Ireland" = "IE", "Iceland" = "IS",
                                       "Italy" = "IT", "Liechtenstein" = "LI", "Lithuania" = "LT", "Luxembourg" = "LU",
                                       "Latvia" = "LV", "Malta" = "MT", "Netherlands" = "NL", "Norway" = "NO",
                                       "Poland" = "PL", "Portugal" = "PT", "Romania" = "RO", "Sweden" = "SE",
                                       "Slovenia" = "SI", "Slovakia" = "SK"), 
                        selected = "AT"),
            sliderInput("SliderT", label = h3("Time Frame in Number of Weeks"), min = 0, 
                        max = 70, value = c(20, 50))
          ),
          mainPanel(
            plotOutput("vis1")
          )
        )
      ),
      
      tabPanel(
        "Page 3",
        titlePanel("Page 3"),
        mainPanel(
          leafletOutput("outleafmap")
        )
      )
    ),
))
