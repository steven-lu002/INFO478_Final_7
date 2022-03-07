library(tidyverse)
library(leaflet)

coviddata <- read.csv("data/europedata.csv")
countries <- read.csv("data/countries.csv")

# countries with coordinates
test <- left_join(coviddata, countries, by='country_code')

# summarize by new cases #omicron
testmap <- test %>%
  filter(variant == "B.1.1.529", source == "GISAID") %>%
  group_by(country_code) %>%
  select(country_code, longitude, latitude, new_cases) %>%
  summarize(totalcases = sum(new_cases))

# table with country code, coordinates and total cases
mapInfo <- left_join(testmap, countries, by='country_code') %>%
  select(country_code, longitude, latitude, totalcases) %>%
  drop_na(longitude)

m <-leaflet(mapInfo) %>%
  addTiles() %>%
  addCircleMarkers(
    radius = ~ sqrt(totalcases * .00015),
    stroke = FALSE, fillOpacity = .5
  )