select name
from salesperson s
where sales_id not in (
    select distinct sales_id
    from orders o
    join company c
    on c.com_id = o.com_id
    where c.name = 'red' 
)

def sales_person(sales_person: pd.DataFrame, company: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    sales_id_red = orders.merge(
        company,
        how="inner",
        on="com_id"
    ).query("name == 'RED'")["sales_id"].unique()
    return sales_person.loc[~sales_person["sales_id"].isin(sales_id_red)][["name"]]
