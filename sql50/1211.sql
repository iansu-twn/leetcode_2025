select query_name,
round(avg(rating/position), 2) quality,
round(sum(case when rating < 3 then 1 else 0 end)/count(*) * 100, 2) poor_query_percentage
from queries
group by query_name

def queries_stats(queries: pd.DataFrame) -> pd.DataFrame:
    queries["quality"] = queries["rating"] / queries["position"]+ 1e-10
    queries["score"] = queries.apply(
        lambda x: 1 if x.rating < 3 else 0, axis=1
    )
    df = queries.groupby("query_name").agg(
        quality=("quality", lambda x: x.mean().round(2)),
        poor_query_percentage=("score", lambda x: (x.mean()*100).round(2))
    ).reset_index()
    return df[["query_name", "quality", "poor_query_percentage"]]