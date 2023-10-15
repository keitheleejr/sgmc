library(tidyverse)
library(gt)
library(tools)

# Plot ----
create_plot <- function(data, column_name, x_label) {
  data %>%
    pull({{ column_name }}) %>%
    strsplit(",") %>%
    unlist() %>%
    tibble(value = .) %>%
    filter(!is.na(value)) %>%
    group_by(value) %>%
    count() %>%
    ggplot(aes(x = reorder(value, n), y = n, fill = value)) +
    geom_col() +
    coord_flip() +
    labs(
      x = x_label,
      y = "Number of Respondents",
      caption = paste("Updated", Sys.Date(), sep = " ")
    ) +
    geom_text(aes(label = n, hjust = 1.25)) +
    theme_classic() +
    theme(legend.position = "none")
}


# Table ----

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
    cols_hide(Ordered) |> 
    tab_source_note(paste("Updated", Sys.Date(), sep = " "))
}

