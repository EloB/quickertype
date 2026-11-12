import datetime
import re
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast
import dateutil.parser


T = TypeVar("T")


def from_date(x: Any) -> datetime.date:
    assert isinstance(x, str) and re.match(r"^\d{4}-\d{2}-\d{2}$", x)
    return dateutil.parser.parse(x).date()


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


def from_time(x: Any) -> datetime.time:
    assert isinstance(x, str) and re.match(r"^\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})?$", x)
    return dateutil.parser.parse(x).timetz()


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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    required_date: datetime.date
    required_date_time: datetime.datetime
    required_time: datetime.time
    optional_date: datetime.date | None = None
    optional_date_time: datetime.datetime | None = None
    optional_time: datetime.time | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        required_date = from_date(obj["required-date"])
        required_date_time = from_datetime(obj["required-date-time"])
        required_time = from_time(obj["required-time"])
        optional_date = from_union([from_date, from_none], obj.get("optional-date"))
        optional_date_time = from_union([from_datetime, from_none], obj.get("optional-date-time"))
        optional_time = from_union([from_time, from_none], obj.get("optional-time"))
        return TopLevel(required_date, required_date_time, required_time, optional_date, optional_date_time, optional_time)

    def to_dict(self) -> dict:
        result: dict = {}
        result["required-date"] = self.required_date.isoformat()
        result["required-date-time"] = self.required_date_time.isoformat()
        result["required-time"] = self.required_time.isoformat()
        if self.optional_date is not None:
            result["optional-date"] = from_union([lambda x: x.isoformat(), from_none], self.optional_date)
        if self.optional_date_time is not None:
            result["optional-date-time"] = from_union([lambda x: x.isoformat(), from_none], self.optional_date_time)
        if self.optional_time is not None:
            result["optional-time"] = from_union([lambda x: x.isoformat(), from_none], self.optional_time)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
