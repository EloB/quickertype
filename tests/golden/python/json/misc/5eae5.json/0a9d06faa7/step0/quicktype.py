import datetime
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
import dateutil.parser


T = TypeVar("T")


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevelElement:
    date: datetime.datetime
    id: int
    sponsor: str
    title: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        date = from_datetime(obj["Date"])
        id = from_int(obj["ID"])
        sponsor = from_str(obj["Sponsor"])
        title = from_str(obj["Title"])
        return TopLevelElement(date, id, sponsor, title)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Date"] = self.date.isoformat()
        result["ID"] = from_int(self.id)
        result["Sponsor"] = from_str(self.sponsor)
        result["Title"] = from_str(self.title)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
