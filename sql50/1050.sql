select actor_id, director_id
from actordirector
group by actor_id, director_id
having count(*) >= 3

def actors_and_directors(actor_director: pd.DataFrame) -> pd.DataFrame:
    actor_director = actor_director.groupby(["actor_id", "director_id"]).size().reset_index(name="cnt")
    res = actor_director.query("cnt >= 3")
    return res[["actor_id", "director_id"]]