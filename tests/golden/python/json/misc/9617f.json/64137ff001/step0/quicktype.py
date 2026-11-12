import datetime
import re
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
import dateutil.parser


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_date(x: Any) -> datetime.date:
    assert isinstance(x, str) and re.match(r"^\d{4}-\d{2}-\d{2}$", x)
    return dateutil.parser.parse(x).date()


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    base: str
    date: datetime.date
    rates: dict[str, float]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        base = from_str(obj["base"])
        date = from_date(obj["date"])
        rates = from_dict(from_float, obj["rates"])
        return TopLevel(base, date, rates)

    def to_dict(self) -> dict:
        result: dict = {}
        result["base"] = from_str(self.base)
        result["date"] = self.date.isoformat()
        result["rates"] = from_dict(to_float, self.rates)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
