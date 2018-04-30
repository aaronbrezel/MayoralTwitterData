library(data.table)
library("twitteR")
setup_twitter_oauth("lmDdwehy7ZnAUPh5AH6Y3fbAR","2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa")


rm(list=ls())

mayoralData  <- read.csv("~/GitHub/MayoralTwitterData/Official Mayors List.csv", na.strings = c("N/A", NA))
mayoralHandlesNull <- as.vector(mayoralData$Twitter_handle)
mayoralHandles <- mayoralHandlesNull[!is.na(mayoralHandlesNull)]


userTable <- function(userHandles) {
  out <- tryCatch(
    {
      user <- lookupUsers(userHandles)
      user <- twListToDF(user)
      user$followRequestSent <- NULL
      return(user)
    },
    error=function(cond) {
      return(data.frame())
    })
}



statusCollector <- function(handle){
  out <- tryCatch({
    UT <- userTimeline(handle, n=3200, includeRts = TRUE, excludeReplies = FALSE)
    UT <- twListToDF(UT)
    return(UT)
  },
  error = function(cond){
    return(data.frame())
  })
}



#twitterStatusDF <- function(handles){
 # if(is.na(statusCollector(handles))){
  #  return(NA)
  #} else{
#  twitDF <- as.data.frame(sapply(handles, statusCollector))
 # return(rbindlist(twitDF))
  #}
#}



statusCollectorST <- function(handle){
  status <- searchTwitter(handle, n=1000)
  if (length(status) == 0){
    return(data.frame())
  } else if (length(status) > 0) {
    status <- twListToDF(status)
    status$mayoralHandle <- handle
  }
  return(status)
}



### FORMAL FUNCTION HERE

createProfile <- function(handle){
  user <- list()
  user$userInfo <- userTable(handle)
  user$tweets <- statusCollector(handle)
  user$mentions <- statusCollectorST(handle)
  return(user)
}



##=======
setwd("C:/Users/aaron/OneDrive/Documents/Applied Statistical Programming/mayoralTwitter/Mayoral profiles")

createProfile2 <- sapply(names_wo_data, function(x){
  user <- createProfile(x)
  save(object = user, file = paste(x, ".rds", sep = ""))
} )

MH <- load("MartyHandlon.rds")
load("tabbowling.rds")
MH <- readRDS("MartyHandlon.rds")
tabbowling <- readRDS("~/GitHub/MayoralTwitterData/Mayoral profiles/tabbowling.rds")

save(createProfile10, file = "createProfile10.Rda")
getwd()
load("~/Applied Statistical Programming/MayoralTwitterData/createProfile10.Rda")

str(createProfile10[[1]])
##>>>>>>> e12a970dfb4b34bf767d29f2f12b16fbf2d36ce9

mayoralHandles



setwd("C:/Users/aaron/OneDrive/Documents/Applied Statistical Programming/mayoralTwitterData")
data <- readRDS("tweets.rds")
names_with_data <- unique(data$screenName)
load('profiles_unjoined.rds')


'%ni%' = Negate('%in%') 


names_wo_data = character()
for(i in seq_along(profiles$screenName)){
  if(profiles$screenName[i] %ni% names_with_data){
    names_wo_data[i] <- profiles$screenName[i]
  }
}

names_wo_data <- names_wo_data[!is.na(names_wo_data)]
names_wo_data





