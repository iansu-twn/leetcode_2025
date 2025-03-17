select product_name, sum(unit) unit
from products p
join orders o
on p.product_id = o.product_id
where order_date >= 20200201
and order_date < 20200301
group by product_name
having sum(unit) >= 100

def list_products(products: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    df = products.merge(
        orders,
        how="inner",
        on="product_id"
    ).query("order_date >= 20200201 and order_date < 20200301")
    df = df.groupby("product_name").agg({
        "unit": "sum"
    }).reset_index()
    df = df[
        df["unit"] >= 100
    ]
    return df