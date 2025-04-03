select user_id, email
from users
where email regexp '^[0-9A-Za-z_]*@[A-Za-z]*.com$'

import pandas as pd

def find_valid_emails(users: pd.DataFrame) -> pd.DataFrame:
    pattern = r"^[0-9A-Za-z_]+@[A-Za-z]+\.com$"
    filtered_df = users[users["email"].str.match(pattern, na=False)]
    return filtered_df