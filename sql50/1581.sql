select customer_id, count(*) count_no_trans
from visits v
left join transactions t
on t.visit_id = v.visit_id
where t.visit_id is null
group by customer_id

def find_customers(visits: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    df = visits.merge(
        transactions,
        how="left",
        on="visit_id"
    )
    -- method 1
    df = df[df["transaction_id"].isna()]
    df = df.groupby("customer_id").size().reset_index()
    -- can write reset_index(name="count_no_trans") for better readability
    df = df.rename(columns={0:"count_no_trans"})
    return df

    -- method 2
    -- avoid creating a intermediate dataframe (more direct way)
    df = df[df["transaction_id"].isna()]["customer_id"]
    return df.value_counts().reset_index(name="count_no_trans")