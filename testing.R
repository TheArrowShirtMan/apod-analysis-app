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

testlist <- list()
testseq <- seq(1,10)

for (i in 1:length(testseq)) {
  append(i, testlist)
}

library(httr)
library(rvest)
library(tm)
library(iterators)
library(jsonlite)
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
names(gets_df) <- c()
for (i in seq_along(dummydates)) {
  apod <- paste0("https://api.nasa.gov/planetary/apod?date=", dummydates[i],"&api_key=jyfIazj3xBfqar7uYKV0GVSOF2rmLyGihb5N540e")
  iterget <- GET(apod)
  decode <- fromJSON(as.character(iterget), simplifyDataFrame = TRUE)
  gets_df$Explanation <- na.omit(decode$explanation)
  #gets_df$date <- append(gets_df, decode$date)
}

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
