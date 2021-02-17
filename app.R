
library(shiny)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(cowplot)

Amazon = read_csv("AMZN.csv")
Apple = read_csv("AAPL.csv")

name_df = data_frame("name"=c("Apple","Amazon"))

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Show the stock data in specific period of time"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("stock",
                        label = strong("Stock"),
                        choices = name_df$name,
                        selected = "Apple"),
            checkboxGroupInput("item",
                               strong("Select Item"),
                               choices = c("Close","High","Low","Open"),
                               selected = "Close"),
            
            dateRangeInput("date", strong("Date range"), start = "2020-02-13", end = "2021-02-12",
                           min = "2020-02-13", max = "2021-02-12"),
            
            numericInput("price",label = strong("Price"),value=0)
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                type = "tabs",
                tabPanel("Plot",plotOutput("lineplot",height = "300px")),
                tabPanel("Revenue",plotOutput("revenue")),
                tabPanel("Data",DT::dataTableOutput("table"))
            )
        ))
)

# Define server logic required to draw a histogram
server <- function(input, output){
    SelectedStock<-reactive({
        switch(input$stock,
               "Apple"=Apple,
               "Amazon"=Amazon)
    })
    
    SelectedDate=reactive({
        SelectedStock() %>%
            filter(Date>=input$date[1],Date<=input$date[2]) %>%
            mutate(Rev=Close-input$price) %>%
            mutate(Price=ifelse(Rev<0,"neg","pos"))
    })
    
    itemType = reactive({
        as.vector(input$item)
    })
    
    output$lineplot = renderPlot({
        g=ggplot(SelectedDate(),aes(x=Date))
        
        if("Close" %in% itemType()){g=g+geom_line(aes(y=Close))}
        if("Open" %in% itemType()){g=g+geom_line(aes(y=Open))}
        if("High" %in% itemType()){g=g+geom_line(aes(y=High))}
        if("Low" %in% itemType()){g=g+geom_line(aes(y=Low))}
        
        print(g)
    })
    
    output$revenue = renderPlot(
        ggplot(SelectedDate(),aes(x=Date,y=Rev))+geom_area(aes(fill=Price))+geom_line()+geom_hline(yintercept=0))
    
    
    output$table <- DT::renderDataTable(
        DT::datatable(SelectedDate(), options = list(pageLength = 25)))
    
}

# Run the application 
shinyApp(ui = ui, server = server)
