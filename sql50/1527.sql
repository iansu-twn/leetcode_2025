select patient_id, patient_name, conditions
from patients
where conditions regexp '^DIAB1| DIAB1'

def find_patients(patients: pd.DataFrame) -> pd.DataFrame:
    patients = patients[
        (patients["conditions"].str.startswith("DIAB1"))|
        (patients["conditions"].str.contains(" DIAB1"))
    ]
    return patients