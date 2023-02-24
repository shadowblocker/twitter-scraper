## Crawling User accounts

### Usernames

invoked from shell (requires 3 arguments): python3 user.py USERNAME ELASTICTAG COUNT

* e.g. python3 user.py bbcnews broadcasters 50000

This would scrape basic metadata from up to 50,000 of the most recent tweets sent by the account @BBCNews and add the elasticseach tag "broadcasters" to all results.

### UserIDs

invoked from shell (requires 3 arguments): python3 user.py USERID ELASTICTAG COUNT

* e.g. python3 user.py 252521025 global-influencers 750

This would scrape basic metadata from up to 750 of the most recent tweets sent by the user_id 252521025 (@Number10cat) and add the elasticseach tag "global-influencers" to all results.

### FastUser

## Crawling Hashtags and Cashtags

### Hashtags

invoked from shell (requires 3 arguments): python3 hashtag.py HASHTAG ELASTICTAG COUNT

* e.g. python3 hashtag.py blackfriday blackfriday 150000

This would scrape basic metadata from up to 150,000 tweets containing the hashtag #BlackFriday and add the elasticseach tag "blackfriday" to all results.

### Cashtags

invoked from shell (requires 3 arguments): python3 cashtag.py CASHTAG ELASTICTAG COUNT

* e.g. python3 cashtag.py tsla stocks 1000

This would scrape basic metadata from up to 1000 tweets containing the cashtag $TSLA and add the elasticseach tag "stocks" to all results.


## Crawling keywords and phrases from within tweets

### Search

invoked from shell (requires 3 arguments): python3 search.py SEARCHTERM ELASTICTAG COUNT

* e.g. python3 search.py "Christmas Day since:2022-12-25" Christmas 500

This would scrape basic metadata from up to 500 tweets containing the words "Christmas Day" posted since December 25th 2022, and add the elasticseach tag "Christmas" to all results.

### Advanced Search

invoked from shell (requires 3 arguments): python3 advsearch.py SEARCHTERM ELASTICTAG COUNT

* e.g. python3 advsearch.py "SpaceX Starship SN15 since:2021-05-06 filter:native_video" SpaceX 5000

This would scrape all available metadata from up to 5,000 tweets which contain embedded video, posted since May 6th 2021, and add the elasticseach tag SpaceX to all results.
