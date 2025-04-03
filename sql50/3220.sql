select 
    transaction_date,
    sum(if(amount%2, amount, 0)) odd_sum,
    sum(if(amount%2, 0, amount)) even_sum
from transactions
group by transaction_date
order by transaction_date

import pandas as pd

def sum_daily_odd_even(transactions: pd.DataFrame) -> pd.DataFrame:
    -- method 1: create two new columns first
    transactions["odd_sum"] = transactions.apply(
        lambda row: row["amount"] if row["amount"] % 2 else 0,
        axis = 1
    )
    transactions["even_sum"] = transactions.apply(
        lambda row: row["amount"] if row["amount"] % 2 == 0 else 0,
        axis = 1
    )
    return transactions.groupby("transaction_date").agg({
        "odd_sum": "sum",
        "even_sum": "sum"
    }).reset_index().sort_values("transaction_date")

    -- method 2: groupby
    return transactions.groupby("transaction_date").agg(
        odd_sum=("amount", lambda x: sum(x[x % 2 == 1])),
        even_sum=("amount", lambda x: sum(x[x % 2 == 0]))
    ).reset_index()