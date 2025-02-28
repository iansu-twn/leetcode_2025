select name, bonus
from employee e
left join bonus b
on e.empid = b.empid
where bonus is null or bonus < 1000

df = employee.merge(
        bonus,
        how="left",
        on="empId"
    )
    df = df[
        (df["bonus"].isna()) |
        (df["bonus"] < 1000)
    ]
    return df[["name", "bonus"]]