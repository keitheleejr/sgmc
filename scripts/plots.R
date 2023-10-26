
# get data ----------------------------------------------------------------

source("scripts/getData.R")
source("scripts/subsetData.R")
source("scripts/levels.R")
source("scripts/functions.R")


# plot social and behavioral risk factors for Berrien ---------------------------------

berrien_social_behavioral_plot <- create_plot(
  filter(social_behaviors_split, county == "Berrien")
  , social_behaviors) 

ggsave("plots/berrien_social_behavioral_plot.jpeg", plot = berrien_social_behavioral_plot, height = 3, width = 6)


# plot social and behavioral risk factors for Lanier ---------------------------------

lanier_social_behavioral_plot <- create_plot(
  filter(social_behaviors_split, county == "Lanier")
  , social_behaviors)

ggsave("plots/lanier_social_behavioral_plot.jpeg", plot = lanier_social_behavioral_plot, height = 3, width = 6)


# plot healthcare access for Berrien ------------------------------------

berrien_healthcare_access_plot <- create_plot(
  filter(healthcare_services_data, county == "Berrien")
  , healthcare_service)

ggsave("plots/berrien_healthcare_services_plot.jpeg", plot = berrien_healthcare_services_plot, height = 3, width = 6)

# plot healthcare access for Lanier ------------------------------------

lanier_healthcare_access_plot <- create_plot(
  filter(healthcare_services_data, county == "Lanier")
  , healthcare_service)

ggsave("plots/lanier_healthcare_services_plot.jpeg", plot = lanier_healthcare_services_plot, height = 3, width = 6)


# plot insurance for Berrien ----------------------------------------------

berrien_insurance_plot <- create_plot(
  filter(data, county == "Berrien")
  , insurance)

ggsave("plots/berrien_insurance_plot.jpeg", plot = berrien_insurance_plot, height = 3, width = 6)

# plot insurance for Lanier ----------------------------------------------

lanier_insurance_plot <- create_plot(
  filter(data, county == "Lanier")
  , insurance)

ggsave("plots/lanier_insurance_plot.jpeg", plot = lanier_insurance_plot, height = 3, width = 6)


# plot community health for Berrien ---------------------------------------

berrien_community_health_plot <- create_plot(
  filter(community_health_split, county == "Berrien")
  , community_health)

ggsave("plots/berrien_community_health_plot.jpeg", plot = berrien_community_health_plot, height = 3, width = 6)

# plot community health for Lanier ---------------------------------------

lanier_community_health_plot <- create_plot(
  filter(community_health_split, county == "Lanier")
  , community_health)

ggsave("plots/lanier_community_health_plot.jpeg", plot = lanier_community_health_plot, height = 3, width = 6)



# create a dounut chart for Berrien ---------------------------------------

health_status_count_berrien <- 
  health_status_data |> 
  filter(county == "Berrien") |>
  select(health_status) |> 
  group_by(health_status) |> 
  count() 
  
# Compute percentages
health_status_count_berrien$fraction = health_status_count_berrien$n / sum(health_status_count_berrien$n)

# Compute the cumulative percentages (top of each rectangle)
health_status_count_berrien$ymax = cumsum(health_status_count_berrien$fraction)

# Compute the bottom of each rectangle
health_status_count_berrien$ymin = c(0, head(health_status_count_berrien$ymax, n=-1))

# Compute label position
health_status_count_berrien$labelPosition <- (health_status_count_berrien$ymax + health_status_count_berrien$ymin) / 2

# Compute a good label
health_status_count_berrien$label <- paste0(health_status_count_berrien$health_status, "\n value: ", health_status_count_berrien$n)

# Make the plot
health_status_plot_berrien <- 
  ggplot(health_status_count_berrien,
         aes(
           ymax = ymax,
           ymin = ymin,
           xmax = 4,
           xmin = 3,
           fill = health_status
         )) +
  geom_rect() +
  geom_label(x = 2,
             aes(y = labelPosition, label = label),
             size = 1.5) +
  coord_polar(theta = "y") + # Try to remove that to understand how the chart is built initially
  xlim(c(-1, 4)) + # Try to remove that to see how to make a pie chart
  theme_void() +
  theme(legend.position = "none")

ggsave("plots/health_status_plot_berrien.jpeg", plot = health_status_plot_berrien, height = 3, width = 6)


# create a dounut chart for Lanier ---------------------------------------

health_status_count_lanier <- 
  health_status_data |> 
  filter(county == "Lanier") |>
  select(health_status) |> 
  group_by(health_status) |> 
  count()

