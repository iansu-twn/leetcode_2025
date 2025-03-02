select project_id, round(ey/person, 2) average_years
from (
    select p.project_id, count(p.employee_id) person, sum(experience_years) ey 
    from project p
    join employee e
    on p.employee_id = e.employee_id
    group by p.project_id
)t

select p.project_id, round(avg(e.experience_years), 2) average_years
from project p
left join employee e
on e.employee_id = p.employee_id
group by p.project_id

def project_employees_i(project: pd.DataFrame, employee: pd.DataFrame) -> pd.DataFrame:
    df = project.merge(
        employee, 
        how="inner",
        on="employee_id"
    )
    -- method 1
    df = df.groupby("project_id").agg(
        size=("employee_id", "size"),
        years=("experience_years", "sum")
    ).reset_index()
    df["average_years"] = round(df["years"]/df["size"], 2).fillna(0)
    return df[["project_id", "average_years"]]

    -- method 2
    df = df.groupby("project_id")["experience_years"].mean().round(2).reset_index(name="average_years")
    return df