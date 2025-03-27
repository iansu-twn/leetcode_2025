select customer_number
from orders
group by customer_number
order by count(*) desc
limit 1

def largest_orders(orders: pd.DataFrame) -> pd.DataFrame:
    return orders.groupby("customer_number").size().reset_index(name="cnt").sort_values("cnt", ascending=False)[["customer_number"]].head(1)