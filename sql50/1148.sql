select distinct author_id id
from views
where author_id = viewer_id
order by id asc

def article_views(views: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    df = views[
        (views["author_id"] == views["viewer_id"])
    ][["author_id"]]
    if not df.empty:
        df = df["author_id"].unique().tolist()
        df = pd.DataFrame(data=df).sort_values(0)
        return df.rename(columns = {0: "id"})
    return pd.DataFrame(columns=["id"])

    -- method 2
    df = views.loc[views["author_id"] == views["viewer_id"], ["author_id"]].drop_duplicates().sort_values("author_id")
    df = df.rename(columns={"author_id": "id"})
    return df[["id"]]