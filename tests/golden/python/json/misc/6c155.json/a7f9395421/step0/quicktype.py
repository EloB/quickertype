from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable
from uuid import UUID


T = TypeVar("T")


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


def from_none(x: Any) -> Any:
    assert x is None
    return x


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


@dataclass
class Component:
    name: str
    uuid: UUID

    @staticmethod
    def from_dict(obj: Any) -> 'Component':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        uuid = UUID(obj["uuid"])
        return Component(name, uuid)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        result["uuid"] = str(self.uuid)
        return result


@dataclass
class Location:
    administrative_area: str
    country: str
    fax_number: str
    locality: str
    mobile_number: str
    phone_number: str
    phone_number_extension: str
    postal_code: str
    thoroughfare: str
    sub_premise: None

    @staticmethod
    def from_dict(obj: Any) -> 'Location':
        assert isinstance(obj, dict)
        administrative_area = from_str(obj["administrative_area"])
        country = from_str(obj["country"])
        fax_number = from_str(obj["fax_number"])
        locality = from_str(obj["locality"])
        mobile_number = from_str(obj["mobile_number"])
        phone_number = from_str(obj["phone_number"])
        phone_number_extension = from_str(obj["phone_number_extension"])
        postal_code = from_str(obj["postal_code"])
        thoroughfare = from_str(obj["thoroughfare"])
        sub_premise = from_none(obj["sub_premise"])
        return Location(administrative_area, country, fax_number, locality, mobile_number, phone_number, phone_number_extension, postal_code, thoroughfare, sub_premise)

    def to_dict(self) -> dict:
        result: dict = {}
        result["administrative_area"] = from_str(self.administrative_area)
        result["country"] = from_str(self.country)
        result["fax_number"] = from_str(self.fax_number)
        result["locality"] = from_str(self.locality)
        result["mobile_number"] = from_str(self.mobile_number)
        result["phone_number"] = from_str(self.phone_number)
        result["phone_number_extension"] = from_str(self.phone_number_extension)
        result["postal_code"] = from_str(self.postal_code)
        result["thoroughfare"] = from_str(self.thoroughfare)
        result["sub_premise"] = from_none(self.sub_premise)
        return result


@dataclass
class Result:
    attachment: list[Any]
    body: str
    changed: int
    component: list[Component]
    created: int
    date: int
    image: list[Any]
    location: Location
    title: str
    topic: list[Any]
    url: str
    uuid: UUID
    vuuid: UUID
    teaser: None

    @staticmethod
    def from_dict(obj: Any) -> 'Result':
        assert isinstance(obj, dict)
        attachment = from_list(lambda x: x, obj["attachment"])
        body = from_str(obj["body"])
        changed = int(from_str(obj["changed"]))
        component = from_list(Component.from_dict, obj["component"])
        created = int(from_str(obj["created"]))
        date = int(from_str(obj["date"]))
        image = from_list(lambda x: x, obj["image"])
        location = Location.from_dict(obj["location"])
        title = from_str(obj["title"])
        topic = from_list(lambda x: x, obj["topic"])
        url = from_str(obj["url"])
        uuid = UUID(obj["uuid"])
        vuuid = UUID(obj["vuuid"])
        teaser = from_none(obj["teaser"])
        return Result(attachment, body, changed, component, created, date, image, location, title, topic, url, uuid, vuuid, teaser)

    def to_dict(self) -> dict:
        result: dict = {}
        result["attachment"] = from_list(lambda x: x, self.attachment)
        result["body"] = from_str(self.body)
        result["changed"] = from_str(str(self.changed))
        result["component"] = from_list(lambda x: to_class(Component, x), self.component)
        result["created"] = from_str(str(self.created))
        result["date"] = from_str(str(self.date))
        result["image"] = from_list(lambda x: x, self.image)
        result["location"] = to_class(Location, self.location)
        result["title"] = from_str(self.title)
        result["topic"] = from_list(lambda x: x, self.topic)
        result["url"] = from_str(self.url)
        result["uuid"] = str(self.uuid)
        result["vuuid"] = str(self.vuuid)
        result["teaser"] = from_none(self.teaser)
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
