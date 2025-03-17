select
    sell_date, count(distinct product) num_sold,
    group_concat(distinct product order by product asc separator ',') products
from activities
group by sell_date
order by sell_date

def categorize_products(activities: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    activities.drop_duplicates(inplace=True)
    activities.sort_values(["sell_date", "product"], ascending=True, inplace=True)

    activities_1 = activities.groupby("sell_date").agg({
        "product": "size"
    }).reset_index().rename(columns={"product": "num_sold"})

    activities_2 = activities.groupby("sell_date").agg({
        "product": lambda t: ",".join(t)
    }).reset_index().rename(columns={"product": "products"})
    activities = activities_1.merge(
        activities_2,
        how="inner",
        on=["sell_date"]
    )
    return activities

    -- method 2
    activities = activities.groupby("sell_date")["product"].agg([
        ("num_sold", "nunique"),
        ("products", lambda t: ','.join(sorted(t.unique())))
    ]).reset_index()
    return activities