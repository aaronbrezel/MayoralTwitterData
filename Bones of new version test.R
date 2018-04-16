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
getwd()
load("~/Applied Statistical Programming/MayoralTwitterData/createProfile10.Rda")

str(createProfile10[[1]])
