
#####Saving as a model, but there was a function that did this already
lyda <- getUser('lydaKrewson')
class(lyda$name)
getUserTable <- data.frame(name = character(0), screenName= character(0), id = numeric(0), 
                           description = character(0), statusesCount = numeric(0), followersCount = numeric(0), favoritesCount = numeric(0),
                           friendsCount = numeric(0), url = character(0), created = character(0), protected = logical(0), verified = logical(0),
                           location =character(0), listedCount = numeric(0), profileImageURL = character(0), lang = character(0), stringsAsFactors = FALSE)


assignToVector <- function(user){
  userVector <- as.vector(c(user$name, user$screenName, user$id, user$description, user$statusesCount, user$followersCount, user$favoritesCount, 
                            user$friendsCount, user$url, user$created, user$protected, user$verified, user$location, user$listedCount, user$profileImageUrl, user$lang))
  return(userVector)
}

lydaValues <- t(assignToVector(lyda))

lydaValues
getUserTable[1,] <- lydaValues

###Below function works
mayoralData  <- read.csv("~/GitHub/MayoralTwitterData/Official Mayors List.csv", na.strings = c("N/A", NA))
mayoralHandlesNull <- as.vector(mayoralData$Twitter_handle)
mayoralHandles <- mayoralHandlesNull[!is.na(mayoralHandlesNull)]

userTable <- function(userHandles){
 return(twListToDF(lookupUsers(userHandles)))
}

UT10 <- userTable(mayoralHandles[1:10])
