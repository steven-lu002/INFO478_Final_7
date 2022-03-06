library(tidyverse)
library(leaflet)

coviddata <- read.csv("data/europedata.csv")
countries <- read.csv("data/countries.csv")

# countries with coordinates
test <- left_join(coviddata, countries, by='country_code')

