select distinct l1.num as ConsecutiveNums
from logs l1
join logs l2
on l1.id = l2.id-1
join logs l3
on l2.id = l3.id-1
where l1.num = l2.num
and l2.num = l3.num

import pandas as pd
def consecutive_numbers(logs: pd.DataFrame) -> pd.DataFrame:
    lis = logs["num"].to_list()
    output = set()
    for i in range(len(lis)-2):
        if lis[i] == lis[i+1] == lis[i+2]:
            output.add(lis[i])
            i += 3
    return pd.DataFrame(data={"ConsecutiveNums": sorted(output)})