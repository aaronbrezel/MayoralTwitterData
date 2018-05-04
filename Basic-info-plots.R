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


#### REAL NICE LOOKING PLOT

statusCount <- function(vector){
  if(vector == 0){
    return(0)
  }
  else{
    return(log(vector))
  }
}

statusCountVector <- sapply(mayor_Covariates$statusesCount, statusCount)
summary <- summary(lm(log(mayor_Covariates$followersCount)~statusCountVector)) #figures out the adj r squared value which is hard codded in the label input of the annotation method
ggplot(data = mayor_Covariates, mapping = aes(x = statusCountVector, y = log(followersCount), label= log(followersCount))) + geom_point(na.rm = TRUE) + geom_smooth(method = 'lm') + annotate("text", x = 9, y = 2, label = "Adj R^2 = 0.70")


summary$adj.r.squared

summary(mayor_Covariates)


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

summary2 <- summary(lm(log(mayor_Covariates$followersCount)~log(mayor_Covariates$totalPopulation)))
summary2
ggplot(data = mayor_Covariates, mapping = aes(x = log(totalPopulation), y = log(followersCount))) + geom_point(na.rm = TRUE, alpha = 1/5) + geom_smooth(method = "lm") + annotate("text", x = 14, y = 2.5, label = "Adj R^2 = 0.2387")

View(user$tweets)

  #Plotting log(population) against log(followers)
ggplot(data = mayor_Covariates, mapping = aes(x = log(totalPopulation), y = log(followersCount))) + geom_point(na.rm = TRUE) +
  labs(title = "Log(Population) v. Log(followers) for Mayoral Accounts")

  #Plotting mayor responsiveness within the past 7 days with regard to millenial, genx and baby boomer makeup of the city
library(dplyr)
library(DBI)
library(RSQLite)


db <- dbConnect(RSQLite::SQLite(), "mayoralTwitterData.db") #connect to database to get tweets info


tweets <- dbGetQuery(db, 'SELECT * FROM tweetData LIMIT 604818;') #grab all tweets
mentions <- dbGetQuery(db, 'SELECT * FROM mentionData LIMIT 61570;') #grab all mentions
load("mayor_Covariates.rds") #grab mayors and their covariate data
#load("tweets.rds")   file has been saved for pre-loading
#load("mentions.rds")  file has been save for pre-loading

colnames(mayor_Covariates)[11] <- "screenName" #makes join easier

tweets_joined <- tweets %>% #join replies from a mayor to their mention in the mentions data
  left_join(mentions, by = c("replyToSID", "id")) 

mayoral_replies <- tweets_joined %>% #take out all nas for non-replies
  filter(!is.na(text.y)) %>%
  group_by(screenName.x) %>%
  summarise(replies = n())#find out how many replies each mayor has


colnames(mayoral_replies)[1] <- "screenName" #makes join easier

mayor_covariates_replies <- mayor_Covariates %>% 
  left_join(mayoral_replies, by = "screenName")  #join the summary data to each mayor
  
mayor_cov_replies <- mayor_covariates_replies %>%
  filter(!is.na(replies)) %>%
  mutate(millenial = X10to14 + X15to17 + X18to24 + X25to34) %>% #create a variable for percent millenial (pew defines millenials as under age 37)
  mutate(oldpeople = X35to44 + X45to54 + X55to64 + X65to74 + X75to84 + X85plus) #no offense to those over the age of 34 :(

load("mayor_cov_replies.rds")
save(mayor_cov_replies, file = "mayor_cov_replies.rds")

summaryMill<- summary(lm(log(mayor_cov_replies$replies)~log(mayor_cov_replies$millenial)))
summaryMill #grab r^2 value
summaryOld <- summary(lm(log(mayor_cov_replies$replies)~log(mayor_cov_replies$oldpeople)))
summaryOld #grab r^2 value
summaryStatus <- summary(lm(log(mayor_cov_replies$replies)~log(mayor_cov_replies$statusesCount)))
summaryStatus #grab r^2 value

#Millenial and Replies Plot
ggplot(mayor_cov_replies, aes(x = log(millenial), y = log(replies))) +
  geom_point(na.rm = TRUE, alpha = 1/5) +
  geom_smooth(method = "lm") +
  labs(x = "Logged Percent Millenial",
       y = "Logged Replies Count for the Account",
       title = "Log(Replies) v. Log(% Millenial) for Mayoral Accounts") +
  annotate("text", x = 4, y = 5.3, label = "Adj R^2 = 0.01895") 


#Boomers and Genx v Reply plot
ggplot(mayor_cov_replies, aes(x = oldpeople, y = log(replies))) +
  geom_point(na.rm = TRUE, alpha = 1/5) +
  geom_smooth(method = "lm") +
  annotate("text", x = 64, y = 5.2, label = "Adj R^2 = 0.006842") +
  labs(x = "Percent Non-Millenial",
       y = "Logged Replies Count for the Account",
       title = "Log(Replies) v. % Non-Millenial (Boomer + GenX) for Mayoral Accounts")


#Status and Replies  
ggplot(mayor_cov_replies, aes(x = log(statusesCount), y = log(replies))) +
  geom_point(na.rm = TRUE, alpha = 1/5) +
  geom_smooth(method = "lm") +
  annotate("text", x = 10, y = 0, label = "Adj R^2 = 0.4343") +
  labs(x = "Logged Statuses Count",
       y = "Logged Replies Count for the Account",
       title = "Log(Replies) v. Log(Statuses Count) for Mayoral Accounts")
       