select user_id buyer_id, join_date, ifnull(orders_in_2019, 0) orders_in_2019
from users u
left join (
    select buyer_id, count(*) orders_in_2019
    from orders
    where year(order_date) = 2019
    group by buyer_id
)o
on u.user_id = o.buyer_id

import pandas as pd

def market_analysis(users: pd.DataFrame, orders: pd.DataFrame, items: pd.DataFrame) -> pd.DataFrame:
    orders = orders[
        orders.order_date.dt.strftime("%Y") == '2019'
    ].groupby("buyer_id").size().reset_index(name="orders_in_2019")
    df = users.merge(
        orders,
        how="left",
        left_on="user_id",
        right_on="buyer_id"
    ).fillna(0)[["user_id", "join_date", "orders_in_2019"]].rename(columns={"user_id": "buyer_id"})
    return df