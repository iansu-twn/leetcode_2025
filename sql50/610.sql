select x, y, z,
case 
    when (x + y > z) and (x + z > y) and (y + z > x) then 'Yes'
    else 'No'
end as "triangle"
from triangle

def triangle_judgement(triangle: pd.DataFrame) -> pd.DataFrame:
    triangle["triangle"] = triangle.apply(
        lambda t: "Yes" if ((t.x+t.y>t.z) & (t.y+t.z>t.x) & (t.x+t.z>t.y)) else 'No', axis=1)
    return triangle