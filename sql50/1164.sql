with first_change as (
    select distinct product_id product_id, 10 price
    from products
    where product_id not in (
        select distinct product_id
        from products
        where change_date <= 20190816
    )
),
changed as (
    select product_id, new_price price 
    from products 
    where (product_id, change_date) in (
        select product_id, max(change_date) change_date
        from products
        where change_date <= 20190816
        group by product_id
    )
)
select * from first_change
union 
select * from changed

def price_at_given_date(products: pd.DataFrame) -> pd.DataFrame:
    old = products[products["change_date"] <= "2019-08-16"].sort_values(
        ["product_id", "change_date"],
        ascending=[True, False]
    ).drop_duplicates(["product_id"], keep="first")
    res = pd.merge(
        products[["product_id"]].drop_duplicates(),
        old[["product_id", "new_price"]],
        how="left"
    ).fillna(10).rename(columns={"new_price": "price"})
    return res

    