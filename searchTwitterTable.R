
library(twitteR)
setup_twitter_oauth("lmDdwehy7ZnAUPh5AH6Y3fbAR","2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa")

statusCollectorST <- function(handle){
  return(twListToDF(searchTwitter(handle, n=1000)))
}

twitterSearchDF <- function(handles){
  twitDF <- as.data.frame(sapply(handles, statusCollectorST))
  return(twitDF)
}
mayoralData  <- read.csv("~/GitHub/MayoralTwitterData/Official Mayors List.csv", na.strings = c("N/A", NA))
mayoralHandlesNull <- as.vector(mayoralData$Twitter_handle)
mayoralHandles <- mayoralHandlesNull[!is.na(mayoralHandlesNull)]

#Nope
ST10 <- twitterSearchDF(mayoralHandles[1:10])

mayoralHandles[1:10]


twitterSearchDF('lydakrewson')
j <- statusCollectorST("lydakrewson")
jj <- as.data.frame(j)

##Doesn't work
twitterSearchDF(mayoralHandles[1:10])
k <- statusCollectorST(mayoralHandles[1:10])


searchtwitter5000 <- function(handle){
  return(searchTwitter(handle, n=5000))
}

## Doessn't return what we want
attempt <- sapply(mayoralHandles[1:10], searchtwitter5000)
count <- sapply(attempt, length)
a <- attempt[!count==0]
attemptDF2 <- sapply(a, twListToDF)
