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
class HiringOrg:
    name: str
    uuid: UUID

    @staticmethod
    def from_dict(obj: Any) -> 'HiringOrg':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        uuid = UUID(obj["uuid"])
        return HiringOrg(name, uuid)

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
    postal_code: int
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
        postal_code = int(from_str(obj["postal_code"]))
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
        result["postal_code"] = from_str(str(self.postal_code))
        result["thoroughfare"] = from_str(self.thoroughfare)
        result["sub_premise"] = from_none(self.sub_premise)
        return result


@dataclass
class Result:
    about_office: str
    application_process: str
    body: str
    changed: int
    created: int
    hiring_org: HiringOrg
    language: str
    location: Location
    num_positions: int
    position: str
    practice_area: str
    qualifications: str
    salary: str
    title: str
    travel: str
    url: str
    uuid: UUID
    vuuid: UUID
    deadline: None
    hiring_office: None
    job_id: None
    relocation_expenses: None

    @staticmethod
    def from_dict(obj: Any) -> 'Result':
        assert isinstance(obj, dict)
        about_office = from_str(obj["about_office"])
        application_process = from_str(obj["application_process"])
        body = from_str(obj["body"])
        changed = int(from_str(obj["changed"]))
        created = int(from_str(obj["created"]))
        hiring_org = HiringOrg.from_dict(obj["hiring_org"])
        language = from_str(obj["language"])
        location = Location.from_dict(obj["location"])
        num_positions = int(from_str(obj["num_positions"]))
        position = from_str(obj["position"])
        practice_area = from_str(obj["practice_area"])
        qualifications = from_str(obj["qualifications"])
        salary = from_str(obj["salary"])
        title = from_str(obj["title"])
        travel = from_str(obj["travel"])
        url = from_str(obj["url"])
        uuid = UUID(obj["uuid"])
        vuuid = UUID(obj["vuuid"])
        deadline = from_none(obj["deadline"])
        hiring_office = from_none(obj["hiring_office"])
        job_id = from_none(obj["job_id"])
        relocation_expenses = from_none(obj["relocation_expenses"])
        return Result(about_office, application_process, body, changed, created, hiring_org, language, location, num_positions, position, practice_area, qualifications, salary, title, travel, url, uuid, vuuid, deadline, hiring_office, job_id, relocation_expenses)

    def to_dict(self) -> dict:
        result: dict = {}
        result["about_office"] = from_str(self.about_office)
        result["application_process"] = from_str(self.application_process)
        result["body"] = from_str(self.body)
        result["changed"] = from_str(str(self.changed))
        result["created"] = from_str(str(self.created))
        result["hiring_org"] = to_class(HiringOrg, self.hiring_org)
        result["language"] = from_str(self.language)
        result["location"] = to_class(Location, self.location)
        result["num_positions"] = from_str(str(self.num_positions))
        result["position"] = from_str(self.position)
        result["practice_area"] = from_str(self.practice_area)
        result["qualifications"] = from_str(self.qualifications)
        result["salary"] = from_str(self.salary)
        result["title"] = from_str(self.title)
        result["travel"] = from_str(self.travel)
        result["url"] = from_str(self.url)
        result["uuid"] = str(self.uuid)
        result["vuuid"] = str(self.vuuid)
        result["deadline"] = from_none(self.deadline)
        result["hiring_office"] = from_none(self.hiring_office)
        result["job_id"] = from_none(self.job_id)
        result["relocation_expenses"] = from_none(self.relocation_expenses)
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
