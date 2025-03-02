select product_id, ifnull(round(nav/units, 2), 0) average_price
from (
    select p.product_id, sum(units) units, sum(price*units) nav
    from prices p
    left join unitssold u
    on p.product_id = u.product_id
    and u.purchase_date <= p.end_date
    and u.purchase_date >= p.start_date
    group by p.product_id
)t

def average_selling_price(prices: pd.DataFrame, units_sold: pd.DataFrame) -> pd.DataFrame:
    df = prices.merge(
        units_sold,
        how='left',
        on=["product_id"]
    )
    df = df[
        -- method 1
        ((df.purchase_date >= df.start_date) &
        (df.purchase_date <= df.end_date)) |
        -- method 2
        (df.purchase_date.between(df.start_date, df.end_date)) |
        (df.purchase_date.isna())
    ]
    df = df.groupby("product_id").apply(
        lambda x: round((x["price"] * x["units"]).sum() / x["units"].sum(), 2) if x["units"].sum() != 0 else 0
    ).reset_index(name="average_price")
    return df[["product_id", "average_price"]]