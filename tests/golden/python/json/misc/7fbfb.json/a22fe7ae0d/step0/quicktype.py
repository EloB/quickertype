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
    CN = "CN"
    NY_GDP_MKTP_CD = "NY.GDP.MKTP.CD"


class Value(Enum):
    CHINA = "China"
    GDP_CURRENT_US = "GDP (current US$)"


@dataclass
class Country:
    id: ID
    value: Value

    @staticmethod
    def from_dict(obj: Any) -> 'Country':
        assert isinstance(obj, dict)
        id = ID(obj["id"])
        value = Value(obj["value"])
        return Country(id, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = to_enum(ID, self.id)
        result["value"] = to_enum(Value, self.value)
        return result


@dataclass
class PurpleTopLevel:
    country: Country
    date: int
    decimal: int
    indicator: Country
    value: str

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleTopLevel':
        assert isinstance(obj, dict)
        country = Country.from_dict(obj["country"])
        date = int(from_str(obj["date"]))
        decimal = int(from_str(obj["decimal"]))
        indicator = Country.from_dict(obj["indicator"])
        value = from_str(obj["value"])
        return PurpleTopLevel(country, date, decimal, indicator, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["country"] = to_class(Country, self.country)
        result["date"] = from_str(str(self.date))
        result["decimal"] = from_str(str(self.decimal))
        result["indicator"] = to_class(Country, self.indicator)
        result["value"] = from_str(self.value)
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
