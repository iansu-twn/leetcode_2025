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
        "dif": np.average
    }).round(3).rename(
        columns={"dif": "processing_time"}
    )
    return df