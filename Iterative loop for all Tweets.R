consumerKey <- "lmDdwehy7ZnAUPh5AH6Y3fbAR"
consumerSecret<- "2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa"

library(twitteR)

setup_twitter_oauth(consumerKey, consumerSecret)


install.packages("RMySQL")
library(RMySQL)


register_mysql_backend("mayoraltwitterdata", "DESKTOP-QN8OL8G", "mayorTwitter", "montgomery")

testUserList <- NULL
mayoralData$Twitter_handle[1:10]
for(i in 1:10){
  testUserList <- c(testUserList,getUser(mayoralData$Twitter_handle[i]))
}

tweets<- searchTwitter('Lyda Krewson', n = 10)

store_users_db(testUserList, table_name = "users") #testUserList must be a list of objects of class user
store_tweets_db(tweets, table_name = "LydaTestTweets") #tweets must be a list of objects of class status

register_sqlite_backend("")