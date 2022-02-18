library(tidyverse)

coviddata <- read.csv("./data/europedata.csv")

omicrondata <- coviddata %>%
  filter(variant == "B.1.1.529")

deltadata <- coviddata %>%
  filter(variant == "B.1.617.2", source == "GISAID")