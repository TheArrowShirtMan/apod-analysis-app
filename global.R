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
twitterdata <- readRDS("apodtimeline.RDS")
apoddata <- readRDS("nasadata.RDS")

text_by_date <- apoddata %>% 
  unnest_tokens(output = word, input = 'Explanation', token = "words")

text_by_date <- text_by_date %>% 
  anti_join(stop_words)

cloud_data <- text_by_date %>% 
  count(word, sort = TRUE) %>% 
  subset(cloud_data$n > 5)

