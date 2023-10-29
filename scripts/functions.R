library(tidyverse)
library(gt)
library(tools)

# Plot ----
create_plot <- function(data, column_name) {
  data %>%
    pull({{ column_name }}) %>%
    strsplit(",") %>%
    unlist() %>%
    tibble(value = .) %>%
    filter(!is.na(value)) %>%
    group_by(value) %>%
    count() %>%
    ggplot(aes(x = reorder(value, n), y = n)) +
    geom_col(fill = "midnightblue", 
             width = 0.25,
             position = "dodge") +
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
          axis.text.y = element_text(family = "serif", size = 10)) 
}



# Table ----

create_frequency_table <- function(data, variable, levels, county) {
  data %>%
    filter(county == {{ county }}) %>%
    count({{ variable }}) %>%
    filter(!is.na({{ variable }})) %>%  # Remove NA row
    mutate({{ variable }} := factor({{ variable }}, levels = {{ levels }})) %>%
    complete({{ variable }}, fill = list(n = 0)) %>%
    mutate(Percentage = round(n / sum(n) * 100, 2)) %>%
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
    tab_source_note(paste("Updated", Sys.Date(), sep = " "))
}


