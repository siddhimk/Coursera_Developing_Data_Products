library(shiny)
library(plotly)
library(ggplot2)

shinyServer(function(input, output) {
  
  # Build a model for predicting Ozone based on the Temperature using Linear Regression
  mdl1 <- lm(Ozone ~ Temp, data=airquality)
  
  prd_mdl1 <- reactive({
    temperature <- input$slider_temp
    predict(mdl1, newdata=data.frame(Temp = temperature))
  })
  
  output$prd1 <- renderText({
    prd_mdl1()
  })
  
  # Build a model for predicting Ozone based on the Solar Radiation using Linear Regression
  mdl2 <- lm(Ozone ~ Solar.R, data=airquality)
  
  prd_mdl2 <- reactive({
    solar_rad <- input$slider_solar
    predict(mdl2, newdata=data.frame(Solar.R = solar_rad))
  })
  
  output$prd2 <- renderText({
    prd_mdl2()
  })
  
  # Build a model for predicting Ozone based on the Wind using Linear Regression
  mdl3 <- lm(Ozone ~ Wind, data=airquality)
  
  prd_mdl3 <- reactive({
    wnd <- input$slider_wind
    predict(mdl3, newdata=data.frame(Wind = wnd))
  })
  
  output$prd3 <- renderText({
    prd_mdl3()
  })
  
  # Plot showing relationship between Ozone and Temperature 
  output$plt1 <- renderPlotly({
    temperature <- input$slider_temp
    min_temp <- min(airquality[complete.cases(airquality),]$Temp) - 5
    max_temp <- max(airquality[complete.cases(airquality),]$Temp) + 5
    min_ozone <- min(airquality[complete.cases(airquality),]$Ozone) - 5
    max_ozone <- max(airquality[complete.cases(airquality),]$Ozone) + 5
    
    grph1 <- ggplot(
      airquality, aes(
        y = airquality$Ozone,
        x = airquality$Temp
      ),
      bty = "n",
      pch = 16,
      xlim = c(min_temp, max_temp),
      ylim = c(min_ozone, max_ozone)
    ) +
      geom_point() +
      ylab('Ozone (in parts per billion)') +
      xlab('Temperature (in degrees Fahrenheit)')
    
    grph1 <- grph1 + stat_smooth(method='lm', color="#CC79A7", lwd=1)
    grph1 <- grph1 + ggtitle("Ozone Prediction Using Temperature as Predictor")
    grph1 <- grph1 + geom_point(x=temperature, y=prd_mdl1(), position="identity", col="#D55E00", pch=16, cex=4)
    
    ggplotly(grph1)              
    
  })
  
  # Plot showing relationship between Ozone and Solar Radiation     
  output$plt2 <- renderPlotly({
    solar <- input$slider_solar
    min_temp <- min(airquality[complete.cases(airquality),]$Solar.R) - 5
    max_temp <- max(airquality[complete.cases(airquality),]$Solar.R) + 5
    min_ozone <- min(airquality[complete.cases(airquality),]$Ozone) - 5
    max_ozone <- max(airquality[complete.cases(airquality),]$Ozone) + 5
    
    grph2 <- ggplot(
      airquality, aes(
        y = airquality$Ozone,
        x = airquality$Solar.R
      ),
      bty = "n",
      pch = 16,
      xlim = c(min_solar, max_solar),
      ylim = c(min_ozone, max_ozone)
    ) + 
      geom_point() + 
      ylab('Ozone (in parts per billion)') +
      xlab('Solar Radiation (in Langleys)')
    
    grph2 <- grph2 + stat_smooth(method='lm', color="#E69F00", lwd=1)
    grph2 <- grph2 + ggtitle("Ozone Prediction Using Solar as Predictor")
    grph2 <- grph2 + geom_point(x=solar, y=prd_mdl2(), position="identity", col="#D55E00", pch=16, cex=4)
    
    ggplotly(grph2)              
    
  })
  
  # Plot showing relationship between Ozone and Wind 
  output$plt3 <- renderPlotly({
    wind <- input$slider_wind
    min_temp <- min(airquality[complete.cases(airquality),]$Wind) - 5
    max_temp <- max(airquality[complete.cases(airquality),]$Wind) + 5
    min_ozone <- min(airquality[complete.cases(airquality),]$Ozone) - 5
    max_ozone <- max(airquality[complete.cases(airquality),]$Ozone) + 5
    
    grph3 <- ggplot(
      airquality, aes(
        y = airquality$Ozone,
        x = airquality$Wind,
      ),
      bty = "n",
      pch = 16,
      xlim = c(min_wind, max_wind),
      ylim = c(min_ozone, max_ozone)
    ) + 
      geom_point() + 
      ylab('Ozone (in parts per billion)') +
      xlab('Wind (in miles per hour)')
    
    grph3 <- grph3 + stat_smooth(method='lm', color="#56B4E9", lwd=1)
    grph3 <- grph3 + ggtitle("Ozone Prediction Using Wind as Predictor")
    grph3 <- grph3 + geom_point(x=wind, y=prd_mdl3(), position="identity", col="#D55E00", pch=16, cex=4)
    
    ggplotly(grph3)              
    
  })
  
  # Function to capture temperature value selected on slider 
  output$selected_temp <- renderText({
    paste("Currently selected value for Temperature is: ", input$slider_temp)
  })
  
  # Function to capture solar radiation value selected on slider
  output$selected_solar <- renderText({
    paste("Currently selected value for Solar Raditaion is: ", input$slider_solar)
  })
  
  # Function to capture wind value selected on slider
  output$selected_wind <- renderText({
    paste("Currently selected value for Wind is: ", input$slider_wind)
  })
  
})