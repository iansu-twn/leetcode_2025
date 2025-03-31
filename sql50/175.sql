select firstname, lastname, city, state
from person p
left join address a
on a.personid = p.personid

def combine_two_tables(person: pd.DataFrame, address: pd.DataFrame) -> pd.DataFrame:
    df = person.merge(
        address,
        how="left", 
        on="personId"
    )[["firstName", "lastName", "city", "state"]]
    return df