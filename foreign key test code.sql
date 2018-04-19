Alter Table tweetData rename to _tweetData_old;

CREATE TABLE `tweetData` ( `text` TEXT, `favorited` INTEGER, `favoriteCount` REAL, `replyToSN` TEXT, `created` REAL, 
`truncated` INTEGER, `replyToSID` TEXT, `id` TEXT, `replyToUID` TEXT, `statusSource` TEXT, `screenName` TEXT, `retweetCount` REAL, 
`isRetweet` INTEGER, `retweeted` INTEGER, `longitude` TEXT, `latitude` TEXT, foreign key (screenName) references handleData (screenName));

Insert into tweetData (text, favorited, favoriteCount, replyToSN, created, truncated, replyToSID, id, replyToUID, statusSource, screenName,
retweetCount, isRetweet, retweeted, longitude, latitude) select text, favorited, favoriteCount, replyToSN, created, truncated, replyToSID, id, replyToUID, statusSource, screenName,
retweetCount, isRetweet, retweeted, longitude, latitude from _tweetData_old;

Alter Table mentionData rename to _mentionData_old;

CREATE TABLE "mentionData" ( `text` TEXT, `favorited` INTEGER, `favoriteCount` REAL, `replyToSN` TEXT, `created` REAL, `truncated` 
INTEGER, `replyToSID` TEXT, `id` TEXT, `replyToUID` TEXT, `statusSource` TEXT, `screenName` TEXT, `retweetCount` REAL, `isRetweet` INTEGER, 
`retweeted` INTEGER, `longitude` INTEGER, `latitude` INTEGER, `mayoralHandle` TEXT, foreign key (mayoralHandle) references handleData (screenName));

