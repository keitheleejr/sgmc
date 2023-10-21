library(qualtRics)
library(tidyverse)
library(janitor)


# Import Data -------------------------------------------------------------



data <- read_survey("/Users/keithlee/Library/CloudStorage/OneDrive-ValdostaStateUniversity/1. Projects/SGMC/data/data.csv") |>
  filter(irb == "Yes",
         county %in% c("Berrien", "Lanier")) |>
  clean_names() |>
  rename(social_behaviors = social_behavior_fact_0_group,
         community_health = community_health_0_group) |>
  select(
    gender,
    age,
    hispanic,
    race,
    education,
    married,
    hhi,
    housing,
    household,
    county,
    employment,
    transportation,
    social_behaviors,
    community_health,
    healthcare_service,
    screening_service,
    perception,
    insurance,
    insurance_why,
    health_status,
    chronic_health_count,
    chronic_health,
    exercise,
    med_care_unable,
    medcare_unable_y,
    where_care,
    outside_comm,
    difficult_care,
    pcp,
    no_pcp_y,
    wait_time,
    specialist,
    telehealth,
    satisfaction
  )

data$age <- gsub(" years old", "", data$age)
data$age <- as.numeric(data$age)

age_breaks <- c(18, 30, 40, 50, 60, Inf)
age_labels <- c("18-29", "30-39", "40-49", "50-59", "60+")



# Clean Age ---------------------------------------------------------------


data$age <-
  cut(data$age,
      breaks = age_breaks,
      labels = age_labels,
      right = FALSE)


# Clean Community Health ------------------------------------------------



data$community_health <-
  gsub(
    "\\(Alzheimer’s, Arthritis, Parkinson’s, Hearing loss, etc.\\)",
    "",
    data$community_health
  )


# Clean Healthcare Service ------------------------------------------------



healthcare_services_original <-
  data.frame(
    variable = c(
      "Additional care and services for patients with heart disease.",
      "Greater access to primary care including urgent care/walk-in clinics with extended office hours and a focus on low-income individuals.",
      "Additional access to pediatric care in the community.",
      "More mental health services including alcohol and substance abuse treatment.",
      "Expanded access to emergency care including services for higher acuity patients.",
      "Cancer treatment",
      "Access to pre-natal care for pregnant women."
    )
  )

# Patterns and replacements
patterns <- c(
  "Additional care and services for patients with heart disease.",
  "Greater access to primary care including urgent care/walk-in clinics with extended office hours and a focus on low-income individuals.",
  "Additional access to pediatric care in the community.",
  "More mental health services including alcohol and substance abuse treatment.",
  "Expanded access to emergency care including services for higher acuity patients.",
  "Cancer treatment",
  "Access to pre-natal care for pregnant women."
)

replacements <- c(
  "Additional care for heart disease",
  "Greater Access to Primary/Urgent Care",
  "Greater Access to Pediatric Care",
  "More Mental Health Services",
  "Expanded Access to Emergency Care",
  "Cancer Treatment",
  "Pre-natal Care"
)

# Loop through patterns and replacements
for (i in seq_along(patterns)) {
  data$healthcare_service <-
    gsub(patterns[i], replacements[i], data$healthcare_service)
}

# Recode insurance column to replace Commercial Insurance (Anthem Blue Cross, United, etc.) 
# with Commercial Insurance

data$insurance <- recode(data$insurance,
                         "Commercial Insurance (Anthem Blue Cross, United, etc.)" = "Commercial Insurance")






