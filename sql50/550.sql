with first_day as (
    select player_id, min(event_date) event_date
    from activity
    group by player_id
)
select round(sum(case when games_played is not null then 1 else 0 end)/count(distinct fd.player_id), 2) fraction
from first_day fd
left join activity a
on fd.player_id = a.player_id
and fd.event_date = date_sub(a.event_date, interval 1 day)

import pandas as pd
import numpy as np
from datetime import datetime, timedelta

def gameplay_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    min_act = activity.sort_values("event_date").drop_duplicates(subset="player_id", keep="first")
    activity["event_date"] = pd.to_datetime(activity["event_date"])
    activity["pre"] = activity["event_date"] - timedelta(days=1)
    df = min_act[["player_id", "event_date"]].merge(
        activity,
        how="left",
        left_on = ["player_id", "event_date"],
        right_on = ["player_id", "pre"]
    )
    df["val"] = np.where(df["games_played"].notna(), 1, 0)
    return pd.DataFrame(data=[{
        "fraction": df["val"].mean().round(2)
    }])