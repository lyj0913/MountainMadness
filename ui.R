#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
getwd()
library(shiny)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(cowplot)
name_df = data_frame("name"=c("Apple","Google","IBM","Cisco","MasterCard","Amazon","Adobe","Microsoft","Comcast_Corporation","Facebook","AT&T","Visa"))
#IBM Paypal Netflix NVDA Oracle Adobe Comcast_Corporation cisco AT&T MasterCard Visa Facebook Alphabet Amozan Apple Microsoft
# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Time series forecasting"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            helpText("stock market forecasting"),
            selectInput("var",
                        label = strong("Choose a stock to display"),
                        choices = name_df$name,
                        selected = "Apple"),
            
            numericInput("num",label = "Please enter the days you want to forecast ((max=20))",1,min = 1, max =20),
            br(),
            submitButton("Let's forecast!")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))