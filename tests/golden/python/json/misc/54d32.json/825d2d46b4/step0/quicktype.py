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


@dataclass
class Result:
    created_at: datetime.datetime
    id: str
    person_id: str
    representative_id: str
    status: Status
    updated_at: datetime.datetime

    @staticmethod
    def from_dict(obj: Any) -> 'Result':
        assert isinstance(obj, dict)
        created_at = from_datetime(obj["created_at"])
        id = from_str(obj["id"])
        person_id = from_str(obj["person_id"])
        representative_id = from_str(obj["representative_id"])
        status = Status(obj["status"])
        updated_at = from_datetime(obj["updated_at"])
        return Result(created_at, id, person_id, representative_id, status, updated_at)

    def to_dict(self) -> dict:
        result: dict = {}
        result["created_at"] = self.created_at.isoformat()
        result["id"] = from_str(self.id)
        result["person_id"] = from_str(self.person_id)
        result["representative_id"] = from_str(self.representative_id)
        result["status"] = to_enum(Status, self.status)
        result["updated_at"] = self.updated_at.isoformat()
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
