import pandas as pd

def selectData(students: pd.DataFrame) -> pd.DataFrame:
    # method 1: use loc function
    return students.loc[students["student_id"] == 101][["name", "age"]]

    # method 2: use query function
    return students.query("student_id == 101")[["name", "age"]]