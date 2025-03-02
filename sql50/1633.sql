with ttl as (
    select count(*) people
    from users
)
select contest_id, round(count(*)/people*100, 2) percentage
from register r
join ttl
on 1=1
group by contest_id
order by percentage desc, contest_id asc

def users_percentage(users: pd.DataFrame, register: pd.DataFrame) -> pd.DataFrame:
    num = len(users)
    df = register.groupby("contest_id").agg(
        percentage=("user_id", lambda x: round(x.size/num*100, 2))
    ).reset_index()
    return df[["contest_id", "percentage"]].sort_values(by=["percentage", "contest_id"], ascending=[False, True])