userTable <- function(userHandles){
  ut <- (twListToDF(lookupUsers(userHandles)))
  ut$followRequestSent <- NULL
  return(ut)
}

statusCollector <- function(handle){
  return(twListToDF(userTimeline(handle, n=3200, includeRts = TRUE, excludeReplies = FALSE)))
}

twitterStatusDF <- function(handles){
  twitDF <- as.data.frame(sapply(handles, statusCollector))
  return(rbindlist(twitDF))
}

statusCollectorST <- function(handle){
  return(twListToDF(searchTwitter(handle, n=1000)))
}

twitterSearchDF <- function(handles){
  twitDF <- as.data.frame(sapply(handles, statusCollectorST))
  return(twitDF)
}

lyda1 <- userTable('lydakrewson')

lyda2 <- twitterStatusDF('lydakrewson')

lyda3 <- statusCollectorST('lydakrewson')

lyda <- NULL
lyda$userInfo <- lyda1
lyda$tweets <- lyda2
lyda$mentions <- lyda3
