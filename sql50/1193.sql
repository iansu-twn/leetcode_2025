select date_format(trans_date, "%Y-%m") month,
country, count(*) trans_count,
sum(case when state = 'approved' then 1 else 0 end) approved_count,
sum(amount) trans_total_amount,
sum(case when state = 'approved' then amount else 0 end) approved_total_amount
from transactions t
group by date_format(trans_date, "%Y-%m"), country

import numpy as np
def monthly_transactions(transactions: pd.DataFrame) -> pd.DataFrame:
    transactions["approved"] = np.where(transactions["state"] == "approved", transactions["amount"], np.nan)
    transactions["month"] = transactions["trans_date"].dt.strftime("%Y-%m")
    transactions = transactions.groupby(["month", "country"], dropna=False).agg(
        trans_count = ("state", "count"),
        approved_count = ("approved", "count"),
        trans_total_amount = ("amount", "sum"),
        approved_total_amount = ("approved", "sum")
    ).reset_index()
    return transactions