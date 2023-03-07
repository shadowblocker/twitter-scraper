# Scraping metadata from tweets and accounts using SNSCRAPE.

A series of python scripts which scrape publicly available metadata from twitter and output to an elasticsearch instance.

These scripts require a working SNSCRAPE installation which is available here: https://github.com/JustAnotherArchivist/snscrape and an ElasticSearch instance accessible from the system running the scripts. Visualization and basic analysis of the scraper results can be done natively in elasticsearch or with Kibana.

## USER.PY - Usernames

invoked from shell (requires 3 arguments): python3 user.py USERNAME ELASTICTAG COUNT

* e.g. python3 user.py bbcnews broadcasters 50000

This would scrape metadata from up to 50,000 of the most recent tweets sent by the account @BBCNews and add the elasticseach tag "broadcasters" to all results.

### The Usernames scraper provides metadata for:

* "essid": elasticsearch custom tag                
* "conversation_id": twitter internal tweet id
* "created_at": date and time of tweet
* "link": url of the tweet
* "name": friendly account name
* "nlikes": number of likes for a tweet
* "nreplies": number of replies to a tweet
* "nretweets": number of retweets of a tweet
* "user_id_str": unique user id string
* "username": twitter account username
* "bio": twitter account biographical text
* "tweet": the raw content of the tweet
* "hashtags": hashtags from the collected tweet
* "cashtags": cashtags from the collected tweet
* "place": the user's self declared location info from bio
* "verified": verification state of the account
* "subscribed": subscription (twitter blue) state of the account              
* "age": creation date of twitter account
* "nfollowers": number of followers
* "nfollowing": number of following
* "ntweets": number of tweets
* "photourl": profile photo image URL
* "bannerurl": profile banner image URL
* "protected": is account protected

## USERID.PY - UserIDs

invoked from shell (requires 3 arguments): python3 userid.py USERID ELASTICTAG COUNT

* e.g. python3 userid.py 252521025 global-influencers 750

This would scrape metadata from up to 750 of the most recent tweets sent by the user_id 252521025 (@Number10cat) and add the elasticseach tag "global-influencers" to all results.

### The UserID scraper provides metadata for:

* "essid": elasticsearch custom tag                
* "conversation_id": twitter internal tweet id
* "created_at": date and time of tweet
* "link": url of the tweet
* "name": friendly account name
* "nlikes": number of likes for a tweet
* "nreplies": number of replies to a tweet
* "nretweets": number of retweets of a tweet
* "user_id_str": unique user id string
* "username": twitter account username
* "bio": twitter account biographical text
* "tweet": the raw content of the tweet
* "hashtags": hashtags from the collected tweet
* "cashtags": cashtags from the collected tweet
* "place": the user's self declared location info from bio
* "verified": verification state of the account
* "subscribed": subscription (twitter blue) state of the account              
* "age": creation date of twitter account
* "nfollowers": number of followers
* "nfollowing": number of following
* "ntweets": number of tweets
* "photourl": profile photo image URL
* "bannerurl": profile banner image URL
* "protected": is account protected

## FASTUSER.PY - FastUser

invoked from shell (requires 2 arguments): python3 fastuser.py USERNAME ELASTICTAG

* e.g. python3 fastuser.py fesshole comedy

This would scrape limited bio metadata from up to 5 of the most recent tweets sent by the account @Fesshole and add the elasticseach tag "comedy" to all results. Designed to execute rapidly for fast user-bio collection tasks where tweet metadata is less useful than user metadata.

### The Fastuser scraper provides metadata for:

* essid: elasticsearch custom tag
* name: friendly account name
* user_id_str: unique user id string
* username: twitter account username
* bio: twitter account biographical text
* place: the user's self declared location info from bio
* verified: verification state of the account
* subscribed: subscription (twitter blue) state of the account              
* age: creation date of twitter account
* nfollowers: number of followers
* nfollowing: number of following
* ntweets: number of tweets
* protected: is account protected

## HASHTAG.PY - Hashtags

invoked from shell (requires 3 arguments): python3 hashtag.py HASHTAG ELASTICTAG COUNT

* e.g. python3 hashtag.py blackfriday blackfriday 150000

This would scrape basic metadata from up to 150,000 tweets containing the hashtag #BlackFriday and add the elasticseach tag "blackfriday" to all results.

### The Hashtag scraper provides metadata for:

