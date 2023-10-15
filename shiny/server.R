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
    if (input$gender != "All") {
      df <- subset(df, gender %in% input$gender)
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
    if (input$gender != "All") {
      df <- subset(df, gender %in% input$gender)
    }
    df
  })
  
  # Update the Community Health plot based on the selected data
  output$community_health_plot <- renderPlot({
    # Check if any selections have been made
    req(input$county, input$age, input$gender)
    
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
             aes(x = reorder(Community_Health, -Count), y = Count, fill = Community_Health)) +
        geom_bar(stat = "identity") +
        theme_minimal() +
        labs(title = "Community Health Issue Counts", x = "Community Health Issue", y = "Count") +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        theme(legend.position = "none")
    }
  })
  
  # Update the Social Behaviors plot based on the selected data
  output$social_behaviors_plot <- renderPlot({
    # Check if any selections have been made for social behaviors
    req(input$county, input$age, input$gender)
    
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
             aes(x = reorder(Social_Behavior, -Count), y = Count, fill = Social_Behavior)) +
        geom_bar(stat = "identity") +
        theme_minimal() +
        labs(title = "Social Behavior Counts", x = "Social Behavior", y = "Count") +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        theme(legend.position = "none")
    }
  })
}