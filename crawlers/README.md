## Crawler Template Outline

This SNSCRAPE crawler script is a work in progress, as is the documentation. It'll get better with time and automation will remove many of these steps. 

For the purposes of the README we'll set up a crawler to crawl tweets from popular accounts that tweet about Tesla, and some common Tesla hashtags. We'll add the elasticsearch tag "tesla" to all results.

## Duplicate and Customise the Template:

### Make shell script executable

* chmod +x snscrape-template/snscrape-template.sh

### Duplicate the template and customise as required

* $ cp snscrape-template snscrape-tesla

### Switch to the new crawler's directory and rename the shell script.

* cd snscrape-tesla/
* mv snscrape-template.sh snscrape-telsa.sh

### Edit the shell script with your favourite editor

WHen using multiple crawlers, it's useful to be able to separately filter the results. To do this we use elasticsearch ID tags (ESSID's). These are set in line 7.

* replace "template" in line 7 with the friendly name of your crawler. EG: crawler="template" = crawler="tesla"

The rest of the variables in this section cover the number of results you want to scrape. The default values below are reasonably conservative prioritizing speed over quantity.

* pick how many tweets to search for with each hashtag, by editing the hashtaglimit on line 10: crawlhashtaglimit="500"
* pick how many tweets to search for with each searchterm, by editing the searchlimit on line 11: crawlsearchlimit="500"
* pick how many of a user's tweets to crawl by editing the userlimit on line 12: crawluserlimit="100"

### Run the shell script to create all the listfiles

* $ ./snscrape-tesla.sh

This will create the following files:

* snscrape-tesla/user-tesla.txt
* snscrape-tesla/userid-tesla.txt
* snscrape-tesla/search-tesla.txt
* snscrape-tesla/hashtag-tesla.txt
* snscrape-tesla/cashtag-tesla.txt
* logs/snscrape-tesla.log

## Setting up the Crawler:

Each of the text files in the crawler directory are simple lists. You place a variable in a new line and the cawler will iterate through the list sequentially line by line.

### Userlist - snscrape-tesla/user-tesla.txt

We'll add some users who tweet about Tesla here. Using your favourite text editor open the user file and start adding users each on a new line.
Case insensitive. Make sure the @ symbol is not included and leave an empty line on the end or the last line will be missed out (fix in progress).

* Tesla
* TeslaSolar
* live_munro
* teslaownersSV
* teslapodcast
* teslarati
* teslamotorsclub
*  

### Hashtaglist - snscrape-tesla/hashtag-tesla.txt

We'll add some common hashtags accounts use when discussing Tesla here. Using your favourite text editor open the hashtag file and start adding users each on a new line.
Case insensitive. Make sure the # symbol is not included and leave an empty line on the end (fix in progress).

* Tesla
* TeslaSolar
* teslamodels
* teslamodel3
* teslamodelx
* teslamodely
* teslasemi
* cybertruck
*  

### Searchlist - snscrape-tesla/search-tesla.txt

We'll add some basic search terms commonly used when discussing Tesla here. Using your favourite text editor open the search file and start adding search terms each on a new line.
Case insensitive. place multi-word terms in quotes and leave an empty line on the end (fix in progress).

* "Tesla Model S"
* "Tesla Model 3"
* "Tesla Model X"
* "Tesla Model Y"
* "Tesla Semi"
* "Tesla Cybertruck"
* cybertruck
*  

## Running the crawler

Now the crawler can be run. It will iterate through each of the list files running the appropriate SNSCRAPE script against each listfile.

* cd ..
* ./snscrape-tesla/snscrape-tesla.sh

The shell may show some warning about elasticsearch authentication methods being deprecated, this is being worked on but doesn't prevent the scripts from running.

Output from the crawl will be sent to the logfile listed above and will show the progross:

* $ tail -f logs/snscrape-tesla.log

02/24/23 20:12:51 - Crawler started for snscrape-tesla
Crawling 500 tweets containing keyword or phrase "Tesla Model S" since:2023-02-23 to ESSID snscrape-tesla
Crawling 500 tweets containing keyword or phrase "Tesla Model 3" since:2023-02-23 to ESSID snscrape-tesla
Crawling 500 tweets containing keyword or phrase "Tesla Model X" since:2023-02-23 to ESSID snscrape-tesla
Crawling 500 tweets containing keyword or phrase "Tesla Model Y" since:2023-02-23 to ESSID snscrape-tesla
Crawling 500 tweets containing keyword or phrase "Tesla Semi" since:2023-02-23 to ESSID snscrape-tesla
Crawling 500 tweets containing keyword or phrase "Tesla Cybertruck" since:2023-02-23 to ESSID snscrape-tesla
Crawling 500 tweets containing keyword or phrase cybertruck since:2023-02-23 to ESSID snscrape-tesla
Crawling 500 tweets containing hashtag Tesla since:2023-02-23 to snscrape-tesla
Crawling 500 tweets containing hashtag TeslaSolar since:2023-02-23 to snscrape-tesla
Crawling 500 tweets containing hashtag teslamodels since:2023-02-23 to snscrape-tesla
Crawling 500 tweets containing hashtag teslamodel3 since:2023-02-23 to snscrape-tesla
Crawling 500 tweets containing hashtag teslamodelx since:2023-02-23 to snscrape-tesla
Crawling 500 tweets containing hashtag teslamodely since:2023-02-23 to snscrape-tesla
Crawling 500 tweets containing hashtag teslasemi since:2023-02-23 to snscrape-tesla
Crawling 500 tweets containing hashtag cybertruck since:2023-02-23 to snscrape-tesla
Crawling 100 tweets from twitter account Tesla to snscrape-tesla
Crawling 100 tweets from twitter account TeslaSolar to snscrape-tesla
Crawling 100 tweets from twitter account live_munro to snscrape-tesla
Crawling 100 tweets from twitter account teslaownersSV to snscrape-tesla
Crawling 100 tweets from twitter account teslapodcast to snscrape-tesla
Crawling 100 tweets from twitter account teslarati to snscrape-tesla
Crawling 100 tweets from twitter account teslamotorsclub to snscrape-tesla
02/24/23 20:16:19 Collection complete for snscrape-tesla

