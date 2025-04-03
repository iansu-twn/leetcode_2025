select employee_id
from employees
where employee_id not in (
    select employee_id
    from salaries
)
union
select employee_id
from salaries
where employee_id not in (
    select employee_id
    from employees
)
order by employee_id

import pandas as pd

def find_employees(employees: pd.DataFrame, salaries: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    employees_id = employees["employee_id"].to_list()
    salaries_id = salaries["employee_id"].to_list()
    eid = set(employees_id) - set(salaries_id)
    sid = set(salaries_id) - set(employees_id)
    val = sorted(list(eid.union(sid)))
    return pd.DataFrame({"employee_id": val})

    -- method 2
    val = sorted(set(employees.employee_id) ^ set(salaries.employee_id))
    return pd.DataFrame({"employee_id": val})