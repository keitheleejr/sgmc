

# Define server logic
server <- function(input, output) {
  
  # Reactive expression for filtering data based on selected factors
  filtered_community_health_data <- reactive({
    df <- community_health_split
    if (input$county != "All") {
      df <- subset(df, county %in% input$county)
    }
    if (input$age != "All") {
      df <- subset(df, age %in% input$age)
    }
    df
  })
  
  # Reactive expression for filtering data based on selected factors for social factors
  filtered_social_behaviors_data <- reactive({
    df <- social_behaviors_split  # Replace with your social factors data frame
    if (input$county != "All") {
      df <- subset(df, county %in% input$county)
    }
    if (input$age != "All") {
      df <- subset(df, age %in% input$age)
    }
    df
  })
  
  # Reactive expression for filtering data based on selected factors for social factors
  filtered_healthcare_services_data <- reactive({
    df <- healthcare_access_data  # Replace with your social factors data frame
    if (input$county != "All") {
      df <- subset(df, county %in% input$county)
    }
    if (input$age != "All") {
      df <- subset(df, age %in% input$age)
    }
    df
  })
  
  filtered_table_data <- reactive({
    df <- data
    if (input$county != "All") {
      df <- subset(df, county %in% input$county)
    }
    if (input$age != "All") {
      df <- subset(df, age %in% input$age)
    }
    df
  })
  
  # Update the Community Health plot based on the selected data
  output$community_health_plot <- renderPlot({
    # Check if any selections have been made
    req(input$county, input$age)
    
    # Count factor occurrences based on selected demographic variables for community health
    factor_counts <- table(filtered_community_health_data()$community_health)
    
    # Check if factor_counts is empty or contains only NAs
    if (length(factor_counts) == 0 || all(is.na(factor_counts))) {
      # Display a message if there's no valid data
      ggplot() +
        geom_point(aes(1, 1), size = 0) +
        theme_void() +
        ggtitle("No valid data to display")
    } else {
      # Create a ggplot bar plot without legend for community health
      ggplot(data.frame(Community_Health = names(factor_counts), Count = as.numeric(factor_counts)),
             aes(x = reorder(Community_Health, Count), y = Count)) +
        geom_col(fill = "#006f53",
                 width = 0.5) +
        coord_flip() +
        theme_minimal() +
        labs(x = "",
             y = "",
             title = "What do you think are the most important health problems in the community?") +
        geom_text(aes(label = Count, hjust = 1.25), size = 4, color = "white") +
        theme(legend.position = "none",
              text = element_text(family = "serif"),
              plot.title = element_text(family = "serif", size = 20, hjust = -1.5),
              axis.title.x = element_text(family = "serif", size = 16),
              axis.title.y = element_text(family = "serif", size = 16),
              axis.text.x = element_text(family = "serif", size = 14),
              axis.text.y = element_text(family = "serif", size = 14)) +
        theme(legend.position = "none")
    }
  })
  
  # Update the Social Behaviors plot based on the selected data
  output$social_behaviors_plot <- renderPlot({
    # Check if any selections have been made for social behaviors
    req(input$county, input$age)
    
    # Count factor occurrences based on selected demographic variables for social behaviors
    factor_counts_social <- table(filtered_social_behaviors_data()$social_behaviors)  # Replace with your social factors column name
    
    # Check if factor_counts_social is empty or contains only NAs
    if (length(factor_counts_social) == 0 || all(is.na(factor_counts_social))) {
      # Display a message if there's no valid data for social behaviors
      ggplot() +
        geom_point(aes(1, 1), size = 0) +
        theme_void() +
        ggtitle("No valid data to display")
    } else {
      # Create a ggplot bar plot without legend for social behaviors
      ggplot(data.frame(Social_Behavior = names(factor_counts_social), Count = as.numeric(factor_counts_social)),
             aes(x = reorder(Social_Behavior, Count), y = Count, fill = Social_Behavior)) +
        geom_col(fill = "#006f53",
                 width = 0.5) +
        coord_flip() +
        theme_minimal() +
        labs(x = "",
             y = "",
             title = "What are the most important factors that impact local community health?") +
        geom_text(aes(label = Count, hjust = 1.25), size = 4, color = "white") +
        theme(legend.position = "none",
              text = element_text(family = "serif"),
              plot.title = element_text(family = "serif", size = 20, hjust = -1.5),
              axis.title.x = element_text(family = "serif", size = 16),
              axis.title.y = element_text(family = "serif", size = 16),
              axis.text.x = element_text(family = "serif", size = 14),
              axis.text.y = element_text(family = "serif", size = 14)) +
        theme(legend.position = "none")
    }
  })
  
  # Update the Healthcare Services plot based on the selected data
  output$healthcare_services_plot <- renderPlot({
    # Check if any selections have been made for social behaviors
    req(input$county, input$age)
    
    # Count factor occurrences based on selected demographic variables for social behaviors
    factor_counts_healthcare_service <- table(filtered_healthcare_services_data()$healthcare_service)  # Replace with your social factors column name
    
    # Check if factor_counts_social is empty or contains only NAs
    if (length(factor_counts_healthcare_service) == 0 || all(is.na(factor_counts_healthcare_service))) {
      # Display a message if there's no valid data for social behaviors
      ggplot() +
        geom_point(aes(1, 1), size = 0) +
        theme_void() +
        ggtitle("No valid data to display")
    } else {
      # Create a ggplot bar plot without legend for social behaviors
      ggplot(data.frame(Healthcare_Service = names(factor_counts_healthcare_service), Count = as.numeric(factor_counts_healthcare_service)),
             aes(x = reorder(Healthcare_Service, Count), y = Count, fill = Healthcare_Service)) +
        geom_col(fill = "#006f53",
                 width = 0.5) +
        coord_flip() +
        theme_minimal() +
        labs(x = "",
             y = "",
             title = "What one healthcare service, if readily available, would have the greatest positive impact on the health of the community?") +
        geom_text(aes(label = Count, hjust = 1.25), size = 4, color = "white") +
        theme(legend.position = "none",
              text = element_text(family = "serif"),
              plot.title = element_text(family = "serif", size = 16, hjust = 1.25),
              axis.title.x = element_text(family = "serif", size = 16),
              axis.title.y = element_text(family = "serif", size = 16),
              axis.text.x = element_text(family = "serif", size = 14),
              axis.text.y = element_text(family = "serif", size = 14)) +
        theme(legend.position = "none")
    }
  })

  
  
  renderTable <- function(column, column_levels, question) {
    table <- render_gt({
      df <- filtered_table_data()
      df %>%
        count({{ column }}) %>%
        filter(!is.na({{ column }})) %>%  # Remove NA row
        mutate({{ column }} := factor({{ column }}, levels = {{ column_levels }})) %>%
        complete({{ column }}, fill = list(n = 0)) %>%
        mutate(Percentage = round(n / sum(n) * 100, 2)) %>%
        gt() %>%
        cols_label(
          {{ column }} := "Response",
          n = "Count"
        ) %>%
        cols_align(
          align = "left",
          columns = {{ column }}
        ) %>%
        tab_options(
          table.align = "left",
          heading.align = "left",
          column_labels.background.color = "#006f53"
        ) |>
        tab_header(
          title = {{ question }}) |> 
        tab_style(
          style = cell_text(
            color = "#006f53",
            weight = "bold",
            font = "serif"
          ),
          locations = cells_title(groups = "title") 
        ) |> 
        tab_options(
          table.width = px(500)
        )
    })
  }
  

  output$perceptions <- renderTable(perception,
                                    perception_levels,
                                    "Which choice best describes the community’s perception of the local hospital’s services?")

  output$satisfaction <- renderTable(satisfaction,
                                     satisfaction_levels,
                                     "If you have utilized hospital services or facilities in the past 3 years, how would you rate your experience(s)?")
  
  output$insurance <- renderTable(insurance,
                                  insurance_levels,
                                  "What type of health insurance coverage do you have?")
  
  output$pcp <- renderTable(pcp,
                            pcp_levels,
                            "Do you have a primary care physician (PCP)?")
  
  output$wait_time <- renderTable(wait_time,
                                  wait_time_levels,
                                  "What is your experience with appointment wait times for primary care providers?")
  
  output$specialist <- renderTable(specialist,
                                   specialist_levels,
                                   "Have you seen a healthcare specialist in the past 2 years?")
  
  output$location <- renderTable(where_care,
                                 where_care_levels,
                                 "When you need medical care, where do you typically receive care?")
  
  output$outside <- renderTable(outside_comm,
                                outside_comm_levels,
                                "In the past 12 months, have you sought medical care outside of the local community or county in which you live?")
  
  output$outwhere <- renderTable(outside_comm_where,
                                 outside_comm_where_levels,
                                 "If seeking care outside of the county, where do you go for care?")
  
  output$telehealth <- renderTable(telehealth,
                                   telehealth_levels,
                                   "Which statement best describes your willingness to use telehealth or telemedicine services?")
  
  
}
