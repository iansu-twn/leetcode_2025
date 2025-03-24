select "Low Salary" as category, count(account_id) accounts_count
from accounts
where income < 20000
union
select "Average Salary" as category, count(account_id) accounts_count
from accounts
where income >= 20000 and income <= 50000
union
select "High Salary" as category, count(account_id) accounts_count
from accounts
where income > 50000

def count_salary_categories(accounts: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    low_salary = len(accounts[
        accounts["income"] < 20000
    ])
    average_salary = len(accounts[
        (accounts["income"] >= 20000) &
        (accounts["income"] <= 50000) 
    ])
    high_salary = len(accounts[
        accounts["income"] > 50000
    ])

    -- method 2
    low_salary = accounts[
        accounts["income"] < 20000
    ].shape[0]
    high_salary = accounts[
        accounts["income"] > 50000
    ].shape[0]
    average_salary = accounts.shape[0] - low_salary - high_salary

    return pd.DataFrame({
        "category": ["High Salary", "Average Salary", "Low Salary"],
        "accounts_count": [high_salary, average_salary, low_salary]
    })

    -- method 3, use swe way
    income = accounts.income
    res = [0] * 3
    for i in income:
        if i < 20000:
            res[0] += 1
        elif i > 50000:
            res[2] += 1
        else:
            res[1] += 1
    return pd.DataFrame(data={
        "category": ["Low Salary", "Average Salary", "High Salary"],
        "accounts_count": res
    })
