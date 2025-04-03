select name, sum(amount) balance
from users u
join transactions t
on u.account = t.account
group by name
having balance > 10000

import pandas as pd

def account_summary(users: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    df = users.merge(
        transactions,
        how="inner",
        on="account"
    ).groupby("name").agg(
        balance=("amount", "sum")
    ).reset_index()
    return df[df["balance"]>10000][["name", "balance"]]