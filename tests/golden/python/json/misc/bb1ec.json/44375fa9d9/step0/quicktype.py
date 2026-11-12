import datetime
import re
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
import dateutil.parser


T = TypeVar("T")


def from_date(x: Any) -> datetime.date:
    assert isinstance(x, str) and re.match(r"^\d{4}-\d{2}-\d{2}$", x)
    return dateutil.parser.parse(x).date()


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TotalPopulation:
    date: datetime.date
    population: int

    @staticmethod
    def from_dict(obj: Any) -> 'TotalPopulation':
        assert isinstance(obj, dict)
        date = from_date(obj["date"])
        population = from_int(obj["population"])
        return TotalPopulation(date, population)

    def to_dict(self) -> dict:
        result: dict = {}
        result["date"] = self.date.isoformat()
        result["population"] = from_int(self.population)
        return result


@dataclass
class TopLevel:
    total_population: list[TotalPopulation]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        total_population = from_list(TotalPopulation.from_dict, obj["total_population"])
        return TopLevel(total_population)

    def to_dict(self) -> dict:
        result: dict = {}
        result["total_population"] = from_list(lambda x: to_class(TotalPopulation, x), self.total_population)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
