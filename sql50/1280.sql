select s.student_id, s.student_name,
sub.subject_name, count(e.student_id) as attended_exams
from students s
cross join subjects sub
left join examinations e
on e.student_id = s.student_id
and e.subject_name = sub.subject_name
group by s.student_id, s.student_name, sub.subject_name
order by s.student_id, sub.subject_name

select s.student_id, s.student_name,
sub.subject_name, coalesce(t.attended_exams, 0) attended_exams
from students s
cross join subjects sub
left join (
    select student_id, subject_name, count(*) as attended_exams
    from examinations
    group by student_id, subject_name
)t using (student_id, subject_name)
order by s.student_id, sub.subject_name

def students_and_examinations(students: pd.DataFrame, subjects: pd.DataFrame, examinations: pd.DataFrame) -> pd.DataFrame:
    df = students.merge(
        subjects,
        how="cross"
    )
    test = examinations.groupby(["student_id", "subject_name"]).size().reset_index(name="attended_exams")
    df = df.merge(
        test,
        how="left",
        on=["student_id", "subject_name"]
    ).fillna({"attended_exams":0})
    return df.sort_values(by=["student_id", "subject_name"])