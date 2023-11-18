
# get data ----------------------------------------------------------------

source("scripts/getData.R")
source("scripts/subsetData.R")
source("scripts/levels.R")
source("scripts/functions.R")

# create frequency table screening services for Berrien ----------------------------

berrien_screening_services_table <- 
  create_frequency_table(data, perception, perception_levels, "Berrien")

# create frequency table screening services for Lanier ----------------------------

lanier_screening_services_table <- 
  create_frequency_table(data, perception, perception_levels, "Lanier")

# create frequency table exercise for Berrien ----------------------------

berrien_exercise_table <- 
  create_frequency_table(data, exercise, exercise_levels, "Berrien")

# create frequency table exercise for Lanier ----------------------------

lanier_exercise_table <- 
  create_frequency_table(data, exercise, exercise_levels, "Lanier")

# create frequency table medical care unable why for Berrien ----------------------------

berrien_medical_care_unable_why_table <- 
  create_frequency_table(data, medcare_unable_y, medcare_unable_y_levels, "Berrien")

# create frequency table medical care unable why for Lanier ----------------------------

lanier_medical_care_unable_why_table <- 
  create_frequency_table(data, medcare_unable_y, medcare_unable_y_levels, "Lanier")

# create frequency table where care for Berrien ----------------------------

berrien_where_care_table <- 
  create_frequency_table(data, where_care, where_care_levels, "Berrien")

# create frequency table where care for Lanier ----------------------------

lanier_where_care_table <- 
  create_frequency_table(data, where_care, where_care_levels, "Lanier")

# create frequency table outside community for Berrien ----------------------------

berrien_outside_community_table <- 
  create_frequency_table(data, outside_comm, outside_comm_levels, "Berrien")

# create frequency table outside community for Lanier ----------------------------

lanier_outside_community_table <- 
  create_frequency_table(data, outside_comm, outside_comm_levels, "Lanier")

# create frequency table outside_comm_where for Berrien ----------------------------

berrien_outside_comm_where_table <- 
  create_frequency_table(data, outside_comm_where, outside_comm_where_levels, "Berrien")

# create frequency table outside_comm_where for Lanier ----------------------------

lanier_outside_comm_where_table <- 
  create_frequency_table(data, outside_comm_where, outside_comm_where_levels, "Lanier")

# create frequency table pcp for Berrien ----------------------------

berrien_pcp_table <- 
  create_frequency_table(data, pcp, pcp_levels, "Berrien")

# create frequency table pcp for Lanier ----------------------------

lanier_pcp_table <- 
  create_frequency_table(data, pcp, pcp_levels, "Lanier")

# create frequency table wait_time for Berrien ----------------------------

berrien_wait_time_table <- 
  create_frequency_table(data, wait_time, wait_time_levels, "Berrien")

# create frequency table wait_time for Lanier ----------------------------

lanier_wait_time_table <- 
  create_frequency_table(data, wait_time, wait_time_levels, "Lanier")

# create frequency table specialist for Berrien ----------------------------

berrien_specialist_table <- 
  create_frequency_table(data, specialist, specialist_levels, "Berrien")

# create frequency table specialist for Lanier ----------------------------

lanier_specialist_table <- 
  create_frequency_table(data, specialist, specialist_levels, "Lanier")

# create frequency table telehealth for Berrien ----------------------------

berrien_telehealth_table <- 
  create_frequency_table(data, telehealth, telehealth_levels, "Berrien")

# create frequency table telehealth for Lanier ----------------------------

lanier_telehealth_table <- 
  create_frequency_table(data, telehealth, telehealth_levels, "Lanier")

# create frequency table satisfaction for Berrien ----------------------------

berrien_satisfaction_table <- 
  create_frequency_table(data, satisfaction, satisfaction_levels, "Berrien")

# create frequency table satisfaction for Lanier ----------------------------

lanier_satisfaction_table <- 
  create_frequency_table(data, satisfaction, satisfaction_levels, "Lanier")

# create frequency table insurance for Berrien ----------------------------

berrien_insurance_table <- 
  create_frequency_table(data, insurance, insurance_levels, "Berrien")

# create frequency table insurance for Lanier ----------------------------

lanier_insurance_table <- 
  create_frequency_table(data, insurance, insurance_levels, "Lanier")


