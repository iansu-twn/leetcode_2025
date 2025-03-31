select distinct email
from person
group by email
having count(*) > 1

def duplicate_emails(person: pd.DataFrame) -> pd.DataFrame:
    person = person.groupby("email").size().reset_index(name="count")
    return person.query("count > 1")[["email"]]