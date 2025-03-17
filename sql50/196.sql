delete p1
from person p1
join person p2
on p1.email = p2.email
and pd.id > p2.id

def delete_duplicate_emails(person: pd.DataFrame) -> None:
    person.sort_values("id", inplace=True)
    person.drop_duplicates(subset=["email"], keep="first", inplace=True)