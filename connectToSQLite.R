#install.packages("RSQLite")
#install.packages("sqldf")
#install.packages("XLConnect")
library("RSQLite")
library(DBI)

setwd("C:/Users/aaron/OneDrive/Documents/Applied Statistical Programming/MayoralTwitterData")
db <- dbConnect(RSQLite::SQLite(), "mayoralTwitterData.db")

#quick creates tables. Not Ideal. Will not auto add keys. Keys would have to be added with sql commands in the foreign key test code sql file. Instead will be moving
#forward with the dbSendQuery commands that creates the blank tables

dbWriteTable(db, "handleData", UT10)
dbWriteTable(db, "tweetData", as.data.frame(TS10))
dbWriteTable(db, "mentionData", user$mentions)
dbListTables(db)


#REAL. This is what creates our three blank tables with all the data put together
dbSendQuery(conn = db, 
            "CREATE TABLE IF NOT EXISTS `mayorUserData` (
            `description` TEXT, 
            `statusesCount` REAL, 
            `followersCount` REAL, 
            `favoritesCount` REAL, 
            `friendsCount` REAL, 
            `url` TEXT, 
            `name` TEXT, 
            `created` TEXT, 
            `protected` INTEGER, 
            `verified` INTEGER, 
            `screenName` TEXT, 
            `location` TEXT, 
            `lang` TEXT, 
            `id` TEXT, 
            `listedCount` REAL, 
            `profileImageUrl` TEXT, 
            PRIMARY KEY(`screenName`));" 
            )

dbSendQuery(conn = db,
            "CREATE TABLE IF NOT EXISTS`tweetData` (
            `text` TEXT, 
            `favorited` INTEGER, 
            `favoriteCount` REAL, 
            `replyToSN` TEXT, 
            `created` TEXT, 
            `truncated` INTEGER, 
            `replyToSID` TEXT, 
            `id` TEXT, 
            `replyToUID` TEXT, 
            `statusSource` TEXT, 
            `screenName` TEXT, 
            `retweetCount` REAL, 
            `isRetweet` INTEGER, 
            `retweeted` INTEGER, 
            `longitude` TEXT, 
            `latitude` TEXT, 
            foreign key (screenName) references mayorUserData (screenName));"
            )


dbSendQuery(conn= db, 
            "CREATE TABLE IF NOT EXISTS 'mentionData' ( 
            `text` TEXT, `favorited` INTEGER, 
            `favoriteCount` REAL, 
            `replyToSN` TEXT, 
            `created` TEXT, 
            `truncated` INTEGER, 
            `replyToSID` TEXT, 
            `id` TEXT, 
            `replyToUID` TEXT, 
            `statusSource` TEXT, 
            `screenName` TEXT, 
            `retweetCount` REAL, 
            `isRetweet` INTEGER, 
            `retweeted` INTEGER, 
            `longitude` INTEGER, 
            `latitude` INTEGER, 
            `mayoralHandle` TEXT, 
            foreign key (mayoralHandle) references mayorUserData (screenName));"
            )
            



##Below is an attempt to create a function that will process the information contained in our individual rds files
##Before running he function, load the .rds file that you want to process. This should create a list of lists in your environment
##You can pass that list into the function to input the data into the mayor Twitter DB

db <- dbConnect(RSQLite::SQLite(), "mayoralTwitterData.db")
setwd("C:/Users/aaron/OneDrive/Documents/Applied Statistical Programming/MayoralTwitterData/Mayoral profiles")

#As of right now, you still need to load each individual mayor's proflie before you can send the data to SQL. Still working on a way to automate it
load("tabbowling.rds")
#the object user contains userInfo, tweets and mentions. Those correspond to the mayorUserData, tweetData and mentionData tables in the SQLite database


insertToDB <- function(mayorProfile){
  
  #Insert userInfo into mayorUserData
  mayorProfile$userInfo$created <- as.character(user$userInfo$created) #Changes datatype of the created column from POSIXct to character. SQLite handles this type better
  insertMayorUserData <- dbSendQuery(db, 
    "INSERT OR IGNORE INTO mayorUserData 
       VALUES (
         :description,
         :statusesCount, 
         :followersCount,
         :favoritesCount,
         :friendsCount,
         :url,
         :name,
         :created,
         :protected,
         :verified,
         :screenName,
         :location,
         :lang,
         :id,
         :listedCount,
         :profileImageUrl);"
  )
  dbBind(insertMayorUserData, params = mayorProfile$userInfo)
  dbClearResult(insertMayorUserData)  
  
  #insert tweets to tweetData
  mayorProfile$tweets$created <- as.character(mayorProfile$tweets$created) #same thing with created
  insertTweetData <- dbSendQuery(db, 
                                     "INSERT OR IGNORE INTO tweetData 
                                     VALUES (
                                     :text,
                                     :favorited, 
                                     :favoriteCount,
                                     :replyToSN,
                                     :created,
                                     :truncated,
                                     :replyToSID,
                                     :id,
                                     :replyToUID,
                                     :statusSource,
                                     :screenName,
                                     :retweetCount,
                                     :isRetweet,
                                     :retweeted,
                                     :longitude,
                                     :latitude);"
  )
  dbBind(insertTweetData, params = mayorProfile$tweets)
  dbClearResult(insertTweetData) 
  
  #insert mentions to mentionData
  mayorProfile$tweets$created <- as.character(mayorProfile$tweets$created)
  insertTweetData <- dbSendQuery(db, 
                                 "INSERT OR IGNORE INTO tweetData 
                                 VALUES (
                                 :text,
                                 :favorited, 
                                 :favoriteCount,
                                 :replyToSN,
                                 :created,
                                 :truncated,
                                 :replyToSID,
                                 :id,
                                 :replyToUID,
                                 :statusSource,
                                 :screenName,
                                 :retweetCount,
                                 :isRetweet,
                                 :retweeted,
                                 :longitude,
                                 :latitude);"
  )
  dbBind(insertTweetData, params = mayorProfile$tweets)
  dbClearResult(insertTweetData) 
  
  
  
  class(user$userInfo$created)
  
  
} 