select name
from customer
where referee_id != 2 
or referee_id is null

-- use coalesce
select name
from customer
where coalesce(referee_id, 0) != 2

def find_customer_referee(customer: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    return customer[
            (customer["referee_id"] != 2) |
            (customer["referee_id"].isna())
        ][["name"]]

    -- method 2
    return customer.loc[
        lambda row: (row["referee_id"] != 2)|
        (row["referee_id"].isna())
    ][["name"]]

    -- method 3
    return customer.loc[
        (customer["referee_id"] != 2)|
        (customer["referee_id"].isna())
    ][["name"]]