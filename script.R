library(qualtRics)
library(tidyverse)
library(qualtRics)
library(Hmisc)
library(gt)
library(gtExtras)


data <- read_survey("data.csv") |> 
  filter(irb == "Yes",
         (county == "Berrien" |
            county == "Lanier"))

data |> 
  group_by(county) |> 
  count() 


#### Berrien

berrien <- data |> 
  filter(county == "Berrien") 


#### Function Test ####

library(tidyverse)

library(tidyverse)
library(gt)

create_frequency_table <- function(data, variable, levels) {
  data %>%
    filter(!is.na({{ variable }})) %>%
    count({{ variable }}) %>%
    mutate(Percentage = round(n / sum(n) * 100, 2)) %>%
    arrange(desc(Percentage)) %>%
    mutate(Ordered = fct_relevel({{ variable }}, {{ levels }})) %>%
    arrange(Ordered) %>%
    gt() %>%
    cols_label(
      {{ variable }} := "Response",
      n = "Count"
    ) %>%
    cols_align(
      align = "left",
      columns = {{ variable }}
    ) %>%
    tab_options(table.align = "left") %>%
    cols_hide(Ordered) 
}

# Example usage:

hhi_plot <- create_frequency_table(
  data,
  hhi,
  c('> $90,000', '$70,001 - $90,000', '$50,001 - $70,000', '$30,001 - $50,000', '< $30,000')
)

print(hhi_plot)



##### Levels

hhi_levels <- c('> $90,000', 
                '$70,001 - $90,000', 
                '$50,001 - $70,000', 
                '$30,001 - $50,000', 
                '< $30,000')

education_levels <- c('Advanced degree (Masters, Doctorate, JD, etc.)', 
                      'College degree',
                      'Some college',
                      'High school diploma',
                      'Some high school')



#### Example Usage

berrien_hhi_plot <- create_frequency_table(
  berrien,
  hhi,
  hhi_levels,
  "Household Income Distribution"
)

education_table <- create_frequency_table(
  data,
  education,
  education_levels,
  "Education"
)


berrien_hhi <- as.data.frame(table(berrien$hhi)) |>
  mutate(Percentage = round(Freq / sum(Freq) * 100, 2)) |>
  arrange(desc(Percentage)) |> 
  mutate(Ordered = fct_relevel(Var1, c('> $90,000', 
                                       '$70,001 - $90,000',
                                       '$50,001 - $70,000',
                                       '$30,001 - $50,000',
                                       '< $30,000')))  |> 
  arrange(Ordered) |> 
  gt() |> 
  cols_label(
    Var1 = "Response",
    Freq = "Count") |>
  cols_align(
    align = "left",
    columns = Var1
  ) |> 
  tab_options(table.align = "left") |> 
  cols_hide(Ordered) |> 
  tab_header("Household Income")

berrien_education <- as.data.frame(table(berrien$education)) |>
  mutate(Percentage = round(Freq / sum(Freq) * 100, 2)) |>
  arrange(desc(Percentage)) |> 
  mutate(Ordered = fct_relevel(Var1, c('Advanced degree (Masters, Doctorate, JD, etc.)', 
                                       'College degree',
                                       'High school diploma',
                                       'Some college')))  |> 
  arrange(Ordered) |> 
  gt() |> 
  cols_label(
    Var1 = "Response",
    Freq = "Count") |>
  cols_align(
    align = "left",
    columns = Var1
  ) |> 
  tab_options(table.align = "left") |> 
  cols_hide(Ordered) |> 
  tab_header("Highest Level of Education")

# Social Behaviors

social_behaviors <- as_tibble(unlist(strsplit(berrien$social_behavior_fact_0_GROUP,",")))

social_behaviors |> 
  filter(!is.na(value)) |> 
  group_by(value) |> 
  count() |> 
  ggplot(aes(x = reorder(value,n), y = n, fill=value)) +
  geom_col() + 
  coord_flip() + 
  labs(x = "Social & Behavioral Factors Affecting the Community",
       y = "Number of Respondents",
       caption = paste("Updated",today.date,sep = " ")) +
  geom_text(aes(label = n,
                hjust = 1.25)) + 
  theme_classic() + 
  theme(legend.position = "none")

