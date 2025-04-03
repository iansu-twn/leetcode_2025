select stock_name, 
sum(case when operation = 'sell' then price else -price end) as capital_gain_loss
from stocks
group by stock_name

import pandas as pd

def capital_gainloss(stocks: pd.DataFrame) -> pd.DataFrame:
    stocks["nav"] = stocks.apply(
        lambda row: -row["price"] if row["operation"] == "Buy" else row["price"],
        axis = 1
    )
    stocks = stocks.groupby("stock_name").agg(
        capital_gain_loss=("nav", "sum")
    ).reset_index()
    return stocks