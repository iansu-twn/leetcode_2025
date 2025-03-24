with cum_sum as (
    select *, sum(weight) over (order by turn) cum
    from queue
    order by turn
)
select person_name
from queue
where turn = (
    select max(turn)
    from cum_sum
    where cum <= 1000
)

def last_passenger(queue: pd.DataFrame) -> pd.DataFrame:
    queue.sort_values("turn", inplace=True)
    -- method 1
    cum_sum = 0
    person_name = ""
    for _, row in queue.iterrows():
        cum_sum += row.weight
        if cum_sum <= 1000:
            person_name = row.person_name
        else:
            break
    return pd.DataFrame({
        "person_name": [person_name]
    })

    -- method 2
    queue.cum_sum = queue.weight.cumsum()
    return queue[queue["cum_sum"] <= 1000].tail(1)[["person_name"]]