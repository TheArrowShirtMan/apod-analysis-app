# TODO:
# 
# enable interactivity to show pictures associated with words in cloud based on likes/retweets
# (size pictures based on popularity of associated tweet?)
library(httr)
library(tm)
library(jsonlite)
library(rtweet)

gets_df <- readRDS("nasadata.RDS")

queryseq <- seq(as.Date("2017/1/1"), as.Date("2017/12/31"), by = "day")
# for loop to iterate on looper function
dummydates <- seq(as.Date("2017/6/30"), as.Date("2017/7/20"), by = "day")

gets_df <- data.frame(Date=as.Date(character()),
                 Explanation=character(),
                 Title=character(),
                 nasaurl=character(),
                 hdurl=character(),
                 Retweets=character(),
                 Likes=character(),
                 stringsAsFactors=FALSE)
# names(gets_df) <- c()
for (i in 1: length(queryseq)) {
  print(i)
  print(queryseq[i])
  apod <- paste0("https://api.nasa.gov/planetary/apod?date=", queryseq[i],apodapikey,"&hd=TRUE")
  iterget <- GET(apod)
  Sys.sleep(0.5)
  decode <- fromJSON(as.character(iterget), simplifyDataFrame = TRUE)
  gets_df[i,'Date'] <- c(decode$date)
  gets_df[i,'Explanation'] <- c(decode$explanation)
  gets_df[i,'Title'] <- c(decode$title)
  gets_df[i,'nasaurl'] <- c(decode$url)
  gets_df[i,'hdurl'] <- ifelse(decode$media_type == "video", decode$url, decode$hdurl)
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

twitterdata$created_at
class(gets_df$Date)
max(twitterdata$created_at)
head(gets_df$hdurl)
View(twitterdata[,c(13,14,17:27)])

drops <- c("reply_to_screen_name", "display_text_width", "reply_to_status_id",
           "reply_to_user_id", "reply_to_screen_name", "is_quote", "is_retweet",
           "hashtags", "symbols", "mentions_screen_name", "quoted_status_id",
           "quoted_text","quoted_created_at", "quoted_source", "quoted_user_id",
           "quoted_screen_name","quoted_name", "quoted_followers_count","quoted_friends_count",
           "quoted_statuses_count", "quoted_location","quoted_description", "quoted_verified",
           "retweet_status_id","retweet_text","retweet_created_at", "retweet_source","retweet_favorite_count",
           "retweet_retweet_count", "retweet_user_id","retweet_screen_name","retweet_name",
           "retweet_followers_count","retweet_friends_count","retweet_statuses_count", 
           "retweet_location","retweet_description","retweet_verified", "place_url","place_name",
           "place_full_name", "place_type","country","country_code", "geo_coords","coords_coords","bbox_coords",
           "followers_count","friends_count","listed_count", "statuses_count", "account_created_at",
           "verified", "profile_url", "account_lang","profile_banner_url","profile_background_url",
           "profile_image_url")
twitterdata <- twitterdata[ , !names(twitterdata) %in% drops]
twitterdata$Date <- as.Date(twitterdata$created_at)


mergetest <- merge(twitterfiltered, gets_df, by.x = twitterdata$status_date, by.y = gets_df$Date)
mergetest2 <- merge(data.frame(twitterfiltered, row.names=NULL), data.frame(apoddata, row.names=NULL), by = 0, all = TRUE)[-1]

View(head(twitterfiltered))

url <- a("Google Homepage", href="https://www.google.com/")
output$tab <- renderUI({
  tagList("URL link:", url)
  
  
sentiments <- cloud_data %>%
  filter(cloud_data$n > 5) %>% 
  inner_join(get_sentiments("bing")) %>% 
  #count(book, index = linenumber %/% 80, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)


sentiments <- sentiments[order(sentiments$sentiment, decreasing = TRUE), ]
sentiments$word <- factor(sentiments$word, levels = sentiments$word[order(sentiments$sentiment)])

  #facet_wrap(~book, ncol = 2, scales = "free_x")  
  
  
  
  
  
  
  
  
  
  
  
  
  
