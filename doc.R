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
