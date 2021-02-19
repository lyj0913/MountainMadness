### Team Name: <h3> 
###### Stock at there <h6>
### Team Member: <h3> 
###### Jim Lee, mla222@sfu.ca, Yijing Liang, yla507@sfu.ca, Cynthia Huang, minzhih@sfu.ca, yanyou zuo, yanyouz@sfu.ca <h6>

![](WechatIMG165.png)

### Brief description: <h3> 
Our project topic is stock. We have created three different Shinyapps with Rstudio. 
Shinyapps.io is a self-service platform that makes it easy for you to share your shiny applications on the web in just a few minutes. Many customers use shinyapps.io to prove out some concepts, build out a prototype, or just run it for a short period of time for their own purposes, while others are using it as a core component of their analytical offerings within a larger online property. (shinyapps.io user guide: https://docs.rstudio.com/shinyapps.io/)

The service runs in the cloud on shared servers that are operated by RStudio. Each application is self-contained and operates on either data that is uploaded with the application, or data that the code pulls from third-party data stores, such as databases or web services.
These three apps has different tab which could allow the user select different desire informations for different stock and properties. The app functions include data visluzation, and forecasting. By transforming the data into easy-reading visluzation, our project enabled people gain better insight of stock.

### How to run: <h3> 
This program is provide by R code and R studio, the libraries we applied are: 
Insure the library is set:
* shiny:  install.packages('shiny')
* datasets:  install.packages('datasets')
* forecast:  install.packages('forecast')
* tidyquant:  install.packages('tidyquant')
* zoo:  install.packages('zoo') #sould be install during tidyquant
* ggplot2:  install.packages('ggplot2')
* tidyverse:  install.packages('tidyverse')
* dplyr:  install.packages('dplyr')
* cowplot:  install.packages('cowplot')

After the Library install, the data will be auto-connect to the finance database. The forecast system will analyze the next possible price of the stock.
* You will be able to use:
  * http://127.0.0.1:5961  (or you localhost: ) 
  
  Also can be access to our demo page:
  Might need to wait for few seconds to have the plots appeared on the main tab since the dataset is a bit larger in the time series forecast page.
  * Time series forecasting page: https://yla507.shinyapps.io/hackthon2021/
  * Stock Data Visualization page: https://yla507.shinyapps.io/appp/
  * Show the stock data in specific period of time page: https://yla507.shinyapps.io/yoyo/
