#!/bin/bash
# A script the run a rapid hourly crawl of accounts of interest by user-id.

#   ShadowBlocker VARIABLES
#   Here we set the basic params we want the crawler to use

prefix="snscrape-"
crawler="template"
crawlessid=""$prefix""$crawler""
crawlhashtaglimit="500"
crawlsearchlimit="500"
crawluserlimit="100"
crawlhashtag="python3 ~/twitter-scraper/snscrape/hashtag.py"
crawlsearch="python3 ~/twitter-scraper/snscrape/search.py"          # substitute for advsearch.py for slower but more detailed crawls
crawluser="python3 ~/twitter-scraper/snscrape/user.py"              # substitute for fastuser.py for quicker but less detailed crawls
crawluserid="python3 ~/twitter-scraper/snscrape/hashtag.py"

#   GENERAL CONFIG
#   This section should autopopulate from the vars above and shouldn't need to be touched.

directory="~/twitter-scraper/crawlers/"$prefix""$crawler"/"
userfile=""$directory"user-"$crawler".txt"
useridfile=""$directory"userid-"$crawler".txt"
searchfile=""$directory"search-"$crawler".txt"
hashtagfile=""$directory"hashtag-"$crawler".txt"
cashtagfile=""$directory"cashtag-"$crawler".txt"
logfile="~/twitter-scraper/crawlers/logs/"$prefix""$crawler".log"
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
$crawlhashtag "${line:0} since:$today" $crawlessid $crawlhashtaglimit >/dev/null >> $logfile
let "count=count+1"
counter=$(printf %06d $count)
sleep 1
done < $hashtagfile

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
