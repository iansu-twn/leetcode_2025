select class
from courses
group by class
having count(*) >= 5

def find_classes(courses: pd.DataFrame) -> pd.DataFrame:
    df = courses.groupby("class")["student"].size().reset_index()
    df = df[
        df["student"] >= 5
    ]
    return df[["class"]]