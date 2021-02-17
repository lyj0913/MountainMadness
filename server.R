#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
getwd()
library(shiny)
library(datasets)
library(forecast)
library(tidyquant)
library(zoo)

ETF_Data <- new.env()
options("getSymbols.warning4.0"=FALSE)
options("getSymbols.yahoo.warning"=FALSE)
tickers <-c("IBM","ADBE","CMCSA","CSCO","T","MA","V","FB","GOOGL","AMZN","AAPL","MSFT")
getSymbols(tickers, env=ETF_Data,from = "2010-12-20",to = "2021-02-13")
# Extract the Adjusted column from all objects,
# then merge all columns into one object
ETF_Adj_Data <- do.call(merge, eapply(ETF_Data, Ad))
# then extract the monthly closing price
Monthly_ETF_Adj_Data <- ETF_Adj_Data[endpoints(ETF_Adj_Data,'months')]

AAPL<-Monthly_ETF_Adj_Data[,1]
GOOGL<-Monthly_ETF_Adj_Data[,2]
IBM<-Monthly_ETF_Adj_Data[,3]
CSCO<-Monthly_ETF_Adj_Data[,4]
MA<-Monthly_ETF_Adj_Data[,5]
AMZN<-Monthly_ETF_Adj_Data[,6]
ADBE<-Monthly_ETF_Adj_Data[,7]
MSFT<-Monthly_ETF_Adj_Data[,8]
CMCSA<-Monthly_ETF_Adj_Data[,9]
FB<-Monthly_ETF_Adj_Data[,10]
T.adj<-Monthly_ETF_Adj_Data[,11]
V.adj<-Monthly_ETF_Adj_Data[,12]


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$distPlot <- renderPlot({
        
        SelectedStock<-reactive({
            switch(input$var,
                   "Apple"=AAPL,"Google"=GOOGL,"IBM"=IBM,"Cisco"=CSCO,"MasterCard"=MA,"Amazon"=AMZN,"Adobe"=ADBE,"Microsoft"=MSFT,"Comcast_Corporation"=CMCSA,"Facebook"=FB,"AT&T"=T.adj,"Visa"=V.adj)
        })
        
        fit <- auto.arima(SelectedStock())
        label <- c(Monthly_ETF_Adj_Data[1,0],Monthly_ETF_Adj_Data[20,0],Monthly_ETF_Adj_Data[40,0],Monthly_ETF_Adj_Data[60,0],Monthly_ETF_Adj_Data[80,0],Monthly_ETF_Adj_Data[100,0],Monthly_ETF_Adj_Data[120,0])
        plot(forecast(fit, h=input$num),xlab = "Date", ylab = "Monthly Average Closing Price", main = "Forecasting",xaxt = 'n') 
       axis(side = 1, at = c(0,20,40,60,80,100,120),labels = c("2010-12-30","2012-07-30","2014-03-30","2015-11-29","2017-07-30","2019-03-28","2020-11-29"))
    })
    
})
