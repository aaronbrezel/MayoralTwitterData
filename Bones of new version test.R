library(data.table)

rm(list=ls())

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
  status <- searchTwitter(handle, n=1000)
  if (length(status) == 0){
    return()
  } else if (length(status) > 0) {
    return(twListToDF(status))
  }
}


lyda1 <- userTable('lydakrewson')
lyda2 <- twitterStatusDF('lydakrewson')
lyda3 <- statusCollectorST('lydakrewson')

lyda <- NULL
lyda$userInfo <- lyda1
lyda$tweets <- lyda2
lyda$mentions <- lyda3

### FORMAL FUNCTION HERE

createProfile <- function(handle){
  user <- NULL
  user$userInfo <- userTable(handle)
  user$tweets <- twitterStatusDF(handle)
  user$mentions <- statusCollectorST(handle)
  return(user)
}

createProfile10 <- sapply(mayoralHandles[1:10], createProfile)

save(createProfile10, file = "createProfile10.Rda")

