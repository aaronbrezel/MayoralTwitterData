library(twitteR)
setup_twitter_oauth("lmDdwehy7ZnAUPh5AH6Y3fbAR","2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa")


twitterStatusDF <- function(handle){
list1 <<- twListToDF(userTimeline('handle', n=3200, includeRts = TRUE, excludeReplies = FALSE))
  }