-- left join
select w1.id
from weather w1
left join weather w2
on w1.recordDate = date_add(w2.recordDate, interval 1 day)
where w1.temperature > w2.temperature

-- cross join and set datediff == 1 condition
select w1.id
from weather w1
cross join weather w2
where datediff(w1.temperature, w2.temperature) = 1
and w1.temperature > w2.temperature

import pandas as pd
from datetime import timedelta
def rising_temperature(weather: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    weather["prev"] = weather["recordDate"] + timedelta(days=1)
    df = weather.merge(
        weather,
        how="left",
        left_on="recordDate",
        right_on="prev"
    )
    df = df[df["temperature_x"] > df["temperature_y"]][["id_x"]]
    return df.rename(columns={"id_x": "id"})

    -- method 2
    -- sort the dataframe by recordDate first
    -- use diff function to set contidions (it will compare two consecutive data)
    weather = weather.sort_values(by="recordDate", inplace=True)
    return weather[
        (weather.temperature.diff() > 0) &
        (weather.recordDate.diff().dt.days == 1)
    ][["id"]]