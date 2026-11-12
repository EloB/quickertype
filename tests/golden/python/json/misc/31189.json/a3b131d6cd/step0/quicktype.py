import datetime
import re
from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def from_date(x: Any) -> datetime.date:
    assert isinstance(x, str) and re.match(r"^\d{4}-\d{2}-\d{2}$", x)
    return dateutil.parser.parse(x).date()


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


class EffectiveFromEnum(Enum):
    THE_00000101 = "0000-01-01"


@dataclass
class Rates:
    standard: float
    parking: float | None
    reduced: float | None
    reduced1: float | None
    reduced2: float | None
    super_reduced: float | None

    @staticmethod
    def from_dict(obj: Any) -> 'Rates':
        assert isinstance(obj, dict)
        standard = from_float(obj["standard"])
        parking = from_union([from_float, from_none], obj.get("parking"))
        reduced = from_union([from_float, from_none], obj.get("reduced"))
        reduced1 = from_union([from_float, from_none], obj.get("reduced1"))
        reduced2 = from_union([from_float, from_none], obj.get("reduced2"))
        super_reduced = from_union([from_float, from_none], obj.get("super_reduced"))
        return Rates(standard, parking, reduced, reduced1, reduced2, super_reduced)

    def to_dict(self) -> dict:
        result: dict = {}
        result["standard"] = to_float(self.standard)
        if self.parking is not None:
            result["parking"] = from_union([to_float, from_none], self.parking)
        if self.reduced is not None:
            result["reduced"] = from_union([to_float, from_none], self.reduced)
        if self.reduced1 is not None:
            result["reduced1"] = from_union([to_float, from_none], self.reduced1)
        if self.reduced2 is not None:
            result["reduced2"] = from_union([to_float, from_none], self.reduced2)
        if self.super_reduced is not None:
            result["super_reduced"] = from_union([to_float, from_none], self.super_reduced)
        return result


@dataclass
class Period:
    effective_from: datetime.date | EffectiveFromEnum
    rates: Rates

    @staticmethod
    def from_dict(obj: Any) -> 'Period':
        assert isinstance(obj, dict)
        effective_from = from_union([from_date, EffectiveFromEnum], obj["effective_from"])
        rates = Rates.from_dict(obj["rates"])
        return Period(effective_from, rates)

    def to_dict(self) -> dict:
        result: dict = {}
        result["effective_from"] = from_union([lambda x: x.isoformat(), lambda x: to_enum(EffectiveFromEnum, x)], self.effective_from)
        result["rates"] = to_class(Rates, self.rates)
        return result


@dataclass
class Rate:
    code: str
    country_code: str
    name: str
    periods: list[Period]

    @staticmethod
    def from_dict(obj: Any) -> 'Rate':
        assert isinstance(obj, dict)
        code = from_str(obj["code"])
        country_code = from_str(obj["country_code"])
        name = from_str(obj["name"])
        periods = from_list(Period.from_dict, obj["periods"])
        return Rate(code, country_code, name, periods)

    def to_dict(self) -> dict:
        result: dict = {}
        result["code"] = from_str(self.code)
        result["country_code"] = from_str(self.country_code)
        result["name"] = from_str(self.name)
        result["periods"] = from_list(lambda x: to_class(Period, x), self.periods)
        return result


@dataclass
class TopLevel:
    details: str
    rates: list[Rate]
    version: None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        details = from_str(obj["details"])
        rates = from_list(Rate.from_dict, obj["rates"])
        version = from_none(obj["version"])
        return TopLevel(details, rates, version)

    def to_dict(self) -> dict:
        result: dict = {}
        result["details"] = from_str(self.details)
        result["rates"] = from_list(lambda x: to_class(Rate, x), self.rates)
        result["version"] = from_none(self.version)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
