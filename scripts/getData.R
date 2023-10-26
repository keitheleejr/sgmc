library(qualtRics)
library(tidyverse)
library(janitor)


# Import Data -------------------------------------------------------------

community_profile <- read_survey("/Users/keithlee/Library/CloudStorage/OneDrive-ValdostaStateUniversity/1. Projects/SGMC/data/data.csv") |>
  filter(irb == "Yes",
         county %in% c("Berrien", "Lanier")) |>
  clean_names() |> 
  select(
    gender,
    race,
    hispanic,
    age,
    race,
    education,
    married,
    hhi,
    housing
  )

data <- read_survey("/Users/keithlee/Library/CloudStorage/OneDrive-ValdostaStateUniversity/1. Projects/SGMC/data/data.csv") |>
  filter(irb == "Yes",
         county %in% c("Berrien", "Lanier")) |>
  clean_names() |>
  rename(social_behaviors = social_behavior_fact_0_group,
         community_health = community_health_0_group,
         outside_comm_where = q32) |>
  select(
    county,
    social_behaviors,
    community_health,
    healthcare_service,
    screening_service,
    perception,
    insurance,
    insurance_why,
    health_status,
    exercise,
    med_care_unable,
    medcare_unable_y,
    where_care,
    outside_comm,
    outside_comm_where,
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



# clean health_status -----------------------------------------------------

health_status_original <-
  data.frame(
    variable = c(
      "2",
      "A: Well and active",
      "B: Good",
      "C: Ok",
      "D: Poor",
      "F: Health is failing"
    )
  )

# Patterns and replacements
patterns2 <- c(
  "2",
  "A: Well and active",
  "B: Good",
  "C: Ok",
  "D: Poor",
  "F: Health is failing"
)

replacements2 <- c(
  "Good",
  "Well and active",
  "Good",
  "Ok",
  "Poor",
  "Health is failing"
)

# Loop through patterns and replacements
for (i in seq_along(patterns)) {
  data$health_status <-
    gsub(patterns[i], replacements[i], data$health_status)
}



# Relabel Screening Service -------------------------------------------------

data$screening_service <-
  ifelse(
    data$screening_service %in% c("2", "Other (please specify)"),
    "Other",
    data$screening_service
  )


# Recode medcare_unable

data$med_care_unable <- recode(data$med_care_unable,
                               "Yes" = "Not Able",
                               "No" = "Able"
)


# Relabel medcare_unable_y -------------------------------------------------

data$medcare_unable_y <-
  ifelse(data$medcare_unable_y == "Other (please specify)", "Other",
         data$medcare_unable_y)


# Relabel where_care  -----------------------------------------------------

data$where_care <-
  ifelse(data$where_care == "Other (please specify)", "Other",
         data$where_care)

# Relabel outside_comm_where  ---------------------------------------------

data$outside_comm_where <-
  ifelse(
    data$outside_comm_where %in% c("Other (please specify)", "Adel", "Cordele", "Moultrie"),
    "Other",
    data$outside_comm_where
  )

# Relabel no_pcp_y  -------------------------------------------------------

data$no_pcp_y <-
  ifelse(data$no_pcp_y == "Other (please specify)", "Other",
         data$no_pcp_y)


