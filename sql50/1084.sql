select product_id, product_name
from product
where product_id not in (
    select distinct product_id
    from sales
    where sale_date not between 20190101 and 20190331
)
and product_id in (
    select distinct product_id
    from sales
    where sale_date between 20190101 and 20190331
)

select product_id, product_name
from product
join sales
using (product_id)
group by product_id
having min(sale_date) >= 20190101 and max(sale_date) <= 20190331

import pandas as pd

def sales_analysis(product: pd.DataFrame, sales: pd.DataFrame) -> pd.DataFrame:
    df = product.merge(
        sales,
        how='inner',
        on='product_id'
    ).groupby(['product_id', 'product_name']).agg(
        min_date=('sale_date', 'min'),
        max_date=('sale_date', 'max')
    ).reset_index()
    return df[(df["min_date"] >= '2019-01-01') & (df['max_date'] <= '2019-03-31')][["product_id", "product_name"]]