* "essid": elasticsearch custom tag                
* "conversation_id": twitter internal tweet id
* "created_at": date and time of tweet
* "link": url of the tweet
* "name": friendly account name
* "nlikes": number of likes for a tweet
* "nreplies": number of replies to a tweet
* "nretweets": number of retweets of a tweet
* "user_id_str": unique user id string
* "username": twitter account username
* "bio": twitter account biographical text
* "tweet": the raw content of the tweet
* "hashtags": hashtags from the collected tweet
* "cashtags": cashtags from the collected tweet
* "place": the user's self declared location info from bio
* "verified": verification state of the account
* "subscribed": subscription (twitter blue) state of the account              
* "age": creation date of twitter account
* "nfollowers": number of followers
* "nfollowing": number of following
* "ntweets": number of tweets
* "protected": is account protected

## CASHTAG.PY - Cashtags

invoked from shell (requires 3 arguments): python3 cashtag.py CASHTAG ELASTICTAG COUNT

* e.g. python3 cashtag.py tsla stocks 1000

This would scrape basic metadata from up to 1000 tweets containing the cashtag $TSLA and add the elasticseach tag "stocks" to all results.

### The Cashtag scraper provides metadata for:

* "essid": elasticsearch custom tag                
* "conversation_id": twitter internal tweet id
* "created_at": date and time of tweet
* "link": url of the tweet
* "name": friendly account name
* "nlikes": number of likes for a tweet
* "nreplies": number of replies to a tweet
* "nretweets": number of retweets of a tweet
* "user_id_str": unique user id string
* "username": twitter account username
* "bio": twitter account biographical text
* "tweet": the raw content of the tweet
* "hashtags": hashtags from the collected tweet
* "cashtags": cashtags from the collected tweet
* "place": the user's self declared location info from bio
* "verified": verification state of the account
* "subscribed": subscription (twitter blue) state of the account              
* "age": creation date of twitter account
* "nfollowers": number of followers
* "nfollowing": number of following
* "ntweets": number of tweets
* "protected": is account protected

## SEARCH.PY - Search

invoked from shell (requires 3 arguments): python3 search.py SEARCHTERM ELASTICTAG COUNT

* e.g. python3 search.py "Christmas Day since:2022-12-25" Christmas 500

This would scrape basic metadata from up to 500 tweets containing the words "Christmas Day" posted since December 25th 2022, and add the elasticseach tag "Christmas" to all results.

### The Search scraper provides metadata for:

* "essid": elasticsearch custom tag                
* "conversation_id": twitter internal tweet id
* "created_at": date and time of tweet
* "link": url of the tweet
* "name": friendly account name
* "nlikes": number of likes for a tweet
* "nreplies": number of replies to a tweet
* "nretweets": number of retweets of a tweet
* "user_id_str": unique user id string
* "username": twitter account username
* "bio": twitter account biographical text
* "tweet": the raw content of the tweet
* "hashtags": hashtags from the collected tweet
* "cashtags": cashtags from the collected tweet
* "verified": verification state of the account
* "subscribed": subscription (twitter blue) state of the account              
* "age": creation date of twitter account
* "nfollowers": number of followers
* "nfollowing": number of following
* "ntweets": number of tweets

## ADVSEARCH.PY - Advanced Search

invoked from shell (requires 3 arguments): python3 advsearch.py SEARCHTERM ELASTICTAG COUNT

* e.g. python3 advsearch.py "SpaceX Starship SN15 since:2021-05-06 filter:native_video" SpaceX 5000

This would scrape all available metadata from up to 5,000 tweets which contain embedded video, posted since May 6th 2021, and add the elasticseach tag SpaceX to all results.

### The Advanced Search scraper provides metadata for:

* "essid": elasticsearch custom tag                
* "conversation_id": twitter internal tweet id
* "created_at": date and time of tweet
* "link": url of the tweet
* "name": friendly account name
* "nlikes": number of likes for a tweet
* "nreplies": number of replies to a tweet
* "nretweets": number of retweets of a tweet
* "user_id_str": unique user id string
* "username": twitter account username
* "bio": twitter account biographical text
* "tweet": the raw content of the tweet
* "hashtags": hashtags from the collected tweet
* "cashtags": cashtags from the collected tweet
* "place": the user's self declared location info from bio
* "verified": verification state of the account
* "subscribed": subscription (twitter blue) state of the account              
* "age": creation date of twitter account
* "nfollowers": number of followers
* "nfollowing": number of following
* "ntweets": number of tweets
* "photourl": profile photo image URL
* "bannerurl": profile banner image URL
* "protected": is account protected

