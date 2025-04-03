with latest as (
    select student_id, subject, score latest_score, exam_date l_exam_date
    from (
        select student_id, subject, score, exam_date, 
        row_number () over (partition by student_id, subject order by exam_date desc) rn
        from scores
    )t
    where rn = 1
),
first as (
    select student_id, subject, score first_score, exam_date f_exam_date
    from (
        select student_id, subject, score, exam_date, 
        row_number () over (partition by student_id, subject order by exam_date) rn
        from scores
    )t
    where rn = 1
)
select student_id, subject, first_score, latest_score
from latest l
join first f
using (student_id, subject)
where latest_score > first_score
and l_exam_date > f_exam_date

import pandas as pd

def find_students_who_improved(scores: pd.DataFrame) -> pd.DataFrame:
    df = scores.sort_values(["student_id", "subject", "exam_date"])
    df = df.groupby(["student_id", "subject"]).agg(
        first_score=("score", "first"),
        latest_score=("score", "last")
    ).reset_index()
    return df[df.latest_score > df.first_score]