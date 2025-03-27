select player_id, min(event_date) first_login
from activity
group by player_id

def game_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    # method 1
    return activity.groupby("player_id").agg(
        first_login=("event_date", "min")
    ).reset_index()

    # method 2
    return activity[["player_id", "event_date"]].sort_values("event_date").drop_duplicates("player_id").rename(columns={"event_date": "first_login"})