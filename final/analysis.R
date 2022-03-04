library(tidyverse)

coviddata <- read.csv("data/europedata.csv")
countries <- read.csv("data/countries.csv")

test <- left_join(coviddata, countries, by='country_code')