#!/bin/bash
# A script the run a rapid hourly crawl of accounts of interest by user-id.
# Remember to set execution permissions for the template to avoid having to do manually for each crawler "sudo chmod +x snscrape-template.sh". 

#   ShadowBlocker VARIABLES
#   Here we set the basic internal parameters we want the crawler to use

prefix="snscrape-"                                                  # allows user to differentiate between snscrape or tweepy based crawls 
crawler="tesla"                                                     # a friendly name for the crawler
crawlessid=""$prefix""$crawler""                                    # creates the elasticsearch tag by combining prefix and crawler fields
crawlhashtaglimit="500"                                             # how many tweets from each listed hashtag to search for
crawlcashtaglimit="500"                                             # how many tweets from each listed cashtag to search for
crawlsearchlimit="500"                                              # how many tweets from each listed search string to look for
crawluserlimit="100"                                                # how many of each user's tweets to search for

#   DIRECTORY AND SCRIPT LOCATIONS
#   Providing repo is cloned directly to user home folder these shouldn't need to be changed

crawlhashtag="python3 $HOME/twitter-scraper/snscrape/hashtag.py"
crawlsearch="python3 $HOME/twitter-scraper/snscrape/search.py"          # substitute for advsearch.py for slower but more detailed crawls
crawluser="python3 $HOME/twitter-scraper/snscrape/user.py"              # substitute for fastuser.py for quicker but less detailed crawls
crawluserid="python3 $HOME/twitter-scraper/snscrape/hashtag.py"
crawlerpath="$HOME/twitter-scraper/crawlers/"
logpath="$HOME/twitter-scraper/crawlers/logs/"

userfile=""$crawlerpath""$prefix""$crawler"/user-"$crawler".txt"
useridfile=""$crawlerpath""$prefix""$crawler"/userid-"$crawler".txt"
searchfile=""$crawlerpath""$prefix""$crawler"/search-"$crawler".txt"
hashtagfile=""$crawlerpath""$prefix""$crawler"/hashtag-"$crawler".txt"
cashtagfile=""$crawlerpath""$prefix""$crawler"/cashtag-"$crawler".txt"
logfile=""$logpath""$prefix""$crawler".log"

#   DATE CONFIG
#   Allows you to set some search limiters based on tweets sent since today or sent yesterday.

today=$(date +"%Y-%m-%d")
yesterday=$(date -d "yesterday" +%Y-%m-%d)

#   PRERUN Checks for logfiles

touch "$logfile"
touch "$userfile"
touch "$useridfile"
touch "$searchfile"
touch "$hashtagfile"
touch "$cashtagfile"

#   COUNTER VARIABLES
#   This defines a start number for the counter variable and defines 6 digit outputs.

count=000001
counter=$(printf %06d $count)

#   COLOUR VARIABLES
#   Setting up colours we use for text output in shell and logs.

YELLOW='\033[1;33m'
NC='\033[0m' # No Color

#   START COLLECTION
#   Generate a log entry and announce the start of the crawl

echo -e ""${YELLOW}""$(date +"%D %T")" - Search job started for "$prefix""$crawler" "${NC}""
echo -e ""$(date +"%D %T")" - Search job started for "$prefix""$crawler"" >> "$logfile"

##### ##### ##### Crawl for tweets since yesterday containing regular search terms 

while read line; do
echo -e ""$counter" - "$crawlessid" - search: "${line:0}" since: "$today""
$crawlsearch "${line:0} since:$yesterday" $crawlessid $crawlsearchlimit # >/dev/null >> $logfile
let "count=count+1"
counter=$(printf %06d $count)
sleep 1
done < $searchfile

##### ##### ##### Crawl for tweets containing hashtags

while read line; do
echo -e ""$counter" - "$crawlessid" - hashtag: "${line:0}" since: "$today""
$crawlhashtag "${line:1} since:$yesterday" $crawlessid $crawlhashtaglimit >/dev/null >> $logfile
let "count=count+1"
counter=$(printf %06d $count)
sleep 1
done < $hashtagfile

##### ##### ##### Crawl for tweets containing cashtags 

while read line; do
echo -e ""$counter" - "$crawlessid" - search: "${line:0}" since: "$today""
$crawlsearch "${line:0} since:$yesterday" $crawlessid $crawlsearchlimit # >/dev/null >> $logfile
let "count=count+1"
counter=$(printf %06d $count)
sleep 1
done < $cashtagfile

##### ##### ##### Crawl a list of accounts by twitter account USERNAME

while read line; do
echo -e ""$counter" - "$crawlessid" - username: "${line:0}" since: "$today""
$crawluser ${line:1} $crawlessid $crawluserlimit >/dev/null >> $logfile
let "count=count+1"
counter=$(printf %06d $count)
sleep 1
done < $userfile

##### ##### ##### Crawl a list of accounts by twitter account USER-UUID

while read line; do
echo -e ""$counter" - "$crawlessid" - userid: "${line:0}" since: "$today""
$crawluser ""${line:0}" since:"$timeframe"" $crawlessid $crawluserlimit >/dev/null >> $logfile
let "count=count+1"
counter=$(printf %06d $count)
sleep 1
done < $useridfile

#   FINISH COLLECTION
#   Generate a log entry and announce the completion of the crawl

echo -e "${YELLOW}"$(date +"%D %T")" - Collection complete for "$prefix""$crawler". (Collected "$counter" records in $SECONDS seconds).${NC}"
echo -e ""$(date +"%D %T")" Collection complete for "$prefix""$crawler"" >> $logfile
