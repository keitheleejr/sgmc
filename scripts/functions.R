library(tidyverse)
library(gt)
library(tools)

# Plot ----
create_plot <- function(data, column_name, caption) {
  data %>%
    pull({{ column_name }}) %>%
    strsplit(",") %>%
    unlist() %>%
    tibble(value = .) %>%
    filter(!is.na(value)) %>%
    group_by(value) %>%
    count() %>%
    ggplot(aes(x = reorder(value, n), y = n)) +
    geom_col(fill = "#006f53", 
             width = 0.25,
             position = "dodge") +
    coord_flip() +
    labs(
      x = "",
      y = "",
      caption = {{ caption }}
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

create_frequency_table <- function(data, variable, levels, county, title, subtitle) {
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
    tab_options(table.align = "left",
                heading.align = "left",
                column_labels.background.color = "#006f53",
                container.width = 500) |> 
    tab_header(
      title = {{ title }},
      subtitle = {{ subtitle }}) |> 
    tab_style(
      style = cell_text(
        color = "#006f53",
        weight = "bold",
        font = "serif"),
      locations = cells_title(groups = "title")
    )
}


