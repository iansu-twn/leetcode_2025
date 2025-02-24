select tweet_id
from tweets
where length(content) > 15

def invalid_tweets(tweets: pd.DataFrame) -> pd.DataFrame:
   return tweets.loc[tweets["content"].str.len() > 15, ["tweet_id"]]

   