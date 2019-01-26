library(shiny)
library(shinyWidgets)
library(shinydashboard)
# Define UI

  fluidPage(
  setBackgroundColor("white"),
  # Application title
    titlePanel("The Astronomy Picture of the Day"),
  # Sidebar
    sidebarLayout(
      sidebarPanel(
        "The Astronomy Picture of the Day program was begun in 1995 and is currently the largest collection of annotated astronomical images on the internet.  It is one of the most popular federally-subsidized websites in America.",
        HTML("<br> </br>"),
        "You can explore sentiment analysis of APOD explanations in the Plots tab and see stats for each image in the Table tab.",
        HTML("<br> </br>"),
        wordcloud2Output("cloud"),
        width = 4
      ),
      mainPanel(
        tabsetPanel(
          tabPanel("Plots", plotlyOutput("chosenplot"),
                   selectInput("plotchoice", "Choose plot", 
                               choices = c("Top 10 Sentiment Scores", "Bottom 10 Sentiment Scores", "Overall sentiment distribution"),
                               selected = "Top 10 Sentiment Scores") 
                   ),
          tabPanel("Table", dataTableOutput("dt"))
        )
      )
    )
  )