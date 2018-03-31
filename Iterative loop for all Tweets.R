consumerKey <- "lmDdwehy7ZnAUPh5AH6Y3fbAR"
consumerSecret<- "2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa"

library(twitteR)

setup_twitter_oauth(consumerKey, consumerSecret)



searchTwitter("Donald Trump", n=5, lang = "en")

aaron <- getUser('aaronbrezel')


mayoralData  <- read.csv("C:/Users/aaron/OneDrive/Documents/Applied Statistical Programming/MayoralTwitterData/Official Mayors List.csv", na.strings = c("N/A", NA))
head(mayoralData)
head(mayoralData$Twitter_handle)
mayorTwitterHandle <- mayoralData$Twitter_handle
lyda <- getUser(mayorTwitterHandle[which(mayorTwitterHandle == "LydaKrewson")])
lyda

lydaTweets <- userTimeline(lyda, n=50)

lydaTweets

which(mayorTwitterHandle == "LydaKrewson")

get_latest_tweet_id(lyda)

hello 

library(Rcpp)



lydaTweets <- twitterStatusDF(lyda)
         
         
         twListToDF(userTimeline(as.character(lydaKrewson), n = 1))
         
         tweetDF
getTweetData <- function(handle){
  tweetDF <- NULL
  maxId <- "100000000000000000000000000000000000"
  lastTweetID <- NULL
  while(exitClause){
         tweetDF <- rbind(tweetDF,twListToDF(userTimeline(handle, n = 3200, includeRts = TRUE, excludeReplies = FALSE, maxID = maxId))) #rbind combines dataframes
         
         maxId <- tweetDF$id[nrow(tweetDF)] #this is done so we now set the max id search to the very last tweet the current iteration was able to pick up
         
         
         if(tweetDF$created[nrow(tweetDF)] < "2012-01-01 00:00:00 UTC"){ #tests to see whether the last entry (tweet) in the dataframe was made before Jan. 1, 2012. If that is the case, then we end the loop
         break
         }
         print(head(tweetDF))
         lastTweetID <- tweetDF$id[nrow(tweetDF)]
  }
  tweetDF <- tweetDF[!(duplicated(tweetDF$id)),]
  return(tweetDF)
  }
         
         
         getTweetData(lyda)
         
         for(i in )
         
         tweetDF <- twListToDF(userTimeLine(handle, n = 3200, includeRts = TRUE, excludeReplies = FALSE))
         
         }
         
         while(exit){
         
         
         if()
         }
         options(scipen=999) #to revert, set scipen back to 0
lydaTweets$id[nrow(lydaTweets)]         
a<-(as.double(lydaTweets$id[nrow(lydaTweets)]))
?as.numeric

a*10



userTimeLine(handle, n = 3200, includeRts = TRUE, excludeReplies = FALSE, Max))
         ?userTimeline
         as.numeric(lydaTweets$id[nrow(lydaTweets)])-1 == as.numeric(lydaTweets$id[nrow(lydaTweets)])
         nrow(lydaTweets)
         
         lydaTweets$created[nrow(lydaTweets)]
         userTimeline(lyda, n = 5, includeRts = TRUE, excludeReplies = FALSE, maxID = as.numeric(lydaTweets$id[nrow(lydaTweets)]-1))
         
         
         lydaTweets$created[1] > "2012-01-01 00:00:00 UTC"
         lydaTweets$created[2]
         
         rbind(head(lydaTweets),lydaTweets[7,])
         
         lydaTweets[2,]
         ?userTimeline
         
temp <- dat[!(duplicated(dat$id)),]

