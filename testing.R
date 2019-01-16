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

library(httr)
library(tm)
library(jsonlite)
library(rtweet)
library(rtweet)
apikey <- c("jyfIazj3xBfqar7uYKV0GVSOF2rmLyGihb5N540e")
queryseq <- seq(as.Date("2017/6/30"), as.Date("2017/12/31"), by = "day")
querydates <- seq(as.Date("2017/6/30"), as.Date("2017/12/31"), by = "day")
querydate <- paste0("date=",chardates[1])
chardates <- as.character(querydates)
# for loop to iterate on looper function
# apod <- modify_url("https://api.nasa.gov/planetary/apod", query = querydate, params = "test")
dummydates <- seq(as.Date("2017/6/30"), as.Date("2017/7/03"), by = "day")

gets_df <- data.frame(Date=as.Date(character()),
                 Explanation=character(), 
                 Retweets=character(),
                 Likes=character(),
                 stringsAsFactors=FALSE)
# names(gets_df) <- c()
for (i in seq_along(dummydates)) {
  apod <- paste0("https://api.nasa.gov/planetary/apod?date=", dummydates[i],"&api_key=jyfIazj3xBfqar7uYKV0GVSOF2rmLyGihb5N540e")
  iterget <- GET(apod)
  decode <- fromJSON(as.character(iterget), simplifyDataFrame = TRUE)
  gets_df[i,'Date'] <- c(decode$date)
  gets_df[i,'Explanation'] <- c(decode$explanation)
  #gets_df$date <- append(gets_df, decode$date)
}


#Create token
token <- create_token(
  app = "GreatestAPODs",
  consumer_key = "japcb18LtppGNSW2yWA24C894",
  consumer_secret = "JmOZOQFQ6jEhpzG4IHSd2Ddf8XBGMNVUxZnlJsWIoX9mAe7f9N",
  access_token = "9551451262-wK2EmA942kxZYIwa5LMKZoQA4Xc2uyIiEwu2YXL",
  access_secret = "9vpiSGKg1fIPQtxc5d5ESiFlZQpfbknEN1f1m2xe5byw7")

# Get info about the APOD twitter account
apodtwitter <- lookup_users("apod")

#Get apod timeline info (2000 tweets)
apodtimeline <- get_timeline(user = 8295072, n = 2000)

# looper function
loopedget <- function(date) {
  GET(apod)
} 

vesttest <- read_html("https://apod.nasa.gov/apod/astropix.html")
test2 <- read_html("https://apod.nasa.gov/apod/ap190102.html")

text <- vesttest %>% 
  html_text()

children <- vesttest %>% 
  html_children()
