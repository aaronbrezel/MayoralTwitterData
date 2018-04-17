library(twitteR)
library(data.table)
setup_twitter_oauth("lmDdwehy7ZnAUPh5AH6Y3fbAR","2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa")

statusCollector <- function(handle){
  return(twListToDF(userTimeline(handle, n=3200, includeRts = TRUE, excludeReplies = FALSE)))
}

twitterStatusDF <- function(handles){
 twitDF <- as.data.frame(sapply(handles, statusCollector))
 return(rbindlist(twitDF))
}

mayoralData  <- read.csv("~/GitHub/MayoralTwitterData/Official Mayors List.csv", na.strings = c("N/A", NA))
mayoralHandlesNull <- as.vector(mayoralData$Twitter_handle)
mayoralHandles <- mayoralHandlesNull[!is.na(mayoralHandlesNull)]


TS10 <- twitterStatusDF(mayoralHandles[1:10])


