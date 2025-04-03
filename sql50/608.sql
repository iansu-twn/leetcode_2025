select
id,
case
    when p_id is null then "Root"
    when id in (select distinct p_id from tree) then "Inner"
    else "Leaf"
end as type
from tree

import pandas as pd
def tree_node(tree: pd.DataFrame) -> pd.DataFrame:
    lis = tree["p_id"].dropna().to_list()
    tree["type"] = tree.apply(
        lambda row: "Root" if pd.isna(row["p_id"]) else ("Inner" if row["id"] in lis else "Leaf"),axis=1
    )
    return tree[["id", "type"]]