select 
    a.machine_id,
    round(avg(b.timestamp-a.timestamp), 3) processing_time
from activity a
join activity b
on a.machine_id = b.machine_id
and a.process_id = b.process_id
where a.activity_type = 'start'
and b.activity_type = 'end' 
group by a.machine_id

def get_average_time(activity: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    df = activity.merge(
        activity,
        how="inner",
        on=["machine_id", "process_id"],
        suffixes=["_a", "_b"]
    )
    df = df[
        (df["activity_type_a"] == "start") &
        (df["activity_type_b"] == "end")
    ].pipe(
        lambda df: df.assign(
            dif=df.timestamp_b-df.timestamp_a
        )
    )
    df = df.groupby(
        "machine_id",
        as_index=False
    ).agg({
        "dif": np.average -- or can use "dif": "mean"
    }).round(3).rename(
        columns={"dif": "processing_time"}
    )
    return df

    -- nethod 2
    -- using pivot table
    df = activity.pivot(
        index=["machine_id", "process_id"],
        columns="activity_type",
        values="timestamp"
    )
    df["processing_time"] = df["end"]-df["start"]
    df = df.groupby(
        "machine_id",
    ).processing_time.mean().round(3).reset_index()
    return df
