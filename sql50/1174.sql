select round(avg(case when order_date = customer_pref_delivery_date then 100 else 0 end), 2) as immediate_percentage
from delivery
where (customer_id, order_date) in (
    select customer_id, min(order_date) order_date
    from delivery
    group by customer_id
)

import pandas as pd
import numpy as np
def immediate_food_delivery(delivery: pd.DataFrame) -> pd.DataFrame:
    sub = delivery.groupby("customer_id").agg({
        "order_date": "min"
    }).reset_index()
    delivery = delivery.merge(
        sub,
        how="inner",
        on=["customer_id", "order_date"]
    ).reset_index()
    delivery["t"] = np.where(delivery["order_date"] == delivery["customer_pref_delivery_date"], 100, 0)
    val = np.average(delivery["t"])
    return pd.DataFrame(data=[{"immediate_percentage": round(val, 2)}])
