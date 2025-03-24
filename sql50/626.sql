select 
    case 
        when id % 2 and id != (select max(id) from seat) then id + 1 
        when id % 2 = 0 then id - 1 
        else id
    end as id, 
    student
from seat
order by id

def exchange_seats(seat: pd.DataFrame) -> pd.DataFrame:
    big = len(seat)
    seat["id"] = seat["id"].apply(
        lambda x: x+1 if (x%2 and x != big) else (x-1 if x%2==0 else x)
    )
    return seat.sort_values("id")

    -- method 2
    return seat.assign(
        student = np.where(seat.id%2 & (seat.id == len(seat)), seat.student,
        np.where(seat.id%2, seat.student.shift(-1), seat.student.shift(1)))
    )