select employee_id,
case
    when employee_id % 2 and name not regexp '^M' then salary
    else 0
end as bonus
from employees
order by employee_id

def calculate_special_bonus(employees: pd.DataFrame) -> pd.DataFrame:
    employees["bonus"] = employees.apply(
        lambda x: x.salary if x["employee_id"] % 2 and not x["name"].startswith("M") else 0,
        axis=1
    )
    return employees[["employee_id", "bonus"]].sort_values("employee_id")