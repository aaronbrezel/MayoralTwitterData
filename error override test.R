library(data.table)
library("twitteR")
setup_twitter_oauth("lmDdwehy7ZnAUPh5AH6Y3fbAR","2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa") #must set up oauth to access twitter API


rm(list=ls())

mayoralData  <- read.csv("~/GitHub/MayoralTwitterData/Official Mayors List.csv", na.strings = c("N/A", NA)) #load in mayor csv
mayoralHandlesNull <- as.vector(mayoralData$Twitter_handle) #vectorize handles
mayoralHandles <- mayoralHandlesNull[!is.na(mayoralHandlesNull)] #get rid of na observations


userTable <- function(userHandles) { #this function collects the twitter user info - takes input userhandles - a list of twitter handles
  out <- tryCatch( #trycatch function because some handles, when collected, were improperly written. We receive an error. Trycatch allows us to bypass the error
    {
      user <- lookupUsers(userHandles) #lookupUsers- a twitteR function to lookup a list of handles
      user <- twListToDF(user) #twListToDF - converts twitteR object to data frame
      user$followRequestSent <- NULL #NULL because useless column
      return(user)
    },
    error=function(cond) {
      return(data.frame()) #returns empty data frame if there is an error
    })
}



statusCollector <- function(handle){ #function to collect all tweets from a mayor
  out <- tryCatch({ #once again, tryCatch in case of an error
    UT <- userTimeline(handle, n=3200, includeRts = TRUE, excludeReplies = FALSE) #user timeline returns the mayors tweets - 3200 max
    UT <- twListToDF(UT) #convert to a data frame
    return(UT)
  },
  error = function(cond){
    return(data.frame()) #empty data frame if there is an error
  })
}



statusCollectorST <- function(handle){ #function to collect tweets at a mayor
  status <- searchTwitter(handle, n=1000) #searchTwitter takes a handle and returns tweets for the past 7 days. N= the number of tweets we want to return.
  if (length(status) == 0){ #no tryCatch here because no errors, but this if statement returns an empty data frame rather than NULL if the string doesn't exist
    return(data.frame())
  } else if (length(status) > 0) { #if the status length is greater than 0
    status <- twListToDF(status) #return the status
    status$mayoralHandle <- handle #add the handle of the mayor that it was tweeted to
  }
  return(status)
}



### FORMAL FUNCTION HERE

createProfile <- function(handle){ #this is our first function that computes a list object for each user's info, tweets to, tweets from
  user <- list()
  user$userInfo <- userTable(handle)
  user$tweets <- statusCollector(handle)
  user$mentions <- statusCollectorST(handle)
  return(user)
}



##=======
setwd("C:/Users/aaron/OneDrive/Documents/Applied Statistical Programming/mayoralTwitter/Mayoral profiles")

createProfile2 <- sapply(mayoralHandles, function(x){ #function to save each user from createProfile as an .rds file
  user <- createProfile(x)
  save(object = user, file = paste(x, ".rds", sep = "")) #save the file to keep environment not over-crowded
} )









#if you are encountering problems and the tweet data is not returning 
#sometimes the twitter API goofs and doesn't give you all of your handles in the function
#here, i write some code that returns all of the mayors that you didn't get

setwd("C:/Users/aaron/OneDrive/Documents/Applied Statistical Programming/mayoralTwitterData")
data <- readRDS("tweets.rds") #tweets is the file that has all of the tweets from all returned mayors
names_with_data <- unique(data$screenName)
load('profiles_unjoined.rds') #profiles contains all of the mayors user data


'%ni%' = Negate('%in%') #negates %in% to do the opposite


names_wo_data = character()
for(i in seq_along(profiles$screenName)){ #for loop to collect all of the un-returned names
  if(profiles$screenName[i] %ni% names_with_data){
    names_wo_data[i] <- profiles$screenName[i]
  }
}

names_wo_data <- names_wo_data[!is.na(names_wo_data)] #drop the nas
names_wo_data



##>>>>>>> e12a970dfb4b34bf767d29f2f12b16fbf2d36ce9

