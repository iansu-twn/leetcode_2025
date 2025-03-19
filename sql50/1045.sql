select customer_id
from customer
group by customer_id
having count(distinct product_key) = (select count(product_key) from product)

def find_customers(customer: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:
    customer = customer.groupby("customer_id").agg(
        product_key = ("product_key", "nunique")
    ).reset_index()
    val = len(product)
    customer = customer.query(f"product_key == {val}")
    return customer[["customer_id"]]