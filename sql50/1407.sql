select name, ifnull(sum(distance), 0) travelled_distance
from users u
left join rides r
on u.id = r.user_id
group by name, u.id
order by travelled_distance desc, name asc

import pandas as pd

def top_travellers(users: pd.DataFrame, rides: pd.DataFrame) -> pd.DataFrame:
    df = users.merge(
        rides,
        how="left",
        left_on="id",
        right_on="user_id"
    ).fillna(0).groupby(["name", "user_id"]).agg(
        travelled_distance=("distance", "sum")
    ).reset_index().sort_values(["travelled_distance", "name"], ascending=[False, True])
    return df[["name", "travelled_distance"]]