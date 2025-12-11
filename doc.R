# 7COM1079 – Group A120
# Dataset: Impact_of_Remote_Work_on_Mental_Health.csv
# RQ (Path 1):
#   Does work-mode (Hybrid, Onsite, Remote) significantly
#   affect employee stress level?

# install.packages("tidyverse") ...
library(tidyverse)
library(car)
library(effectsize)
library(rstatix)


data <- read.csv("Impact_of_Remote_Work_on_Mental_Health.csv",
                 stringsAsFactors = FALSE)

str(data)
table(data$Work_Location)
table(data$Stress_Level)

data_small <- data %>%
  select(Work_Location, Stress_Level)

dim(data_small)
colSums(is.na(data_small))

data_small$Work_Location <- factor(
  data_small$Work_Location,
  levels = c("Hybrid", "Onsite", "Remote")
)

data_small$Stress_Level <- factor(
  data_small$Stress_Level,
  levels = c("Low", "Medium", "High"),
  ordered = TRUE
)

data_small$Stress_Score <- as.numeric(data_small$Stress_Level)

summary(data_small$Work_Location)
summary(data_small$Stress_Level)
summary(data_small$Stress_Score)


## 4. DESCRIPTIVE STATISTICS ----

# 4.1 Counts per work mode
table(data_small$Work_Location)

# 4.2 Mean and SD of Stress_Score by work mode
descriptives <- data_small %>%
  group_by(Work_Location) %>%
  summarise(
    n   = n(),
    mean_stress = mean(Stress_Score, na.rm = TRUE),
    sd_stress   = sd(Stress_Score, na.rm = TRUE)
  )


