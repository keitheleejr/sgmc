berrien <- data |> 
  filter(county == "Berrien") 

lanier <- data |> 
  filter(county == "Lanier")

social_behaviors_data <- data |> 
  filter(!is.na(social_behaviors)) |> 
  select(gender, age, hispanic, race, education, hhi, county, employment, social_behaviors) 

social_behaviors_split <- social_behaviors_data |> 
  mutate(social_behaviors = strsplit(social_behaviors, ",")) |> 
  unnest(social_behaviors)


community_health_data <- data |> 
  filter(!is.na(community_health)) |> 
  select(gender, age, race, hispanic, education, hhi, county, community_health) 


community_health_split <- community_health_data |>
  mutate(community_health = strsplit(community_health, ",")) |>
  unnest(community_health)

healthcare_services_data <- data |> 
  filter(!is.na(healthcare_service)) |> 
  select(gender, age, race, hispanic, education, hhi, county, healthcare_service)

