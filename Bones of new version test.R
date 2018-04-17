library(data.table)
library("twitteR")
setup_twitter_oauth("lmDdwehy7ZnAUPh5AH6Y3fbAR","2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa")


rm(list=ls())

mayoralData  <- read.csv("~/GitHub/MayoralTwitterData/Official Mayors List.csv", na.strings = c("N/A", NA))
mayoralHandlesNull <- as.vector(mayoralData$Twitter_handle)
mayoralHandles <- mayoralHandlesNull[!is.na(mayoralHandlesNull)]

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
    return(list())
  } else if (length(status) > 0) {
    status <- twListToDF(status)
    status$mayoralHandle <- handle
  }
  return(status)
}


### FORMAL FUNCTION HERE

createProfile <- function(handle){
  user <- NULL
  user$userInfo <- userTable(handle)
  user$tweets <- twitterStatusDF(handle)
  user$mentions <- statusCollectorST(handle)
  return(user)
}

##<<<<<<< HEAD
lyda <- createProfile("lydakrewson")
marty <- createProfile("MartyHandlon")

##=======
setwd("~/GitHub/MayoralTwitterData/Mayoral profiles")
createProfile2 <- sapply(mayoralHandles[1:2], function(x){
  user <- createProfile(x)
  saveRDS(object = user, file = paste(x,".rds"))
} )

load("UT10.rda")

save(createProfile10, file = "createProfile10.Rda")
getwd()
load("~/Applied Statistical Programming/MayoralTwitterData/createProfile10.Rda")

str(createProfile10[[1]])
##>>>>>>> e12a970dfb4b34bf767d29f2f12b16fbf2d36ce9
