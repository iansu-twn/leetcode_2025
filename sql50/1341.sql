with fst as (
    select u.name results
    from movierating m
    join users u
    on u.user_id = m.user_id
    group by u.user_id, u.name
    order by count(*) desc, u.name
    limit 1
),
high as (
    select m.title results
    from movierating mv
    join movies m
    on m.movie_id = mv.movie_id
    where created_at >= 20200201
    and created_at < 20200301
    group by mv.movie_id
    order by avg(rating) desc, title
    limit 1
)
select * from fst
union all
select * from high

def movie_rating(movies: pd.DataFrame, users: pd.DataFrame, movie_rating: pd.DataFrame) -> pd.DataFrame:
    name = (movie_rating.merge(
        users,
        how="inner",
        on="user_id"
    )
    .groupby("name")
    .size()
    .reset_index(name="count")
    .sort_values(["count", "name"], ascending=[False, True])
    .name
    .iloc[0]
    )
    
    movie = (movie_rating.merge(
        movies, 
        how="inner",
        on="movie_id"
    )
    .query("created_at >= 20200201 and created_at < 20200301")
    .groupby("title")
    .agg({"rating": "mean"})
    .reset_index()
    .sort_values(["rating", "title"], ascending=[False, True])
    .title
    .iloc[0]
    )
    return pd.DataFrame({"results": [name, movie]})