select employee_id
from employees e
where salary < 30000
and manager_id not in (
    select employee_id
    from employees
)
order by employee_id

def find_employees(employees: pd.DataFrame) -> pd.DataFrame:
    df = employees[
        (employees["salary"] < 30000)
    ]
    lis = employees["employee_id"].to_list()
    df = df.query("~manager_id.isin(@lis) and ~manager_id.isna()")
    return df[["employee_id"]].sort_values("employee_id")