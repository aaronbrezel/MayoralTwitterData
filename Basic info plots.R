## Designed for inserstion into the R Markdown file

rm(list=ls())

##Loading needed packages and datasets

library(twitteR)
library(ggplot2)
load("mayor_Covariates.rds")
load("profiles_unjoined.rds")

## BELOW IS CODE WHICH WAS USED TO GENERATE DATA, NO NEED TO RUN, TAKES A VERY LONG TIME TO EXECUTE

## mayoralData  <- read.csv("Official Mayors List.csv", na.strings = c("N/A", NA))
## mayoralData <- mayoralData[!is.na(mayoralData$Twitter_handle),]
## cityData <- read.csv("placeData.csv")
## colnames(mayoralData)[9] <- "screenName"
## mayoralHandles <- mayoralData$screenName
## userTable <- function(userHandles) { #userTable function to grab mayor twitter profile info
##   out <- tryCatch(
##     {
##      user <- lookupUsers(userHandles)
##      user <- twListToDF(user)
##      user$followRequestSent <- NULL
      ##       return(user)
      ##     },
    ##     error=function(cond) {
      ##       return(data.frame())
##     })
## }
## profiles <- sapply(mayoralHandles, userTable)
## profiles <- rbindlist(profiles) #rbind for a df

ggplot(data=mayor_Covariates)+geom_bar(mapping = aes(x = verified)) +labs(title = "Verificatation of Mayoral Twitter Accounts") ## Plot of how many accounts are verified vs. unverified

table(profiles$verified) ## Gives quantities of the two factors

ggplot(data=profiles)+geom_bar(mapping = aes(x = lang)) ## Mayors default language settings



order(profiles$lang) ## Identifying the non-english default accounts
profiles[343]
profiles[474]


##Followercount plots

  #Logged followerscount to make it easy to look at all the data on one graph, also made it fall into a nice nomal-ish distribution
ggplot(data = mayor_Covariates) +
  geom_histogram(mapping = aes(x = log(followersCount)), binwidth = 1) +
  labs(title = "Follower Distribution for Mayoral Twitter Accounts")


## Looking at # of followers, # of statuses, and population

  # Plotting log(statuses) against log(followers)
ggplot(data = mayor_Covariates, mapping = aes(x = log(statusesCount), y = log(followersCount))) + geom_point(na.rm = TRUE) +
  labs(title = "Log(Statuses) v. Log(followers) for Mayoral Accounts")

  #Plotting log(population) against log(followers)
ggplot(data = mayor_Covariates, mapping = aes(x = log(totalPopulation), y = log(followersCount))) + geom_point(na.rm = TRUE) +
  labs(title = "Log(Population) v. Log(followers) for Mayoral Accounts")

       