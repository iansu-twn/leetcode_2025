select sample_id, dna_sequence, species,
case when dna_sequence regexp '^ATG' then 1 else 0 end as has_start,
case when dna_sequence regexp 'TAA$|TAG$|TGA$' then 1 else 0 end as has_stop, -- or (TAA|TAG|TGA)$
case when dna_sequence regexp 'ATAT' then 1 else 0 end as has_atat,
case when dna_sequence regexp 'G{3}' then 1 else 0 end as has_ggg
from samples

import pandas as pd

def analyze_dna_patterns(samples: pd.DataFrame) -> pd.DataFrame:
    samples["has_start"] = samples["dna_sequence"].apply(
        lambda row: 1 if row.startswith("ATG") else 0
    )
    samples["has_stop"] = samples["dna_sequence"].apply(
        lambda row: 1 if row.endswith(('TAA','TAG','TGA')) else 0
    )
    samples["has_atat"] = samples["dna_sequence"].apply(
        lambda row: 1 if "ATAT" in row else 0
    )
    samples["has_ggg"] = samples["dna_sequence"].apply(
        lambda row: 1 if "GGG" in row else 0
    )
    return samples

    samples = samples.assign(
        has_start = samples.dna_sequence.str.startswith("ATG"),
        has_stop = samples.dna_sequence.str.endswith(('TAA','TAG','TGA')),
        has_atat = samples.dna_sequence.str.contains("ATAT"),
        has_ggg = samples.dna_sequence.str.contains("GGG")
    )
    return samples