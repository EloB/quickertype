import datetime
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast
from enum import Enum
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


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


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Facets:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Facets':
        assert isinstance(obj, dict)
        return Facets()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


class Status(Enum):
    INACTIVE = "inactive"
    ACTIVE = "active"


class Title(Enum):
    MR = "Mr"
    MS = "Ms"


@dataclass
class Result:
    created_at: datetime.datetime
    entity: str
    first_name: str
    id: str
    last_name: str
    name: str
    status: Status
    updated_at: datetime.datetime
    uri: str
    position: str | None
    title: Title | None

    @staticmethod
    def from_dict(obj: Any) -> 'Result':
        assert isinstance(obj, dict)
        created_at = from_datetime(obj["created_at"])
        entity = from_str(obj["entity"])
        first_name = from_str(obj["first_name"])
        id = from_str(obj["id"])
        last_name = from_str(obj["last_name"])
        name = from_str(obj["name"])
        status = Status(obj["status"])
        updated_at = from_datetime(obj["updated_at"])
        uri = from_str(obj["uri"])
        position = from_union([from_none, from_str], obj["position"])
        title = from_union([Title, from_none], obj["title"])
        return Result(created_at, entity, first_name, id, last_name, name, status, updated_at, uri, position, title)

    def to_dict(self) -> dict:
        result: dict = {}
        result["created_at"] = self.created_at.isoformat()
        result["entity"] = from_str(self.entity)
        result["first_name"] = from_str(self.first_name)
        result["id"] = from_str(self.id)
        result["last_name"] = from_str(self.last_name)
        result["name"] = from_str(self.name)
        result["status"] = to_enum(Status, self.status)
        result["updated_at"] = self.updated_at.isoformat()
        result["uri"] = from_str(self.uri)
        result["position"] = from_union([from_none, from_str], self.position)
        result["title"] = from_union([lambda x: to_enum(Title, x), from_none], self.title)
        return result


@dataclass
class TopLevel:
    count: int
    facets: Facets
    limit: int
    next: str
    offset: int
    previous: bool
    results: list[Result]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        count = from_int(obj["count"])
        facets = Facets.from_dict(obj["facets"])
        limit = from_int(obj["limit"])
        next = from_str(obj["next"])
        offset = from_int(obj["offset"])
        previous = from_bool(obj["previous"])
        results = from_list(Result.from_dict, obj["results"])
        return TopLevel(count, facets, limit, next, offset, previous, results)

    def to_dict(self) -> dict:
        result: dict = {}
        result["count"] = from_int(self.count)
        result["facets"] = to_class(Facets, self.facets)
        result["limit"] = from_int(self.limit)
        result["next"] = from_str(self.next)
        result["offset"] = from_int(self.offset)
        result["previous"] = from_bool(self.previous)
        result["results"] = from_list(lambda x: to_class(Result, x), self.results)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