# Compute percentages

health_status_count_lanier$fraction = health_status_count_lanier$n / sum(health_status_count_lanier$n)

# Compute the cumulative percentages (top of each rectangle)

health_status_count_lanier$ymax = cumsum(health_status_count_lanier$fraction)

# Compute the bottom of each rectangle

health_status_count_lanier$ymin = c(0, head(health_status_count_lanier$ymax, n=-1))

# Compute label position

health_status_count_lanier$labelPosition <- (health_status_count_lanier$ymax + health_status_count_lanier$ymin) / 2

# Compute a good label

health_status_count_lanier$label <- paste0(health_status_count_lanier$health_status, "\n value: ", health_status_count_lanier$n)

# Make the plot

health_status_plot_lanier <- 
  ggplot(health_status_count_lanier,
         aes(
           ymax = ymax,
           ymin = ymin,
           xmax = 4,
           xmin = 3,
           fill = health_status
         )) +
  geom_rect() +
  geom_label(x = 2,
             aes(y = labelPosition, label = label),
             size = 1.5) +
  coord_polar(theta = "y") + # Try to remove that to understand how the chart is built initially
  xlim(c(-1, 4)) + # Try to remove that to see how to make a pie chart
  theme_void() +
  theme(legend.position = "none")

ggsave("plots/health_status_plot_lanier.jpeg", plot = health_status_plot_lanier, height = 3, width = 6)



# Create screening service plot Berrien -----------------------------------

berrien_screening_service_plot <- create_plot(
  filter(screening_services_data, county == "Berrien"), screening_service)

ggsave("plots/berrien_screening_service_plot.jpeg", plot = berrien_screening_service_plot, height = 3, width = 6)

# Create screening service plot Lanier ------------------------------------

lanier_screening_service_plot <- create_plot(
  filter(screening_services_data, county == "Lanier"), screening_service)

ggsave("plots/lanier_screening_service_plot.jpeg", plot = lanier_screening_service_plot, height = 3, width = 6)


# Create difficulty accessing care plot Berrien ----------------------------

berrien_difficulty_accessing_care_plot <- create_plot(
  filter(difficulty_accessing_care_data, county == "Berrien"), difficulty_accessing_care)

ggsave("plots/berrien_difficulty_accessing_care_plot.jpeg", plot = berrien_difficulty_accessing_care_plot, height = 3, width = 6)


# Create difficulty accessing care plot Lanier -----------------------------

lanier_difficulty_accessing_care_plot <- create_plot(
  filter(difficulty_accessing_care_data, county == "Lanier"), difficulty_accessing_care)

ggsave("plots/lanier_difficulty_accessing_care_plot.jpeg", plot = lanier_difficulty_accessing_care_plot, height = 3, width = 6)


# Create medical care unable bar chart for Berrien --------------------------


berrien_medical_care_unable_plot <- 
  medical_care_unable_data |> 
  filter(county == "Berrien") |>
  ggplot(aes(x = "", y = n, fill = med_care_unable)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = scales::percent(n / sum(n))), position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = c("Not Able" = "orangered", "Able" = "seagreen4")) +
  labs(fill = "") +
  theme_void() +
  theme(legend.position = "right")

ggsave("plots/berrien_medical_care_unable_plot.jpeg", plot = berrien_medical_care_unable_plot, height = 3, width = 6)


# Create medical care unable bar chart for Lanier ---------------------------

lanier_medical_care_unable_plot <- 
  medical_care_unable_data |> 
  filter(county == "Lanier") |>
  ggplot(aes(x = "", y = n, fill = med_care_unable)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = scales::percent(n / sum(n))), position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = c("Not Able" = "orangered", "Able" = "seagreen4")) +
  labs(fill = "") +
  theme_void() +
  theme(legend.position = "right")

ggsave("plots/lanier_medical_care_unable_plot.jpeg", plot = lanier_medical_care_unable_plot, height = 3, width = 6)

# Create difficulty accessing care plot for Berrien -------------------------

berrien_difficult_care_plot <- create_plot(
  filter(difficult_care_split, county == "Berrien"), difficult_care)

ggsave("plots/berrien_difficult_care_plot.jpeg", plot = berrien_difficult_care_plot, height = 3, width = 6)


# Create difficulty accessing care plot for Lanier --------------------------

lanier_difficult_care_plot <- create_plot(
  filter(difficult_care_split, county == "Lanier"), difficult_care)

ggsave("plots/lanier_difficult_care_plot.jpeg", plot = lanier_difficult_care_plot, height = 3, width = 6)
