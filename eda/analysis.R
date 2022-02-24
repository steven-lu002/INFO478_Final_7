library(tidyverse)
library(knitr)

# initial data set
coviddata <- read.csv("data/europedata.csv")

# filtered csv file down to omicron (B.1.1.529) and source to GISAID
omicrondata <- coviddata %>%
  filter(variant == "B.1.1.529", source == "GISAID")

# filtered csv file down to delta (B.1.617.2) and source to GISAID
deltadata <- coviddata %>%
  filter(variant == "B.1.617.2", source == "GISAID")

# filtered csv file down to variant Other and source to GISAID

otherdata <- coviddata %>%
  filter(variant == "Other", source == "GISAID")

# Distribution of Variables

# Analysis of data omicron/delta (max and min)

omicron_analysis <- omicrondata %>%
  summarise(max_detected = max(number_detections_variant), 
            min_detected = min(number_detections_variant),
            range_detected = max_detected - min_detected,
            standard_deviation = sd(number_detections_variant),
            avg_detections = mean(number_detections_variant)) %>%
  mutate(variant = "Omicron")

delta_analysis <- deltadata %>%
  summarise(max_detected = max(number_detections_variant), 
            min_detected = min(number_detections_variant),
            range_detected = max_detected - min_detected, 
            standard_deviation = sd(number_detections_variant), 
            avg_detections = mean(number_detections_variant)) %>%
  mutate(variant = "Delta")

other_analysis <- otherdata %>% 
  summarise(max_detected = max(number_detections_variant), 
            min_detected = min(number_detections_variant),
            range_detected = max_detected - min_detected, 
            standard_deviation = sd(number_detections_variant), 
            avg_detections = mean(number_detections_variant))%>%
  mutate(variant = "Other")

data_analysis <- do.call("rbind", list(omicron_analysis, delta_analysis, other_analysis)) %>%
  select(variant, !variant)

data_analysis_graph <- ggplot(data = data_analysis, aes(x = variant, y = standard_deviation)) +
  geom_col() +
  labs(title = "Standard deviation amongst variants", x = "Variant", y = "Standard Deviation")

# Relationships between variables
# Total new cases table and graph 
total_cases <- omicrondata %>%
  group_by(country_code) %>%
  summarize(totalcases = sum(new_cases)) %>%
  arrange(desc(totalcases))

# Total new cases plot
total_cases_plot <- ggplot(total_cases, aes(x = reorder(country_code, - totalcases), y=totalcases)) +
  geom_bar(stat="identity") +
  labs(y = "Total New Cases", x = "Country Code", title = "Total Number of New Cases Vs. Country Code")

# French omicron data
FR_omicron_cases <- omicrondata %>%
  filter(country_code == "FR") %>%
  tail(10)

# French Omicron plot
FR_omicron_cases_plot <- ggplot(data = FR_omicron_cases, aes(x = year_week, y = percent_variant)) +
  geom_point(shape = 1) +
  labs(x = "Year Week", y = "Percentage of Omicron Variant", 
       title = "French Percentage of Omicron Variant vs Year Week")