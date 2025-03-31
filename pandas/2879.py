import pandas as pd

def selectFirstRows(employees: pd.DataFrame) -> pd.DataFrame:
    # method 1: head function
    return employees.head(3)

    # method 2: list slicing
    return employees[:3]

    # method 3: iloc function
    return employees.iloc[:3, :]
    