library(tidyverse)

coviddata <- read.csv("data/europedata.csv")
countries <- read.csv("data/countries.csv")

test <- full_join(coviddata, countries)