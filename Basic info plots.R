rm(list=ls())

load("mayor_Covariates.rds")
mayoralData  <- read.csv("Official Mayors List.csv", na.strings = c("N/A", NA))
mayoralData <- mayoralData[!is.na(mayoralData$Twitter_handle),]
cityData <- read.csv("placeData.csv")
colnames(mayoralData)[9] <- "screenName"
mayoralHandles <- mayoralData$screenName


userTable <- function(userHandles) { #userTable function to grab mayor twitter profile info
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
profiles <- sapply(mayoralHandles, userTable)
profiles <- rbindlist(profiles) #rbind for a df

ggplot(data=profiles)+geom_bar(mapping = aes(x = verified)) ## Plot of how many accounts are verified vs. unverified

ggplot(data=profiles)+geom_bar(mapping = aes(x = lang)) ## Mayors default language settings

##Followercount plots

  #Followers between 0 and 10000
ggplot(data = profiles) +
  geom_histogram(mapping = aes(x = followersCount), breaks = seq(0, 10000, by = 100))

  #More than 10000 followers
ggplot(data = profiles) +
  geom_histogram(mapping = aes(x = followersCount), breaks = seq(10000, 300000, by = 10000))
count(profiles$followersCount > 10000)

ggplot(data = profiles, mapping = aes(x = statusesCount, y = followersCount)) + geom_point(na.rm = TRUE)


ggplot(data = mayor_Covariates, mapping = aes(x = totalPopulation, y = followersCount)) + geom_point(na.rm = TRUE)

ggplot(data = mayor_Covariates, mapping = aes(x = totalPopulation, y = followersCount)) + geom_point(na.rm = TRUE, alpha = 1/5)
  