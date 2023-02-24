## Crawler Template Outline

This SNSCRAPE crawler script is a work in progress, as is the documentation. It'll get better with time and automation will remove many of these steps. 

For the purposes of the README we'll uset up a crawler to locate tweets and users tweeting about Tesla.

## Duplicate and Customise the Template:

### Make shell script executable

* chmod +x snscrape-template/snscrape-template.sh

### Duplicate the template and customise as required

* $ cp snscrape-template snscrape-tesla

### Switch to the new directory and rename the shell script.

* cd snscrape-tesla
* mv snscrape-template.sh snscrape-telsa.sh

### Edit the shell script with your favourite editor

* replace ""template" in line 7 with the friendly name of your crawler. EG: crawler="template" = crawler="tesla"

### Run the shell script to create all the listfiles

* $ ./snscrape-tesla.sh

This will create the following files:

* snscrape-tesla/user-tesla.txt
* snscrape-tesla/userid-tesla.txt
* snscrape-tesla/search-tesla.txt
* snscrape-tesla/hashtag-tesla.txt
* snscrape-tesla/cashtag-tesla.txt
* logs/snscrape-tesla.log

