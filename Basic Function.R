twitterStatusDF <- function(handle){
 return(twListToDF(userTimeline(handle, n=3200, includeRts = TRUE, excludeReplies = FALSE)))
}

listSet <- sapply(c("realmaxhandler", "Klein_Barton"), twitterStatusDF)
