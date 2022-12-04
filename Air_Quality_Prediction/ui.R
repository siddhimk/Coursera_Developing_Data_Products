# Load packages
library(shiny)
library(plotly)

# Define UI for input and output
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Air Quality Predictions"),
  
  # Sidebar with three slider inputs for getting Temperature, Solar Radiation and Wind values from the user
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider_temp",
                  "Choose Temperature (in degrees Fahrenheit):",
                  min = min(airquality[complete.cases(airquality),]$Temp) - 10,
                  max = max(airquality[complete.cases(airquality),]$Temp) + 10,
                  value = 65),
      
      sliderInput("slider_solar",
                  "Choose Solar Radiation (in Langleys):",
                  min = min(airquality[complete.cases(airquality),]$Solar.R) - 20,
                  max = max(airquality[complete.cases(airquality),]$Solar.R) + 20,
                  value = 100),
      
      sliderInput("slider_wind",
                  "Choose Wind Speed (in miles per hour):",
                  min = min(airquality[complete.cases(airquality),]$Wind) - 1,
                  max = max(airquality[complete.cases(airquality),]$Wind) + 1,
                  value = 5.5),
      
    ),
    
    # Show the predicted values of Ozone based on the Temperature, Solar Radiation and Wind values chosen. 
    mainPanel(
      # Tab structure for displaying linear regression model outputs and corresponding plots
      tabsetPanel(type="tabs",
                  tabPanel("Temperature Model",
                           h2("Ozone Prediction Using Temperature"),
                           h2(textOutput("prd1")),
                           h3("Linear Regression"),
                           h4("Please choose value from the Temperature slider (slider 1) to get new Ozone prediction"),
                           h4(textOutput("selected_temp")), 
                           h4(""),
                           plotlyOutput("plt1")
                  ),
                  
                  tabPanel("Solar Radiation Model",
                           h2("Ozone Prediction Using Solar Radiation"),
                           h2(textOutput("prd2")),
                           h3("Linear Regression"),
                           h4("Please choose value from the Solar Radiation slider (slider 2) to get new Ozone prediction"),
                           h4(textOutput("selected_solar")), 
                           h4(""),
                           plotlyOutput("plt2")
                  ),
                  
                  tabPanel("Wind Model",
                           h2("Ozone Prediction Using Wind"),
                           h2(textOutput("prd3")),
                           h3("Linear Regression"),
                           h4("Please choose value from the Wind slider (slider 3) to get new Ozone prediction"),
                           h4(textOutput("selected_wind")), 
                           h4(""),
                           plotlyOutput("plt3")
                  )
      )
      
    )
  )
))