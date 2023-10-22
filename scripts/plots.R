
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


# plot healthcare services for Berrien ------------------------------------

berrien_healthcare_services_plot <- create_plot(
  filter(healthcare_services_data, county == "Berrien")
  , healthcare_service)

ggsave("plots/berrien_healthcare_services_plot.jpeg", plot = berrien_healthcare_services_plot, height = 3, width = 6)

# plot healthcare services for Lanier ------------------------------------

lanier_healthcare_services_plot <- create_plot(
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





