select e.name Employee
from employee e
left join employee m
on e.managerId = m.id
where e.salary > m.salary

def find_employees(employee: pd.DataFrame) -> pd.DataFrame:
    df = employee.merge(
        employee,
        how="left",
        left_on="managerId",
        right_on="id",
        -- suffixes=("_employee", "_manager")
        -- .query("salary_employee > employee_manager")
    ).query("salary_x > salary_y").rename(columns={"name_x": "Employee"})
    return df[["Employee"]]