select t.id employee_id, e.name, reports_count, average_age
from employees e
join (
    select reports_to id, count(reports_to) reports_count, round(avg(age)) average_age
    from employees e
    group by reports_to
)t
on e.employee_id = t.id
order by t.id

select mgr.employee_id, mgr.name, count(e.employee_id) reports_count,
round(avg(e.age)) average_age
from employees e
join employees mgr
on mgr.employee_id = e.reports_to
group by mgr.employee_id
order by mgr.employee_id

def count_employees(employees: pd.DataFrame) -> pd.DataFrame:
    df = employees.groupby("reports_to").agg(
        reports_count=("reports_to", "count"),
        average_age=("age", lambda x: (x.mean() + 1e-10).round(0))
    ).reset_index().rename(columns={"reports_to": "mgr_id"})

    df = employees.merge(
        df,
        how="inner",
        left_on="employee_id",
        right_on="mgr_id"
    )
    return df[["employee_id", "name", "reports_count", "average_age"]].sort_values("employee_id")