consumerKey <- "lmDdwehy7ZnAUPh5AH6Y3fbAR"
consumerSecret<- "2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa"

library(twitteR)

setup_twitter_oauth(consumerKey, consumerSecret)


install.packages("RMySQL")
library(RMySQL)

testDataFrame <- twListToDF(searchTwitter("Donald Trump", n=5, lang = "en"))

register_mysql_backend("mayoraltwitterdata", "DESKTOP-QN8OL8G", "abrezey", "kickpuncher3000")


install.packages("RSQLite")
library(RSQLite)
register_sqlite_backend("C:/Program Files (x86)/sqlite/mayoralTwitterData.db")

install.packages("obdc")





aaron <- getUser('aaronbrezel')


mayoralData  <- read.csv("C:/Users/aaron/OneDrive/Documents/Applied Statistical Programming/MayoralTwitterData/Official Mayors List.csv", na.strings = c("N/A", NA))
head(mayoralData)
head(mayoralData$Twitter_handle)
mayorTwitterHandle <- mayoralData$Twitter_handle
lyda <- getUser(mayorTwitterHandle[which(mayorTwitterHandle == "LydaKrewson")])
class(lyda)

lyda$
lydaTweets <- userTimeline(lyda, n=50)

lydaTweets

which(mayorTwitterHandle == "LydaKrewson")

get_latest_tweet_id(lyda)

hello 

library(Rcpp)



         
options(scipen=999) #Removes scientific notation. to revert, set scipen back to 0    
     
