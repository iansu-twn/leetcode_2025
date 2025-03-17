select user_id,
concat(upper(substring(name, 1, 1)), lower(substring(name, 2, length(name)-1))) name
from users
order by user_id

def fix_names(users: pd.DataFrame) -> pd.DataFrame:
    users["name"] = users["name"].str.capitalize()
    return users.sort_values("user_id", ascending=True)