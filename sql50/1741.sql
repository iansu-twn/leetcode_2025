select
    event_day day, emp_id,
    sum(out_time-in_time) total_time
from employees
group by event_day, emp_id

def total_time(employees: pd.DataFrame) -> pd.DataFrame:
    employees["total"] = employees["out_time"] - employees["in_time"]
    return employees.groupby(["event_day", "emp_id"]).agg(
        total_time=("total", "sum")
    ).reset_index().rename(columns={"event_day": "day"})
