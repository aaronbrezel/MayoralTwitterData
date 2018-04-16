#install.packages("RSQLite")
library("RSQLite")
library(DBI)

setwd("C:/sqLite")
sqlite <- dbDriver("SQLite")
con <- dbConnect(sqlite, "mayoralTwitterData.db")


