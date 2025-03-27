select 
    date_id, make_name, count(distinct lead_id) unique_leads, count(distinct partner_id) unique_partners
from dailysales
group by date_id, make_name

def daily_leads_and_partners(daily_sales: pd.DataFrame) -> pd.DataFrame:
    return daily_sales.groupby(["date_id", "make_name"]).agg(
        unique_leads=("lead_id", "nunique"),
        unique_partners=("partner_id", "nunique")
    ).reset_index()