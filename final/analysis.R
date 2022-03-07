library(tidyverse)
library(leaflet)

coviddata <- read.csv("data/europedata.csv")
countries <- read.csv("data/countries.csv")
population <- read.csv("data/population.csv")


# countries with coordinates
test <- left_join(coviddata, countries, by='country_code')

countries <- left_join(countries, population, by='code2')
countries = merge(x=countries,y=population,by="code2",all.x=TRUE)


# summarize by new cases #omicron
testmap <- test %>%
  filter(variant == "B.1.1.529", source == "GISAID") %>%
  group_by(country_code) %>%
  select(country_code, longitude, latitude, new_cases) %>%
  summarize(totalcases = sum(new_cases))

# table with country code, coordinates and total cases
mapInfo <- left_join(testmap, countries, by='country_code') %>%
  select(Country, country_code, longitude, latitude, totalcases, population) %>%
  drop_na(longitude)

m <-leaflet(mapInfo) %>%
  addTiles() %>%
  addCircleMarkers(
    radius = ~ (50 * totalcases / population),
    stroke = FALSE, fillOpacity = .5,
    label = paste(mapInfo$Country, "total cases: ", formatC(mapInfo$totalcases, format="d", big.mark=","))
  )





