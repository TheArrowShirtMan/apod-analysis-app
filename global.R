library(shiny)
library(shinydashboard)
library(ggplot2)
library(leaflet)
library(tidyverse)
library(dplyr)
library(tm)
library(httr)
library(wordcloud2)
library(tidytext)
library(data.table)
library(plotly)

mergedata <- readRDS("./data/apodtwittermerge.RDS")
apoddata <- readRDS("./data/apod.RDS")

cloud_data <- apoddata %>% 
  unnest_tokens(output = word, input = 'Explanation', token = "words") %>% 
  anti_join(stop_words) %>% 
  count(word, sort = TRUE)



