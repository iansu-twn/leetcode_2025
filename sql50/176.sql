select 
    case when (select count(*) from employee) != 1  then (
    select salary
    from employee
    where salary != (
        select max(salary)
        from employee
    )
    order by salary desc
    limit 1
) else null end as SecondHighestSalary

select (
    select distinct salary
    from employee
    order by salary desc
    limit 1
    offset 1
) as SecondHighestSalary

select max(salary) SecondHighestSalary
from employee
where salary < (
    select max(salary)
    from employee
)

def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    employee = employee.salary.drop_duplicates(keep='first').sort_values(ascending=False)
    val = None if len(employee) < 2 else employee.iloc[1]
    return pd.DataFrame({"SecondHighestSalary": [val]})