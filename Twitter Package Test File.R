#Consumer Key (API Key)	lmDdwehy7ZnAUPh5AH6Y3fbAR
#Consumer Secret (API Secret)	2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa

install.packages("twitteR")
install.packages("openssl")
install.packages("httpuv")
library(httpuv)
library(twitteR)

getTwitterOAuth("lmDdwehy7ZnAUPh5AH6Y3fbAR","2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa")
setup_twitter_oauth("lmDdwehy7ZnAUPh5AH6Y3fbAR","2A62GUU7eshn5lZ3rHZ0MsepkFgbwG4qegMya4AyoydEmFxKQa")
oauth_listener

searchTwitter("Donald Trump", n=5, lang = "en")

aaron <- getUser('aaronbrezel')
aaron$getDescription()
class(aaron)
aaron$created
aaron$friendsCount
aaron$getLocation()
aaron$getFavorites(n=5)
userTimeline(aaron)

donald <- getUser('realDonaldTrump')
userTimeline(donald)
?userTimeline
donald
realDonaldTrump

tweetsDeBlasio <- searchTwitter("NYCMayor", since = "2018-03-24", n = 1000)
head(tweetsDeBlasio)
