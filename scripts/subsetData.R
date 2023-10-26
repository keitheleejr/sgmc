berrien <- data |> 
  filter(county == "Berrien") 

lanier <- data |> 
  filter(county == "Lanier")

social_behaviors_data <- data |> 
  filter(!is.na(social_behaviors)) |> 
  select(county, social_behaviors) 

social_behaviors_split <- social_behaviors_data |> 
  mutate(social_behaviors = strsplit(social_behaviors, ",")) |> 
  unnest(social_behaviors)


community_health_data <- data |> 
  filter(!is.na(community_health)) |> 
  select(county, community_health) 


community_health_split <- community_health_data |>
  mutate(community_health = strsplit(community_health, ",")) |>
  unnest(community_health)

healthcare_access_data <- data |> 
  filter(!is.na(healthcare_service)) |> 
  select(county, healthcare_service)

health_status_data <- data |> 
  filter(!is.na(health_status)) |> 
  select(county, health_status)

screening_services_data <- data |> 
  filter(!is.na(screening_service)) |>
  select(county, screening_service)

medical_care_unable_data <- data |>
  filter(!is.na(med_care_unable)) |>
  count(county, med_care_unable)


difficult_care_data <- data |>
  filter(!is.na(difficult_care)) |>
  mutate(difficult_care = str_replace_all(difficult_care, "\\([^)]+\\)", "")) |>
  select(county, difficult_care)


difficult_care_split <- difficult_care_data |>
  mutate(difficult_care = strsplit(difficult_care, ",")) |>
  unnest(difficult_care)



       