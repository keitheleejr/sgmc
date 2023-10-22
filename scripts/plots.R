
# get data ----------------------------------------------------------------

source("scripts/getData.R")
source("scripts/subsetData.R")
source("scripts/levels.R")
source("scripts/functions.R")


# plot social and behavioral risk factors for Berrien ---------------------------------

berrien_social_behavioral_plot <- create_plot(
  filter(social_behaviors_split, county == "Berrien")
  , social_behaviors)
berrien_social_behavioral_plot
ggsave("berrien_social_behavioral_plot.jpeg", plot = berrien_social_behavioral_plot, height = 3, width = 6)

berrien_social_behavioral_plot_age <- create_plot(
  social_behaviors_split, social_behaviors)

lanier_social_behavioral_plot <- create_plot(
  filter(social_behaviors_split, county == "Lanier")
  , social_behaviors, 
  "Social & Behavioral Risk Factors")
lanier_social_behavioral_plot




social_behaviors_split %>%
  tibble(value1 = social_behaviors_split$social_behaviors, 
         value2 = social_behaviors_split$education) %>%
  filter(!is.na(value1) & !is.na(value2)) %>%
  group_by(value1, value2) %>%
  count() %>%
  ggplot(aes(x = reorder(value1, n), y = n, fill = value2)) +
  geom_col(width = 0.25) +
  coord_flip() +
  labs(
    x = "",
    y = "",
    caption = paste("Updated", Sys.Date(), sep = " ")
  ) +
  geom_text(aes(label = n, hjust = -0.15), size = 2) +
  theme_minimal() +
  theme(legend.position = "none",
        text = element_text(family = "serif"),
        plot.title = element_text(family = "serif", size = 20),
        axis.title.x = element_text(family = "serif", size = 12),
        axis.title.y = element_text(family = "serif", size = 12),
        axis.text.x = element_text(family = "serif", size = 10),
        axis.text.y = element_text(family = "serif", size = 10)) +
  facet_wrap(~value2)


