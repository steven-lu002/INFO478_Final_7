#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  coviddata <- read.csv("data/europedata.csv")
  
    output$vis1 <- renderPlot({ 
      
      vis1data <- coviddata %>%
      filter(variant == input$selectV, source == "GISAID", country_code == input$selectC)
      #input$slider2[1] for min, input$slider2[2] for max
      vis1data <- vis1data[input$SliderT[1]:input$SliderT[2], ]
      
      ggplot(data = vis1data, aes(x = year_week, y = percent_variant, group=1)) +
        geom_point(shape = 1) +
        geom_line(color = "black") +
        geom_area(fill="#69b3a2", alpha=0.4) +
        labs(x = "Year Week", y = "Percentage of Variant", 
             title = "Percentage of Variant in Country by Week")
      
    })
    
})
