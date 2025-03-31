import pandas as pd

def dropMissingData(students: pd.DataFrame) -> pd.DataFrame:
    # method 1: dropna function
    return students.dropna(subset="name")

    # method 2: notna function
    return students[students.name.notna()]