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


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    birthday: datetime.date
    last_seen: datetime.datetime
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        birthday = from_date(obj["birthday"])
        last_seen = from_datetime(obj["lastSeen"])
        name = from_str(obj["name"])
        return TopLevel(birthday, last_seen, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["birthday"] = self.birthday.isoformat()
        result["lastSeen"] = self.last_seen.isoformat()
        result["name"] = from_str(self.name)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
