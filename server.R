
library(shiny)
library(png)

shinyServer(function(input, output) {
   
  output$cloud <- renderWordcloud2({
    wordcloud2(cloud_data, color = "random-dark",
               backgroundColor = "grey",
               shuffle = FALSE,
               shape = "circle"
               )
  })

  output$dt = renderDataTable({
    mergedata[,c('Date', 'Title', 'favorite_count', 'retweet_count')] 
 
})
})  

