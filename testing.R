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
gets_df <- readRDS("nasadata.RDS")

queryseq <- seq(as.Date("2017/1/1"), as.Date("2017/12/31"), by = "day")
# for loop to iterate on looper function
dummydates <- seq(as.Date("2017/6/30"), as.Date("2017/7/03"), by = "day")

gets_df <- data.frame(Date=as.Date(character()),
                 Explanation=character(),
                 Title=character(),
                 nasaurl=character(),
                 Retweets=character(),
                 Likes=character(),
                 stringsAsFactors=FALSE)
# names(gets_df) <- c()
for (i in 1: length(queryseq)) {
  print(i)
  print(queryseq[i])
  apod <- paste0("https://api.nasa.gov/planetary/apod?date=", queryseq[i],apodapikey)
  iterget <- GET(apod)
  Sys.sleep(0.5)
  decode <- fromJSON(as.character(iterget), simplifyDataFrame = TRUE)
  gets_df[i,'Date'] <- c(decode$date)
  gets_df[i,'Explanation'] <- c(decode$explanation)
  gets_df[i,'Title'] <- c(decode$title)
  gets_df[i,'nasaurl'] <- c(decode$url)
}

# Get info about the APOD twitter account
apodtwitter <- lookup_users("apod")

#Get apod timeline info (2000 tweets)
apodtimeline2 <- get_timeline(user = 8295072, n = 2000)
twitterdata <- saveRDS(apodtimeline2, file = "apodtimeline.RDS")
apoddata <- saveRDS(gets_df, file = "nasadata.RDS")

gets_df['Explanation', 2]

getsrawtext <- paste(gets_df$Explanation, collapse = "")
apodtext <- DataframeSource(gets_df$Explanation)
mergetest <- merge(apodtimeline, gets_df, by.x = apodtimeline$created_at, by.y = gets_df$Date)
