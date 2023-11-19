library(shinythemes)

# Source Files


source("scripts/getData.R")
source("scripts/subsetData.R")
source("scripts/levels.R")
source("scripts/functions.R")
# Define UI
ui <- fluidPage(theme = shinytheme("lumen"),
                fluidRow(
                  column(12, titlePanel("SGMC CHNA Data Explorer"))  # Set the title
                ),
                fluidRow(
                  column(6,
                         selectInput("county", "County", c("All", county_levels))),
                  column(6,
                         selectInput("age", "Age Group", c("All", age_levels)))),
                fluidRow(
                  h2("Community Health")
                ),
                fluidRow(
                  column(12,
                         tabsetPanel(
                           tabPanel(
                             "Primary Health Problems",
                             plotOutput("community_health_plot")
                           ),
                           tabPanel(
                             "Adverse Social Factors",
                             plotOutput("social_behaviors_plot")
                           ),
                           tabPanel(
                             "Healthcare Service Needs",
                             plotOutput("healthcare_services_plot")
                           )
                         )
                  )
                ),
                fluidRow(
                  h2("Individual Healthcare Needs, Access, and Utilization")
                ),
                fluidRow(
                  column(12,
                         tabsetPanel(
                           tabPanel(
                             "Perceptions",
                             div(gt_output("perceptions"),style = "margin: auto;")
                           ),
                           tabPanel(
                             "Satisfaction",
                             gt_output("satisfaction")
                           ),
                           tabPanel(
                             "Insurance",
                             gt_output("insurance")
                           ),
                           tabPanel(
                             "Primary Care Physician",
                             gt_output("pcp")
                           ),
                           tabPanel(
                             "Wait Times",
                             gt_output("wait_time")
                           ),
                           tabPanel(
                             "Specialists",
                             gt_output("specialist")
                           ),
                           tabPanel(
                             "Primary Care Facility",
                             gt_output("location")
                           ),
                           tabPanel(
                             "Treatment Outside County",
                             gt_output("outside")
                           ),
                           tabPanel(
                             "Where Outside County",
                             gt_output("outwhere")
                           ),
                           tabPanel(
                             "Telehealth",
                             gt_output("telehealth")
                           )
                         )
                  )
                )
)

