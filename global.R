library(shiny)
library(shinydashboard)
library(ggplot2)
library(leaflet)
library(tidyverse)
library(tm)
library(httr)

querydates <- seq(as.Date("2017/6/30"), as.Date("2017/12/31"), by = "day")

v <- GET("https://api.nasa.gov/planetary/apod?api_key=jyfIazj3xBfqar7uYKV0GVSOF2rmLyGihb5N540e")
w <- curl(url = "https://api.nasa.gov/planetary/apod?api_key=jyfIazj3xBfqar7uYKV0GVSOF2rmLyGihb5N540e")
s <- GET("https://api.nasa.gov/planetary/apod?date=2012-12-19&api_key=jyfIazj3xBfqar7uYKV0GVSOF2rmLyGihb5N540e")

for (i in querydates[1:20]) {
  print(querydates[i])
}
  
