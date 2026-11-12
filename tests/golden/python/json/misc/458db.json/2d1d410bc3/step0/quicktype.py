from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable
from enum import Enum
from uuid import UUID


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


@dataclass
class ResponseInfo:
    developer_message: str
    status: int

    @staticmethod
    def from_dict(obj: Any) -> 'ResponseInfo':
        assert isinstance(obj, dict)
        developer_message = from_str(obj["developerMessage"])
        status = from_int(obj["status"])
        return ResponseInfo(developer_message, status)

    def to_dict(self) -> dict:
        result: dict = {}
        result["developerMessage"] = from_str(self.developer_message)
        result["status"] = from_int(self.status)
        return result


@dataclass
class Resultset:
    count: int
    page: int
    pagesize: int

    @staticmethod
    def from_dict(obj: Any) -> 'Resultset':
        assert isinstance(obj, dict)
        count = from_int(obj["count"])
        page = from_int(obj["page"])
        pagesize = from_int(obj["pagesize"])
        return Resultset(count, page, pagesize)

    def to_dict(self) -> dict:
        result: dict = {}
        result["count"] = from_int(self.count)
        result["page"] = from_int(self.page)
        result["pagesize"] = from_int(self.pagesize)
        return result


@dataclass
class Metadata:
    execution_time: float
    response_info: ResponseInfo
    resultset: Resultset

    @staticmethod
    def from_dict(obj: Any) -> 'Metadata':
        assert isinstance(obj, dict)
        execution_time = from_float(obj["executionTime"])
        response_info = ResponseInfo.from_dict(obj["responseInfo"])
        resultset = Resultset.from_dict(obj["resultset"])
        return Metadata(execution_time, response_info, resultset)

    def to_dict(self) -> dict:
        result: dict = {}
        result["executionTime"] = to_float(self.execution_time)
        result["responseInfo"] = to_class(ResponseInfo, self.response_info)
        result["resultset"] = to_class(Resultset, self.resultset)
        return result


class Name(Enum):
    OFFICE_ON_VIOLENCE_AGAINST_WOMEN = "Office on Violence Against Women"


@dataclass
class Component:
    name: Name
    uuid: UUID

    @staticmethod
    def from_dict(obj: Any) -> 'Component':
        assert isinstance(obj, dict)
        name = Name(obj["name"])
        uuid = UUID(obj["uuid"])
        return Component(name, uuid)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = to_enum(Name, self.name)
        result["uuid"] = str(self.uuid)
        return result


@dataclass
class Result:
    attachments: list[Any]
    body: str
    changed: int
    component: list[Component]
    created: int
    date: str
    image: list[Any]
    teaser: list[Any]
    title: str
    topic: list[Any]
    url: str
    uuid: UUID
    vuuid: UUID

    @staticmethod
    def from_dict(obj: Any) -> 'Result':
        assert isinstance(obj, dict)
        attachments = from_list(lambda x: x, obj["attachments"])
        body = from_str(obj["body"])
        changed = int(from_str(obj["changed"]))
        component = from_list(Component.from_dict, obj["component"])
        created = int(from_str(obj["created"]))
        date = from_str(obj["date"])
        image = from_list(lambda x: x, obj["image"])
        teaser = from_list(lambda x: x, obj["teaser"])
        title = from_str(obj["title"])
        topic = from_list(lambda x: x, obj["topic"])
        url = from_str(obj["url"])
        uuid = UUID(obj["uuid"])
        vuuid = UUID(obj["vuuid"])
        return Result(attachments, body, changed, component, created, date, image, teaser, title, topic, url, uuid, vuuid)

    def to_dict(self) -> dict:
        result: dict = {}
        result["attachments"] = from_list(lambda x: x, self.attachments)
        result["body"] = from_str(self.body)
        result["changed"] = from_str(str(self.changed))
        result["component"] = from_list(lambda x: to_class(Component, x), self.component)
        result["created"] = from_str(str(self.created))
        result["date"] = from_str(self.date)
        result["image"] = from_list(lambda x: x, self.image)
        result["teaser"] = from_list(lambda x: x, self.teaser)
        result["title"] = from_str(self.title)
        result["topic"] = from_list(lambda x: x, self.topic)
        result["url"] = from_str(self.url)
        result["uuid"] = str(self.uuid)
        result["vuuid"] = str(self.vuuid)
        return result


@dataclass
class TopLevel:
    metadata: Metadata
    results: list[Result]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        metadata = Metadata.from_dict(obj["metadata"])
        results = from_list(Result.from_dict, obj["results"])
        return TopLevel(metadata, results)

    def to_dict(self) -> dict:
        result: dict = {}
        result["metadata"] = to_class(Metadata, self.metadata)
        result["results"] = from_list(lambda x: to_class(Result, x), self.results)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
