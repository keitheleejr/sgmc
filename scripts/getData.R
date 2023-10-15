library(qualtRics)
library(tidyverse)
library(janitor)

data <- read_survey("data/data.csv") |> 
  filter(irb == "Yes",
         county %in% c("Berrien","Lanier")) |> 
  clean_names() |> 
  rename(social_behaviors = social_behavior_fact_0_group,
         community_health = community_health_0_group) |> 
  select(gender, age, hispanic, race, education, married, hhi, housing, household, county, employment, 
         transportation, social_behaviors, community_health, healthcare_service, screening_service, perception,
         insurance, insurance_why, health_status, chronic_health_count, chronic_health, exercise, med_care_unable,
         medcare_unable_y, where_care, outside_comm, difficult_care, pcp, no_pcp_y, wait_time, specialist, telehealth, satisfaction)

data$age <- gsub(" years old", "", data$age)
data$age <- as.numeric(data$age)

age_breaks <- c(18, 30, 40, 50, 60, Inf)
age_labels <- c("18-29", "30-39", "40-49", "50-59", "60+")

data$age <- cut(data$age, breaks = age_breaks, labels = age_labels, right = FALSE)

data$community_health <- gsub("\\(Alzheimer’s, Arthritis, Parkinson’s, Hearing loss, etc.\\)","", data$community_health)

social_behaviors_data <- data |> 
  filter(!is.na(social_behaviors)) |> 
  select(gender, age, hispanic, race, education, hhi, county, social_behaviors) 

social_behaviors_split <- social_behaviors_data |> 
  mutate(social_behaviors = strsplit(social_behaviors, ",")) |> 
  unnest(social_behaviors)


community_health_data <- data |> 
  filter(!is.na(community_health)) |> 
  select(gender, age, race, hispanic, education, hhi, county, community_health) 

  
community_health_split <- community_health_data |>
  mutate(community_health = strsplit(community_health, ",")) |>
  unnest(community_health)
  

