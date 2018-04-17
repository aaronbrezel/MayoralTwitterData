#install.packages("RSQLite")
#install.packages("sqldf")
#install.packages("XLConnect")
library("RSQLite")
library(DBI)

setwd("C:/Users/aaron/OneDrive/Documents/Applied Statistical Programming/MayoralTwitterData")
db <- dbConnect(RSQLite::SQLite(), "mayoralTwitterData.db")


dbWriteTable(db, "handleData", UT10)
dbWriteTable(db, "tweetData", as.data.frame(TS10))
dbListTables(db)
dbRemoveTable(db, "handleData")
?dbWriteTable
?dbGetQuery

UT10$key <- 1:length(UT10$description)
UT10
load("TS10.rda")

as.data.frame(TS10)
str(UT10)
