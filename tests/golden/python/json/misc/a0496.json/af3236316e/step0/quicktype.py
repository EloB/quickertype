import datetime
import re
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
import dateutil.parser


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_date(x: Any) -> datetime.date:
    assert isinstance(x, str) and re.match(r"^\d{4}-\d{2}-\d{2}$", x)
    return dateutil.parser.parse(x).date()


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


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Errors:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Errors':
        assert isinstance(obj, dict)
        return Errors()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TopLevel:
    code: str
    column_names: list[str]
    data: list[list[datetime.date | float | None]]
    description: str
    display_url: str
    errors: Errors
    frequency: str
    from_date: datetime.date
    id: int
    name: str
    premium: bool
    source_code: str
    source_name: str
    to_date: datetime.date
    type: str
    updated_at: datetime.datetime
    urlize_name: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        code = from_str(obj["code"])
        column_names = from_list(from_str, obj["column_names"])
        data = from_list(lambda x: from_list(lambda x: from_union([from_date, from_float, from_none], x), x), obj["data"])
        description = from_str(obj["description"])
        display_url = from_str(obj["display_url"])
        errors = Errors.from_dict(obj["errors"])
        frequency = from_str(obj["frequency"])
        from_date = from_date(obj["from_date"])
        id = from_int(obj["id"])
        name = from_str(obj["name"])
        premium = from_bool(obj["premium"])
        source_code = from_str(obj["source_code"])
        source_name = from_str(obj["source_name"])
        to_date = from_date(obj["to_date"])
        type = from_str(obj["type"])
        updated_at = from_datetime(obj["updated_at"])
        urlize_name = from_str(obj["urlize_name"])
        return TopLevel(code, column_names, data, description, display_url, errors, frequency, from_date, id, name, premium, source_code, source_name, to_date, type, updated_at, urlize_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["code"] = from_str(self.code)
        result["column_names"] = from_list(from_str, self.column_names)
        result["data"] = from_list(lambda x: from_list(lambda x: from_union([lambda x: x.isoformat(), to_float, from_none], x), x), self.data)
        result["description"] = from_str(self.description)
        result["display_url"] = from_str(self.display_url)
        result["errors"] = to_class(Errors, self.errors)
        result["frequency"] = from_str(self.frequency)
        result["from_date"] = self.from_date.isoformat()
        result["id"] = from_int(self.id)
        result["name"] = from_str(self.name)
        result["premium"] = from_bool(self.premium)
        result["source_code"] = from_str(self.source_code)
        result["source_name"] = from_str(self.source_name)
        result["to_date"] = self.to_date.isoformat()
        result["type"] = from_str(self.type)
        result["updated_at"] = self.updated_at.isoformat()
        result["urlize_name"] = from_str(self.urlize_name)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
