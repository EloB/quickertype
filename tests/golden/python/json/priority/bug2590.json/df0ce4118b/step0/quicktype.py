import datetime
import re
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
import dateutil.parser


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


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


def from_date(x: Any) -> datetime.date:
    assert isinstance(x, str) and re.match(r"^\d{4}-\d{2}-\d{2}$", x)
    return dateutil.parser.parse(x).date()


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Invoice:
    name: str
    created_at: datetime.datetime | None
    due_date: datetime.date | None

    @staticmethod
    def from_dict(obj: Any) -> 'Invoice':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        created_at = from_union([from_datetime, from_none], obj["createdAt"])
        due_date = from_union([from_date, from_none], obj["dueDate"])
        return Invoice(name, created_at, due_date)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        result["createdAt"] = from_union([lambda x: x.isoformat(), from_none], self.created_at)
        result["dueDate"] = from_union([lambda x: x.isoformat(), from_none], self.due_date)
        return result


@dataclass
class TopLevel:
    invoices: list[Invoice]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        invoices = from_list(Invoice.from_dict, obj["invoices"])
        return TopLevel(invoices)

    def to_dict(self) -> dict:
        result: dict = {}
        result["invoices"] = from_list(lambda x: to_class(Invoice, x), self.invoices)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
