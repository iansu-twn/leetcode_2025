select user_id, count(follower_id) followers_count
from followers
group by user_id
order by user_id

def count_followers(followers: pd.DataFrame) -> pd.DataFrame:
    df = followers.groupby("user_id").agg(
        followers_count=("follower_id", "size")
    ).reset_index()
    return df[["user_id", "followers_count"]].sort_values("user_id", ascending=True)

    return followers.groupby("user_id").agg(
        followers_count=("follower_id", "size")
    ).reset_index().sort_values("user_id", ascending=True)