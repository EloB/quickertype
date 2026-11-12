from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


class ID(Enum):
    EMPTY = ""
    SAS = "SAS"
    SSA = "SSA"
    ECA = "ECA"
    LAC = "LAC"
    EAP = "EAP"
    MNA = "MNA"
    HIC = "HIC"
    LIC = "LIC"
    NA = "NA"
    LMC = "LMC"
    UMC = "UMC"
    LNX = "LNX"
    IDX = "IDX"
    IBD = "IBD"
    IDB = "IDB"
    LCN = "LCN"
    SSF = "SSF"
    ECS = "ECS"
    MEA = "MEA"
    EAS = "EAS"
    NAC = "NAC"


class Value(Enum):
    EMPTY = ""
    SOUTH_ASIA = "South Asia"
    SUB_SAHARAN_AFRICA_EXCLUDING_HIGH_INCOME = "Sub-Saharan Africa (excluding high income)"
    EUROPE_CENTRAL_ASIA_EXCLUDING_HIGH_INCOME = "Europe & Central Asia (excluding high income)"
    LATIN_AMERICA_CARIBBEAN_EXCLUDING_HIGH_INCOME = "Latin America & Caribbean (excluding high income)"
    EAST_ASIA_PACIFIC_EXCLUDING_HIGH_INCOME = "East Asia & Pacific (excluding high income)"
    MIDDLE_EAST_NORTH_AFRICA_EXCLUDING_HIGH_INCOME = "Middle East & North Africa (excluding high income)"
    HIGH_INCOME = "High income"
    LOW_INCOME = "Low income"
    AGGREGATES = "Aggregates"
    LOWER_MIDDLE_INCOME = "Lower middle income"
    UPPER_MIDDLE_INCOME = "Upper middle income"
    NOT_CLASSIFIED = "Not classified"
    IDA = "IDA"
    IBRD = "IBRD"
    BLEND = "Blend"
    LATIN_AMERICA_CARIBBEAN = "Latin America & Caribbean "
    SUB_SAHARAN_AFRICA = "Sub-Saharan Africa "
    EUROPE_CENTRAL_ASIA = "Europe & Central Asia"
    MIDDLE_EAST_NORTH_AFRICA = "Middle East & North Africa"
    EAST_ASIA_PACIFIC = "East Asia & Pacific"
    NORTH_AMERICA = "North America"


@dataclass
class Adminregion:
    id: ID
    value: Value

    @staticmethod
    def from_dict(obj: Any) -> 'Adminregion':
        assert isinstance(obj, dict)
        id = ID(obj["id"])
        value = Value(obj["value"])
        return Adminregion(id, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = to_enum(ID, self.id)
        result["value"] = to_enum(Value, self.value)
        return result


@dataclass
class PurpleTopLevel:
    adminregion: Adminregion
    capital_city: str
    id: str
    income_level: Adminregion
    iso2_code: str
    latitude: str
    lending_type: Adminregion
    longitude: str
    name: str
    region: Adminregion

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleTopLevel':
        assert isinstance(obj, dict)
        adminregion = Adminregion.from_dict(obj["adminregion"])
        capital_city = from_str(obj["capitalCity"])
        id = from_str(obj["id"])
        income_level = Adminregion.from_dict(obj["incomeLevel"])
        iso2_code = from_str(obj["iso2Code"])
        latitude = from_str(obj["latitude"])
        lending_type = Adminregion.from_dict(obj["lendingType"])
        longitude = from_str(obj["longitude"])
        name = from_str(obj["name"])
        region = Adminregion.from_dict(obj["region"])
        return PurpleTopLevel(adminregion, capital_city, id, income_level, iso2_code, latitude, lending_type, longitude, name, region)

    def to_dict(self) -> dict:
        result: dict = {}
        result["adminregion"] = to_class(Adminregion, self.adminregion)
        result["capitalCity"] = from_str(self.capital_city)
        result["id"] = from_str(self.id)
        result["incomeLevel"] = to_class(Adminregion, self.income_level)
        result["iso2Code"] = from_str(self.iso2_code)
        result["latitude"] = from_str(self.latitude)
        result["lendingType"] = to_class(Adminregion, self.lending_type)
        result["longitude"] = from_str(self.longitude)
        result["name"] = from_str(self.name)
        result["region"] = to_class(Adminregion, self.region)
        return result


@dataclass
class FluffyTopLevel:
    page: int
    pages: int
    per_page: int
    total: int

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyTopLevel':
        assert isinstance(obj, dict)
        page = from_int(obj["page"])
        pages = from_int(obj["pages"])
        per_page = int(from_str(obj["per_page"]))
        total = from_int(obj["total"])
        return FluffyTopLevel(page, pages, per_page, total)

    def to_dict(self) -> dict:
        result: dict = {}
        result["page"] = from_int(self.page)
        result["pages"] = from_int(self.pages)
        result["per_page"] = from_str(str(self.per_page))
        result["total"] = from_int(self.total)
        return result


def top_level_from_dict(s: Any) -> list[list[PurpleTopLevel] | FluffyTopLevel]:
    return from_list(lambda x: from_union([lambda x: from_list(PurpleTopLevel.from_dict, x), FluffyTopLevel.from_dict], x), s)


def top_level_to_dict(x: list[list[PurpleTopLevel] | FluffyTopLevel]) -> Any:
    return from_list(lambda x: from_union([lambda x: from_list(lambda x: to_class(PurpleTopLevel, x), x), lambda x: to_class(FluffyTopLevel, x)], x), x)
