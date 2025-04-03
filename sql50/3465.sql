select product_id, product_name, description
from products
where description regexp 'SN[0-9]{4}-[0-9]{4}(?![0-9])'
order by product_id

import pandas as pd

def find_valid_serial_products(products: pd.DataFrame) -> pd.DataFrame:
    pattern = r"SN\d{4}-\d{4}(?![0-9])"
    df = products[products["description"].str.contains(pattern, na=False)]
    return df.sort_values("product_id")