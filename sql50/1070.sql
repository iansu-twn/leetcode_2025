with min_product as (
    select product_id, min(year) year
    from sales
    group by product_id
)
select product_id, year first_year, quantity, price
from sales
where (product_id, year) in (
    select * from min_product
)

def sales_analysis(sales: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:
    df = sales.sort_values("year").drop_duplicates(subset="product_id", keep="first").rename(columns={"year": "first_year"}).drop(columns=["sale_id", "quantity", "price"])
    sales = sales.merge(
        df,
        how="inner",
        left_on=["year", "product_id",],
        right_on=["first_year", "product_id"]
    )
    return sales[["product_id", "first_year", "quantity", "price"]]