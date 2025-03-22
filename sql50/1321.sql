select visited_on,
(
    select sum(amount) from customer
    where visited_on between date_sub(c.visited_on, interval 6 day) and c.visited_on
) amount,
round(
    (
        select sum(amount)/7 from customer
        where visited_on between date_sub(c.visited_on, interval 6 day) and c.visited_on
    ), 2
) average_amount
from customer c
where visited_on >= (
    select date_add(min(visited_on), interval 6 day)
    from customer 
)
group by visited_on


ef restaurant_growth(customer: pd.DataFrame) -> pd.DataFrame:
    customer = customer.groupby("visited_on").amount.sum().reset_index()
    customer["amount"] = customer.amount.rolling(window=7).sum()
    customer["average_amount"] = round(customer["amount"]/7, 2)
    return customer[["visited_on", "amount", "average_amount"]].dropna().sort_values("visited_on")