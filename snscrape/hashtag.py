# import modules as needed
import snscrape.modules.twitter as twitter
import getopt, sys
from elasticsearch import Elasticsearch
from elasticsearch import helpers

#define the elasticsearch instance to send crawl results to

client = Elasticsearch("http://elastic-ip:elastic-port/", basic_auth=('elastic-user', 'elastic-pw'))

#take the incoming arguments and define them as variables to use in the crawl

twithash = sys.argv[1]                                              # ingest hashtag to crawl from incoming args
twitessid = sys.argv[2]                                             # ingest elasticsearch tag (essid) from incoming args
twitcount = sys.argv[3]                                             # ingest number of tweets to crawl from incoming args

#print output to show basic summary of the requested crawl
print ("Crawling", twitcount, "tweets containing hashtag", twithash, "tagged with", twitessid)

class Twitter_Elasticsearch():
    def __init__(self) -> None:
        pass

    def tweet_to_elasticsearch_bulk_insert(self, hashtag=twithash):
        maxTweets = int(twitcount)
        tweets_1k = []
        for i, tweet in enumerate(twitter.TwitterHashtagScraper(hashtag).get_items()):
            if i > maxTweets:  break
            tweets = {
                "_index": 'elasticsearch-indexname',                    # elasticsearch custom index for snscrape
                "_id": str(tweet.id),                                   # elasticsearch tweet id
                "conversation_id": tweet.id,                            # twitter internal tweet id
                "created_at" : tweet.date,                              # date and time of tweet
                "essid" : twitessid,                                    # elasticsearch custom tag
                "link" : tweet.url,                                     # url of the tweet
                "name" : tweet.user.displayname,                        # friendly account name
                "nlikes" : tweet.likeCount,                             # number of likes
                "nreplies" : tweet.replyCount,                          # number of replies
                "nretweets" : tweet.retweetCount,                       # number of retweets
                "nquotes" : tweet.quoteCount,                           # number of quotes
                "user_id_str" : tweet.user.id,                          # user id string
                "user_id_label" : tweet.user.label,                     # user account label
                "username" : tweet.user.username,                       # twitter account username
                "bio" : tweet.user.renderedDescription,                 # twitter account bio
                "tweet" : tweet.rawContent,                             # the contents of the tweet
                "hashtags" : tweet.hashtags,                            # hashtags from the collected tweet
                "source" : tweet.source,                                # source identifier
                "place" : tweet.user.location,                          # the stated location of the user account
                "verified" : tweet.user.verified,                       # verification state of the account
                "age" : tweet.user.created,                             # creation date of twitter account
			    "nfollowers": tweet.user.followersCount,                # number of followers
			    "nfollowing" : tweet.user.friendsCount,                 # number of following
			    "ntweets" : tweet.user.statusesCount,                   # number of tweets
			    "protected" : tweet.user.protected                      # is account protected
            }
            tweets_1k.append(tweets)
            if i % 500 == 0 :
                helpers.bulk(client, tweets_1k, chunk_size=500, request_timeout=200)
                tweets_1k = []

if __name__ =='__main__':
    cls = Twitter_Elasticsearch()
    cls.tweet_to_elasticsearch_bulk_insert()