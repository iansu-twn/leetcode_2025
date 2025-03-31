update salary
set sex = case when sex = 'm' then 'f'
else 'm' end

def swap_salary(salary: pd.DataFrame) -> pd.DataFrame:
    return salary.replace({"f": "m", "m": "f"})