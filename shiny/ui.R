# Define UI
ui <- fluidPage(
  titlePanel("SGMC CHNA Data Explorer"),  # Set the title
  sidebarLayout(
    sidebarPanel(
      selectInput("county", "County", c("All", county_levels)),
      selectInput("age", "Age Group", c("All", age_levels)),
      selectInput("gender", "Gender", c("All", gender_levels))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          "Community Health",
          plotOutput("community_health_plot")
        ),
        tabPanel(
          "Social Behaviors",
          plotOutput("social_behaviors_plot")
        )
      )
    )
  )
)