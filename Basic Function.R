library(twitteR)
setup_twitter_oauth("lmDdwehy7ZnAUPh5AH6Y3fbAR","2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa")

statusCollector <- function(handle){
  return(twListToDF(userTimeline(handle, n=3200, includeRts = TRUE, excludeReplies = FALSE)))
}

twitterStatusDF <- function(handles){
 twitDF <- as.data.frame(sapply(handles, statusCollector))
 return(twitDF)
}
mayoralData  <- read.csv("Official Mayors List.csv", na.strings = c("N/A", NA))
mayoralHandlesNull <- as.vector(mayoralData$Twitter_handle)
mayoralHandles <- mayoralHandlesNull[!is.na(mayoralHandlesNull)]
attempt <- twitterStatusDF(c('MartyHandlon','MayorHam', 'WoodfinForBham'))
