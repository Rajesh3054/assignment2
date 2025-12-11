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



## 5. VISUALISATIONS (for the report) ----
#   These are your main plot + required histogram.

# 5.1 Boxplot: Stress_Score by Work_Location
ggplot(data_small, aes(x = Work_Location, y = Stress_Score,
                       fill = Work_Location)) +
  geom_boxplot() +
  labs(
    title = "Stress Score by Work Mode",
    x     = "Work Mode",
    y     = "Stress Score (1 = Low, 3 = High)"
  ) +
  theme_minimal()

# (Optional) Save plot for report
# ggsave("boxplot_stress_by_workmode.png", width = 6, height = 4)

# 5.2 Histogram of Stress_Score (required second graphic)
ggplot(data_small, aes(x = Stress_Score)) +
  geom_histogram(binwidth = 1, boundary = 0.5, closed = "right") +
  scale_x_continuous(breaks = c(1, 2, 3),
                     labels = c("Low", "Medium", "High")) +
  labs(
    title = "Distribution of Stress Scores",
    x     = "Stress Category",
    y     = "Number of Employees"
  ) +
  theme_minimal()

# ggsave("hist_stress_score.png", width = 6, height = 4)

# 6. ASSUMPTION CHECKS ----

by(data_small$Stress_Score, data_small$Work_Location, shapiro.test)

leveneTest(Stress_Score ~ Work_Location, data = data_small)

