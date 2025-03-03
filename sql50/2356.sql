select teacher_id, count(distinct subject_id) cnt
from teacher
group by teacher_id

df = teacher.groupby("teacher_id").agg({
        "subject_id": "nunique"
    }).reset_index().rename(columns={"subject_id": "cnt"})
    return df