# Community Health

community_health <- as_tibble(unlist(strsplit(berrien$community_health_0_GROUP,",")))

community_health |> 
  filter(!is.na(value)) |> 
  group_by(value) |> 
  count() |> 
  ggplot(aes(x = reorder(value,n), y = n, fill=value)) +
  geom_col() + 
  coord_flip() + 
  labs(x = "Most Important Health Problems in the Community",
       y = "Number of Respondents",
       caption = paste("Updated",today.date,sep = " ")) +
  geom_text(aes(label = n,
                hjust = 1.25)) + 
  theme_classic() + 
  theme(legend.position = "none")

# Health Care Services

health_care_services <- as_tibble(berrien$healthcare_service)

health_care_services |> 
  filter(!is.na(value)) |> 
  group_by(value) |> 
  count() |> 
  ggplot(aes(x = reorder(value,n), y = n, fill=value)) +
  geom_col() + 
  coord_flip() + 
  labs(x = "Most Important Health Problems in the Community",
       y = "Number of Respondents",
       caption = paste("Updated",Sys.Date(),sep = " ")) +
  geom_text(aes(label = n,
                hjust = 1.25)) + 
  theme_classic() + 
  theme(legend.position = "none")




#### Lanier

lanier <- data |> 
  filter(county == "Lanier") 

lanier_hhi <- as.data.frame(table(lanier$hhi)) |>
  mutate(Percentage = round(Freq / sum(Freq) * 100, 2)) |>
  arrange(desc(Percentage)) |> 
  mutate(Ordered = fct_relevel(Var1, c('> $90,000', 
                                       '$70,001 - $90,000',
                                       '$50,001 - $70,000',
                                       '$30,001 - $50,000',
                                       '< $30,000')))  |> 
  arrange(Ordered) |> 
  gt() |> 
  cols_label(
    Var1 = "Response",
    Freq = "Count") |>
  cols_align(
    align = "left",
    columns = Var1
  ) |> 
  tab_options(table.align = "left") |> 
  cols_hide(Ordered) |> 
  tab_header("What was your household?")

lanier_education <- as.data.frame(table(lanier$education)) |>
  mutate(Percentage = round(Freq / sum(Freq) * 100, 2)) |>
  arrange(desc(Percentage)) |> 
  mutate(Ordered = fct_relevel(Var1, c('Advanced degree (Masters, Doctorate, JD, etc.)', 
                                       'College degree',
                                       'High school diploma',
                                       'Some college')))  |> 
  arrange(Ordered) |> 
  gt() |> 
  cols_label(
    Var1 = "Response",
    Freq = "Count") |>
  cols_align(
    align = "left",
    columns = Var1
  ) |> 
  tab_options(table.align = "left") |> 
  cols_hide(Ordered) |> 
  tab_header("Education?")



# Gender



# Age



# Hispanic



# Race




# Education





# Married




# HHI





# Housing





# Housing Other




# Household





# County





# County Other





# Employment





# Transportation





# Social Behavior






# Social Behavior Rank 1




# Social Behavior Rank 2





# Social Behavior Rank 3






# Social Behavior Rank 4





# Social Behavior Rank 5




# Social Behavior Rank 6






# Social Behavior Rank 7







# Social Behavior Rank 8






# Social Behavior Rank 9





# Social Behavior Rank 10






# Social Behavior Rank 11






# Social Behavior Rank 12






# Social Behavior Rank 13




# Social Behavior Rank 14






# Social Behavior Rank 15







# Social Behavior Rank 16





# Community Health Group





# Community Health Rank 1




# Community Health Rank 2





# Community Health Rank 3





# Community Health Rank 4






# Community Health Rank 5






# Community Health Rank 6



















