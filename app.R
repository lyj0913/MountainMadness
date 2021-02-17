library(shiny)
library(ggplot2)


## For data reading, please put the csv file and R code in the same folder
## Do not change the name of csv file. Data will be read in.
Amazon <- read.csv("AMZN.csv")
Apple <- read.csv("AAPL.csv")
Amazon=Amazon[1:60,]
Apple=Apple[1:60,]
name_df=data.frame("name"=c("Open","High","Low","Close","Adj.Close","Volume"))
name_df2=data.frame("name"=c("Apple","Amazon"))


ui <- fluidPage(
    
    # Application title
    titlePanel("Stock Data Visualization"),
    
    sidebarLayout(
        sidebarPanel(
            
            ### For choosing different properties with stock
            selectInput("AAA","SELECT ITEMS",
                        choices = name_df$name,
                        selected = name_df$name[1]),
            ### For choosing different stock 
            selectInput("BBB","SELECT STOCK",
                        choices = name_df2$name,
                        selected = name_df2$name[1])
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("good")
        )
    )
)



server <- function(input,output){
    ### customizing plot 
    output$good<-renderPlot({
        
        if(input$BBB=="Apple")
        {  
            if(input$AAA=="Open")
            {
                shape=8
            }
            if(input$AAA=="High")
            {
                shape=4
            }
            if(input$AAA=="Low")
            {
                shape=11
            }
            if(input$AAA=="Close")
            {
                shape=7
            }
            if(input$AAA=="Adj.Close")
            {
                shape=9
            }
            if(input$AAA=="Volume")
            {
                shape=10
            }
            data<-Apple[1:60,]
            x=Apple[,1]
            y=Apple[,input$AAA]
            color='brown3'
            
        }
        if(input$BBB=="Amazon")
        {
            if(input$AAA=="Open")
            {
                shape=8
            }
            if(input$AAA=="High")
            {
                shape=4
            }
            if(input$AAA=="Low")
            {
                shape=11
            }
            if(input$AAA=="Close")
            {
                shape=7
            }
            if(input$AAA=="Adj.Close")
            {
                shape=9
            }
            if(input$AAA=="Volume")
            {
                shape=10
            }
            data<-Amazon[1:60,]
            x=Amazon[,1]
            y=Amazon[,input$AAA]
            color='turquoise3'
            
            
        }
        ggplot(data=data,aes(x=x,y=y))+geom_point(shape=shape,color=color, size=4)+theme(axis.text.x = element_text(angle=90,vjust = 0.5,colour = "black"),axis.text=element_text(size=11),axis.title=element_text(size=13),axis.text.y = element_text(colour = "black"))+labs(x="Date")+labs(y="Value")+ ggtitle("Date VS Value")
        
    })
    
    
}
shinyApp(ui = ui, server = server)