select teacher_id, count(distinct subject_id) cnt
from teacher
group by teacher_id

def count_unique_subjects(teacher: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    df = teacher.groupby("teacher_id").agg({
        "subject_id": "nunique"
    }).reset_index().rename(columns={"subject_id": "cnt"})
    return df

    -- method 2
    df = teacher.groupby("teacher_id").agg(
        cnt=("subject_id", "nunique")
    ).reset_index()
    return df