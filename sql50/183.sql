select name Customers
from customers
where id not in (
    select distinct customerid
    from orders
)

def find_customers(customers: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    orders_id = orders["customerId"].unique()
    return customers[
        ~customers.id.isin(orders_id)
    ][["name"]].rename(columns={"name": "Customers"})