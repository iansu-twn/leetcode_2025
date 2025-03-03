select activity_date day, count(distinct user_id) active_users
from activity a
where activity_date > date_sub(20190727, interval 30 day)
and activity_date <= 20190727
group by activity_date

import pandas as pd
from datetime import datetime, timedelta
def user_activity(activity: pd.DataFrame) -> pd.DataFrame:
    df = activity[
        (activity["activity_date"] > datetime(2019, 7, 27)-timedelta(days=30)) &
        (activity["activity_date"] <= datetime(2019, 7, 27))
    ]
    df = df.groupby("activity_date").agg(
        active_users=("user_id", "nunique")
    ).reset_index().rename(columns={"activity_date": "day"})
    return df