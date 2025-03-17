select patient_id, patient_name, conditions
from patients
where conditions regexp '^DIAB1| DIAB1'

def find_patients(patients: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    patients = patients[
        (patients["conditions"].str.startswith("DIAB1"))|
        (patients["conditions"].str.contains(" DIAB1"))
    ]

    -- method 2
    patients = patients[
        patients["conditions"].str.contains(r'\bDIAB1')
    ]
    return patients