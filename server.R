
library(shiny)
library(png)
library(plotly)

shinyServer(function(input, output) {
  plottest <- reactive({
    if (input$plotchoice == "Top 10 Sentiment Scores") return(top10sent)
    if (input$plotchoice == "Bottom 10 Sentiment Scores") return(bottom10sent)
    if (input$plotchoice == "Overall sentiment distribution") return(sent)
  })
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
  top10sent <- ggplot(sentiments[1:10,], aes(word, sentiment, fill = sentiment)) +
    geom_col() +
    scale_y_continuous("", position = "top") +
    labs(x = "Word in APOD Explanation", y = "Sentiment Score", title = "Top 10 words Sentiment Analysis")

  bottom10sent <- ggplot(tail(sentiments, 10), aes(word, sentiment, fill = sentiment)) +
    geom_col() +
    theme(axis.text.x = element_text(angle = 45)) +
    scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
    scale_y_continuous("", position = "top") +
    labs(x = "Word in APOD Explanation", y = "Sentiment Score", title = "Bottom 10 Words Sentiment Analysis")
  
  sent <- ggplot(sentiments, aes(word, sentiment, fill = sentiment)) +
    geom_col() +
    theme(axis.text.x = element_text(angle = 45)) +
    scale_y_continuous("", position = "top") +
    labs(x = "", y = "Sentiment Score", title = "2017 Sentiment Analysis") +
    theme(axis.text.y = element_blank()) +
    coord_flip()
  
  output$chosenplot <- renderPlotly(ggplotly(plottest()))
  #output$astropic <- '<body><img src="https://apod.nasa.gov/apod/image/1701/Comet45P_Hemmerich_960.jpg" alt="https://apod.nasa.gov/apod/image/1701/Comet45P_Hemmerich_960.jpg" class="shrinkToFit" width="626" height="553"></body>'
})  

