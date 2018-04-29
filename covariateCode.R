setwd("C:/Users/Alex Petri/Downloads/GithubASP/MayoralTwitterData")

rm(list=ls())

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


for (i in seq_along(cityData$FIPS)){ #split up clunky names for the census data
  cityData$principalCity[i] <-  strsplit(as.character(cityData$areaName)[i], split = ",", fixed = TRUE)[[1]][1] #split at the comma to get rid of spelled out state
  cityData$principalCity[i] <- toupper(paste(cityData$principalCity[i], cityData$state[i], sep = ", ")) #paste to upper with state abbrev
}



mayoralData$principalCity <- toupper(paste(mayoralData$City, mayoralData$StateAB, sep = " CITY, ")) #everything to upper since no FIPS to match on

library(dplyr)
cityData$principalCity <- unlist(cityData$principalCity) #unlist due to inability to join factor and character
prof_City <- left_join(mayoralData, cityData, by = "principalCity") #join it


profiles$capScreen <- toupper(profiles$screenName) #screenName to upper since there are discrepancies
prof_City <- prof_City[!(prof_City$screenName== ""),] #get rid of all those blank observations
prof_City <- prof_City[!is.na(prof_City$screenName),] #get rid of all the NA observations
prof_City$capScreen <- toupper(prof_City$screenName) #get all prof_city to upper because discrepancies in capitalization
table(is.na(prof_City$gini)) #see how many NAs in general

filtered <- filter(prof_City, is.na(prof_City$gini)) #filter to investigate


profiles_Mayor <- left_join(profiles, prof_City, by = "capScreen") #new join with capitalized screenNames
table(is.na(profiles_Mayor$gini)) #table to looks at
mayor_Covariates <- filter(profiles_Mayor, !is.na(profiles_Mayor$gini)) #all ready mayor covariates

#still need to rename a bunch of the columns because they are yucky
save(profiles, file = "profiles_unjoined.rds") #save unjoined profiles from beginning since it takes like 2 minutes to run
save(mayor_Covariates, file = "mayor_Covariates.rds") #save current results

load("mayor_Covariates.rds")






#graphs
library(dplyr)
ages <- mayor_Covariates %>%
  mutate(millenial = X10to14 + X15to17 + X18to24 + X25to34) #%>% #pew research has the cutoff age at 37
  #mutate(boomer = X35to44 + X45to54 + X)


ggplot(ages, aes(x = millenial, y = log(friendsCount))) +
  geom_point()
hist(log(ages$friends))

