
library(shiny)
library(png)
library(plotly)

shinyServer(function(input, output) {
   
  output$cloud <- renderWordcloud2({
    wordcloud2(cloud_data, color = "random-dark",
               shuffle = FALSE,
               shape = "circle"
               )
  })

  output$dt = renderDataTable(
    expr = mergedata[,c('Date', 'Title', 'favorite_count', 'retweet_count', 'nasahtml')],
    escape = FALSE
 
)
  sent <- ggplot(sentiments, aes(word, sentiment)) +
    geom_col() +
    scale_y_continuous("", position = "top") +
    labs(x = "Word in APOD Explanation", y = "Sentiment Score", title = "2017 Sentiment Analysis") +
    coord_flip()
  output$sent <- renderPlotly(ggplotly(sent))
  #output$astropic <- '<body><img src="https://apod.nasa.gov/apod/image/1701/Comet45P_Hemmerich_960.jpg" alt="https://apod.nasa.gov/apod/image/1701/Comet45P_Hemmerich_960.jpg" class="shrinkToFit" width="626" height="553"></body>'
})  

