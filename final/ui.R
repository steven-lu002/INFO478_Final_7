#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

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
        "Page 2",
        titlePanel("Page 2")
      ),
      
      tabPanel(
        "Page 3",
        titlePanel("Page 3")
      )
    ),
))
