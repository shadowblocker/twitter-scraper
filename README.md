# A toolkit to rapidly generate datasets for OSINT/DataSci analysis from twitter metadata using SNSCRAPE.

Shadowblocker is one of the core components of a collaborative social media project which aims to automatically search for, indentify, and blocklist Twitter user accounts which are engaged in spam, scams, disinformation, platform manipulation, and targeted harassment.

The project's core components are:

* Dedicated Kibana/ElasticSearch server for scrubbing, storage, processing, filtering, running sentiment analysis, and visualizing the data.

* Modular crawler appliances built on RasberryPi 4 microcomputers with individually killswitched VPNs, these each make use of SNSCRAPE and run the physical crawler scripts when called either by crontab or the central scheduler and parse the data back to the elasticsearch server. The crawlers work by iterating through a series of lists stored as plaintext files. This is for ease of use by non technical project members. The crawlers currently scan hashtags, advanced search arguments, unique user IDs, and usernames. 

* Central scheduler allocates workload to individual cawler appliances based on which node has the least current activity, also parses manual/organic search tasks to least busy crawler. 

* Blocklist Engine. Initially the project had a self-hosted BlockTogether instance but following that project being shuttered maintaining the instance was too challenging for our contributors. The blocklist is now hosted on a thid-party blocktogether instance which is well maintained. The blocklist hits generated from elasticsearch are dumped to a CSV of UUIDs which is then manually imported on a near daily basis to the twitter account linked to the blocktogether instance with the chrome RedBlock plugin. This limits daily blocks to around 500 accounts at present, but as this is below the number blocks typically generated over a day this has not caused an issue so far.


![alt text](https://github.com/shadowblocker/twitter-scraper/raw/main/readme/kibana-discover-brexit.png "Kibana view of twitter metadata from pro-brexit accounts")

# History

At first the crawlers searched twitter trending topics for high volumes of tweets with similar or identical content, in order to identify spammers and disinformation copypasta accounts. The UUIDs of accounts found likely to be inauthentic or engaging in these behaviours were then passed to the blocktogether instance, where twitter users could subscribe to the automatically generated public blocklist which auto-blocks the flagged accounts on their behalf with no interaction beyond the initial blocktogether setup.

Initially written fully to use twitter's API, recent changes at Twitter have necessitated branching out to make use of other methods of gathering the metadata required, should twitter pull the plug on free API accounts. 

To ensure that the crawlers do not stop working if the API access situation changes, a new crawler component has been developed from scratch which no longer uses the API but still allows continuous harvesting, now without twitter's restrictive rate limits or API limitations. 

As the efficacy of the collection methodology rightly attracts and deserves scrutiny, the decision has been taken to publicly post the API-less collection crawlers here on GitHub. This may also be of assistance to anybody wishing to use a similar model for scraping tweets without the API.

# Usage

Shadowblocker makes use of input list files. These are simple txt files which can be edited by anyone with a basic level of technical skill. The crawler scripts will recursively iterate through each line of the text files. The crawler scripts can also be invoked manually and run directly from bash.

* USERID - A text file with line seperated twitter account UUIDs (a blank line should be left at the end). Makes use of the userid.py crawler-script.

* USER - A text file with line seperated twitter account Usernames (a blank line should be left at the end). Makes use of the username.py rawler-script.

* FASTUSER - A text file with line seperated twitter account Usernames (a blank line should be left at the end). Makes use of the fastuser.py crawler-script.

* SEARCH - A text file with line seperated search terms, equivalent the a keyword search (a blank line should be left at the end). Makes use of the search.py crawler-script.

* HASHTAGS - A text file with line seperated twitter hashtags (a blank line should be left at the end). Makes use of the hashtag.py crawler-script.
* 
* CASHTAGS - A text file with line seperated twitter cashtags (a blank line should be left at the end). Makes use of the cashtag.py crawler-script.

* ADVANCEDSEARCH - A text file with line seperated advanced twitter search parameters (a blank line should be left at the end). Makes use of the advsearch.py crawler-script.

As the scripts run, they will output the information to an elasticsearch instance. 

# Dependencies.

* Hashivault
* Python 3.10+
* SNSCRAPE
* ElasticSearch
* Kibana (optional)
* Hashivault (optional)

# CONFIGURATION

#USAGE

