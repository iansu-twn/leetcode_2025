select id, movie, description, rating
from cinema c
where mod(id, 2) = 1
-- or id%2 = 1
-- or id%2
and description != 'boring'
order by rating desc

def not_boring_movies(cinema: pd.DataFrame) -> pd.DataFrame:
    df = cinema[
        (cinema["id"] % 2 == 1) &
        (~cinema["description"].str.contains("boring"))
    ]
    return df.sort_values(by="rating", ascending=False)