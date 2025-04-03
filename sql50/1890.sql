select user_id, max(time_stamp) last_stamp
from logins
where time_stamp >= 20200101
and time_stamp < 20210101
group by user_id

import pandas as pd

def latest_login(logins: pd.DataFrame) -> pd.DataFrame:
    logins = logins[
        (logins["time_stamp"] >= '2020-01-01') &
        (logins["time_stamp"] < '2021-01-01')
    ]
    return logins.groupby("user_id")["time_stamp"].max().reset_index(name="last_stamp")