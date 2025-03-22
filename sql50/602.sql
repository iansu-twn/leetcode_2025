with stotal as (
    select requester_id id
    from requestaccepted
    union all
    select accepter_id id
    from requestaccepted
),
total as (
    select id, count(*) num
    from stotal
    group by id
)
select *
from total
where num = (
    select max(num)
    from total
)

def most_friends(request_accepted: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    request = request_accepted[["requester_id"]].rename(columns={"requester_id": "id"})
    accept = request_accepted[["accepter_id"]].rename(columns={"accepter_id": "id"})
    df = pd.concat([request, accept])
    df = df.groupby("id").size().reset_index().rename(columns={0:"num"})
    return df.sort_values("num", ascending=False).head(1)

    -- method 2
    df = pd.concat([
        request_accepted["requester_id"],
        request_accepted["accepter_id"]
    ]).value_counts().reset_index(name="num").rename(columns={"index": "id"}).head(1)
    return df