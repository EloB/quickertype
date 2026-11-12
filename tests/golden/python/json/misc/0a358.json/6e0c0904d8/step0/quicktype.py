import datetime
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
import dateutil.parser


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


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


@dataclass
class Result:
    code: str
    created_at: datetime.datetime
    id: int
    name: str
    updated_at: datetime.datetime
    uri: str

    @staticmethod
    def from_dict(obj: Any) -> 'Result':
        assert isinstance(obj, dict)
        code = from_str(obj["code"])
        created_at = from_datetime(obj["created_at"])
        id = from_int(obj["id"])
        name = from_str(obj["name"])
        updated_at = from_datetime(obj["updated_at"])
        uri = from_str(obj["uri"])
        return Result(code, created_at, id, name, updated_at, uri)

    def to_dict(self) -> dict:
        result: dict = {}
        result["code"] = from_str(self.code)
        result["created_at"] = self.created_at.isoformat()
        result["id"] = from_int(self.id)
        result["name"] = from_str(self.name)
        result["updated_at"] = self.updated_at.isoformat()
        result["uri"] = from_str(self.uri)
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
