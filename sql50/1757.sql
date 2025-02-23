select product_id
from products
where low_fats = 'Y'
and recyclable = 'Y'

import pandas as pd
def find_products(products: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    return products[
        (products["low_fats"] == "Y") & 
        (products["recyclable"] == "Y")
    ][["product_id"]]

    -- method 2
    return products.loc[
        lambda row: (row["low_fats"] == "Y") &
        (row["recyclable"] == "Y")
    ][["product_id"]]

    -- method 3, use query directly
    return products.query("low_fats == 'Y' and recyclable = 'Y'")[["product_id"]]