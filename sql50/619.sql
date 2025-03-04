select max(num) num
from (
    select num
    from mynumbers
    group by num
    having count(*) < 2
)t

import pandas as pd
import numpy as np
def biggest_single_number(my_numbers: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    df = my_numbers.groupby("num").size().reset_index(name="size")
    df = df[
        df["size"] == 1
    ]
    if df.empty:
        return pd.DataFrame(data=[{"num": np.nan}])
    return df.sort_values("num", ascending=False)[["num"]].head(1)

    -- method 2
    df = my_numbers.num.drop_duplicates(keep=False) -- return a list
    return pd.DataFrame({"num": [max(df, default=None)]})