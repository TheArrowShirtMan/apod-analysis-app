
library(shiny)
library(shinyWidgets)
library(shinydashboard)
# Define UI
shinyUI(navbarPage(
  #setBackgroundColor("grey"),
  # Application title
  titlePanel("The Astronomy picture of the day"),
# Sidebar
  sidebarLayout(
    sidebarPanel(
      "The Astronomy Picture of the Day program was begun in 1995 and is currently the largest collection of annotated astronomical images on the internet.  It is one of the most popular federally-subsidized websites in America.",
      HTML("<br> </br>"),
      "Click a title in the table below to see a preview of the image and click the url at the right to go to APOD's website and see the full description!",
      HTML("<br> </br>"),
      wordcloud2Output("cloud")
    ),
    mainPanel(
      htmlOutput("astropic"),
      #plotlyOutput("sent"),
      dataTableOutput("dt")
    )
  )
))
