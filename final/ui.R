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
        titlePanel("Introduction"),
        h2("Purpose"),
        h4("Since the first detected strain of SARS-CoV-2 
          coronavirus in China, different variants have emerged from different regions, 
          with some variants more infectious than others. Such as Beta, Delta, and Omicron have 
          re-infected people continuously and become resistant to the coronavirus vaccines. With so 
          much data from COVID, we wanted to examine which country has the most 
          contagious and when the variants were the most spreadable, respectively, with the population 
          proportions."),
        h2("Dataset"),
        h4("Our dataset is from the European Center for Disease Prevention and Control (ECDC), which aggregated 
           SARS-CoV-2 data from the GISAID EpiCoV database and TESSy sources. The data records cases weekly from 
           September 28th, 2020 (Week 40 of 2020) to January 30th, 2022 (Week 4 of 2022). The dataset categorizes 
           the country and country code, the week of the year, source, new cases, percent variant, number detection 
           variant, and a few more, listed in the exploratory. Every positive test case is reported to GISAID as a 
           global database to share genome information on influenza. "),
        hr(),
        h4("Aside from the data collected from the European Center for Disease Prevention and Control, we 
           also organized the longitude and latitude of European countries from a Github repository that 
           featured country names, alpha code, and average longitude and latitude. Also, another Github 
           repository records the population of the country. We can create an interactive map that will 
           show COVID cases by population and proportions with both of the datasets. Also, the percentages 
           of positive cases allow us to draw conclusions of the factors that caused such data and see the 
           variant's growth rate in different countries."),
        h2("Methods"),
        h4("We filtered the dataset into the variants, source, time, and country-code over the different 
           datasets. After doing so, we create a graph titled \"Percentage of Variant in Country by Week\" 
           with the x-axis as the week of the year and the y-axis as the percentage of variant. As for 
           the other visualizations, we rendered the longitude and latitudes of one dataset and combined it 
           with the reported population of each reported country, all to create the map of total COVID cases 
           divided population.")
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
        "Covid Cases Map",
        titlePanel("Map of Total Covid Cases Divided by Population"),
        mainPanel(
          leafletOutput("outleafmap")
        )
      ),
      tabPanel(
        "Analysis and Conclusion",
        titlePanel("Analysis and Conclusion"),
        h2("Line Graph"),
        h4("When looking at the line graph, we can see the spreadability of each covid variant of interest. 
           Such allows us to see each variant's overall evolution and effectiveness in a given period. For 
           example, this gives us correlation data on which variant was effective when Delta was contagious 
           in the summer months before being rapidly taken over by the new emerging omicron variant that infected 
           many people headed into the winter months. Although many factors might explain the effectiveness of 
           each variant concerning their counterparts, what we can determine is which variants have had the most 
           significant effect on the populations of an affected country. Using this chart of percentages of cases 
           for respect of each country allows us to see fundamentally how each variant's growth rate differed by 
           the country they were living in. We will also be able to determine from this graph which variant had 
           the highest reproductive rate at the given time. We won't be able to decide on the actual reproductive 
           rate. Still, we will be able to know at a certain point in time which variant had the highest reproductive 
           rate, and this will also show why the variant should be invariants of concern or variants of interest."),
        h2("Map"),
        h4("Looking at the map of Covid cases by population, many different countries have experienced similar 
           amounts of total Covid cases divided by population. However, a few countries like Finland and Malta 
           have fared better than others like Slovenia and France. To create our visualization, we took the total 
           number of cases from September 28th, 2020, to January 30th, 2022, and tallied the number of cases by 
           aggregating the number of new cases per week. We then normalized this data by dividing the number of 
           total cases by the population to find the proportion of cases concerning the country's population. 
           Such allows us to draw some conclusions based on the number of cases compared to the size of the country. 
           Many factors could have contributed to this, such as social distancing and vaccine percentages within the 
           population. For example, Slovenia's vaccination rate as of March 7th, 2022, is 30% for two doses and a 
           booster shot, while Finland is sitting at 50%. This difference is shown by the percentage of individuals 
           with at least one vaccine, where Slovenia is at 60%, and Finland is at 80%. As of January 30th, 2022, 
           Slovenia's total cases are 705618, roughly 1/3 of their total population. "),
        h2("Conclusion"),
        h4("However, there were also a few limitations to our approach. Due to the way we acquired our data, we 
           depend heavily on countries to report accurate numbers of covid cases and cases sequenced. This means 
           that we are heavily relying on these countries, which often have incentives to downplay the level of 
           COVID cases in their countries. Furthermore, many countries have a hard time keeping track of COVID. 
           Tests cost money and many countries cannot do that. That combined with the frequency of asymptomatic 
           cases of COVID means that a large amount of this data speaks solely about COVID cases that are bad 
           enough to come to a hospital, versus a total case count."),
        h4("Furthermore, much of this data is from a time before we had a high-quality coronavirus vaccine ready. 
           This means that it is of limited use when we are trying to consider moving forward, given that many of 
           the models and predictions we can make from this are inaccurate. It may be useful to predict third-world 
           countries where the vaccine is hard to get, or vaxx-resistant communities, such as anti-vaxxers, or people
           with health problems that prevent them from getting vaccinated. However, given the lack of vaccinated data,
           some of these models are likely to be inaccurate. "),
        h4("Given all this, our data and visualizations still are useful, and report accurate information. The 
           model compares different variants across different countries and can allow a viewer to see how different 
           countries struggled with differing variants, and take note of good countermeasures if a new variant comes 
           along. Our map allows us to view how a normalized view of each country compares simultaneously, and look at 
           adjacencies to see if there was a cluster or outbreak that affected one region. It also allows us to compare 
           climates to see how COVID fares in hotter climes. ")
      )
    ),
))
