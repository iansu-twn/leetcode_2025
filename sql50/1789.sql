select employee_id, department_id
from employee e
where primary_flag = 'Y'
union
select employee_id, department_id
from employee e
where employee_id in (
    select employee_id
    from employee e
    group by employee_id
    having count(*) = 1
)
order by employee_id

select employee_id, department_id
from employee 
where primary_flag='Y' 
or employee_id in (
    select employee_id
    from employee
    group by employee_id
    having count(*) = 1
)

def find_primary_department(employee: pd.DataFrame) -> pd.DataFrame:
    single = employee.groupby("employee_id").size().reset_index(name="size")
    single = single[
        single["size"] == 1
    ]["employee_id"].to_list()
    single = employee.query("employee_id.isin(@single)")[["employee_id", "department_id"]]
    
    multi = employee[
        employee["primary_flag"] == "Y"
    ][["employee_id", "department_id"]]
    return pd.concat([single, multi])