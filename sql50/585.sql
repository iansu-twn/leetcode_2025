select round(sum(tiv_2016), 2) tiv_2016
from insurance
where tiv_2015 not in (
    select tiv_2015
    from insurance
    group by tiv_2015
    having count(*) = 1
)
and (lat, lon) in (
    select lat, lon
    from insurance
    group by lat, lon
    having count(*) = 1
)

def find_investments(insurance: pd.DataFrame) -> pd.DataFrame:
    dup_tiv = insurance[
        (insurance.duplicated("tiv_2015", keep=False))
    ].pid
    uni_lat_lon = insurance.drop_duplicates(["lat", "lon"], keep=False).pid
    val = insurance[
        (insurance.pid.isin(dup_tiv)) &
        (insurance.pid.isin(uni_lat_lon))
    ].tiv_2016.sum().round(2)
    return pd.DataFrame({"tiv_2016": [val]})