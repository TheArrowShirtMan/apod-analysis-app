# TODO:
# 
# access 1 year of urls of apod pages (loop through)
#   ~save Explanation, date, and image for each
# access prior 1 year of apod tweets
#   ~save tweet text, likes, retweets and dates
# combine all Explanations into Corpus (use tm)
# create word cloud from corpus
# enable interactivity to show pictures associated with words in cloud based on likes/retweets
# (size pictures based on popularity of associated tweet?)


library(rvest)
library(iterators)
apikey <- c("jyfIazj3xBfqar7uYKV0GVSOF2rmLyGihb5N540e")
queryseq <- seq(as.Date("2017/6/30"), as.Date("2017/12/31"), by = "day")
querydates <- seq(as.Date("2017/6/30"), as.Date("2017/12/31"), by = "day")
chardates <- as.character(querydates)
# for loop to iterate on looper function
for (i in length(querydates)) {
  
}

# looper function
loopedget <- function(date, key) {
  GET("https://api.nasa.gov/planetary/apod?date=",chardates,"&api_key=",key)
} 

vesttest <- read_html("https://apod.nasa.gov/apod/astropix.html")
test2 <- read_html("https://apod.nasa.gov/apod/ap190102.html")

text <- vesttest %>% 
  html_text()

children <- vesttest %>% 
  html_children()
