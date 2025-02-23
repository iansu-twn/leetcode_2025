select name, population, area
from world
where area >= 3000000
or population >= 25000000

def big_countries(world: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    return world[
            (world["area"] >= 3000000)|
            (world["population"] >= 25000000)
        ][["name", "population", "area"]]

    -- method 2
    return world.loc[
        (world["area"] >= 3000000)|
        (world["population"] >= 25000000)
    ][["name", "population", "area"]]
    
    -- method 3
    return world.query("area >= 3000000 or population >= 25000000")[["name", "population", "area"]]