import datetime
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast
from enum import Enum
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


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


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
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
    ACTIVE = "active"
    INACTIVE = "inactive"


@dataclass
class Result:
    activity_consult_committees: str
    activity_eu_legislative: str
    activity_expert_groups: str
    activity_high_level_groups: str
    activity_industry_forums: str
    activity_inter_groups: str
    activity_relevant_comm: str
    code_of_conduct: str
    contact_country: int
    created_at: datetime.datetime
    entity: str
    goals: str
    head: str
    head_office_country: str
    head_office_phone: str
    head_office_street: str
    head_office_town: str
    id: str
    identification_code: str
    info_members: str
    last_update_date: datetime.datetime
    legal: str
    legal_status: str
    main_category: int
    main_category_title: str
    members: int
    members_fte: float
    name: str
    registration_date: datetime.datetime
    status: Status
    structure_members: str
    sub_category: int
    sub_category_title: str
    updated_at: datetime.datetime
    uri: str
    acronym: str | None
    activity_other: str | None
    be_office_country: str | None
    be_office_lat: float | None
    be_office_lon: float | None
    be_office_phone: str | None
    be_office_post_code: int | None
    be_office_postbox: int | None
    be_office_street: str | None
    be_office_town: str | None
    head_office_lat: float | None
    head_office_lon: float | None
    head_office_post_code: str | None
    head_office_postbox: str | None
    members_100: int | None
    members_25: int | None
    members_50: int | None
    members_75: int | None
    native_name: None
    networking: str | None
    number_of_natural_persons: int | None
    other_code_of_conduct: str | None
    web_site_url: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Result':
        assert isinstance(obj, dict)
        activity_consult_committees = from_str(obj["activity_consult_committees"])
        activity_eu_legislative = from_str(obj["activity_eu_legislative"])
        activity_expert_groups = from_str(obj["activity_expert_groups"])
        activity_high_level_groups = from_str(obj["activity_high_level_groups"])
        activity_industry_forums = from_str(obj["activity_industry_forums"])
        activity_inter_groups = from_str(obj["activity_inter_groups"])
        activity_relevant_comm = from_str(obj["activity_relevant_comm"])
        code_of_conduct = from_str(obj["code_of_conduct"])
        contact_country = from_int(obj["contact_country"])
        created_at = from_datetime(obj["created_at"])
        entity = from_str(obj["entity"])
        goals = from_str(obj["goals"])
        head = from_str(obj["head"])
        head_office_country = from_str(obj["head_office_country"])
        head_office_phone = from_str(obj["head_office_phone"])
        head_office_street = from_str(obj["head_office_street"])
        head_office_town = from_str(obj["head_office_town"])
        id = from_str(obj["id"])
        identification_code = from_str(obj["identification_code"])
        info_members = from_str(obj["info_members"])
        last_update_date = from_datetime(obj["last_update_date"])
        legal = from_str(obj["legal"])
        legal_status = from_str(obj["legal_status"])
        main_category = from_int(obj["main_category"])
        main_category_title = from_str(obj["main_category_title"])
        members = from_int(obj["members"])
        members_fte = from_float(obj["members_fte"])
        name = from_str(obj["name"])
        registration_date = from_datetime(obj["registration_date"])
        status = Status(obj["status"])
        structure_members = from_str(obj["structure_members"])
        sub_category = from_int(obj["sub_category"])
        sub_category_title = from_str(obj["sub_category_title"])
        updated_at = from_datetime(obj["updated_at"])
        uri = from_str(obj["uri"])
        acronym = from_union([from_none, from_str], obj["acronym"])
        activity_other = from_union([from_none, from_str], obj["activity_other"])
        be_office_country = from_union([from_none, from_str], obj.get("be_office_country"))
        be_office_lat = from_union([from_float, from_none], obj.get("be_office_lat"))
        be_office_lon = from_union([from_float, from_none], obj.get("be_office_lon"))
        be_office_phone = from_union([from_none, from_str], obj.get("be_office_phone"))
        be_office_post_code = from_union([from_none, lambda x: int(from_str(x))], obj.get("be_office_post_code"))
        be_office_postbox = from_union([from_none, lambda x: int(from_str(x))], obj.get("be_office_postbox"))
        be_office_street = from_union([from_none, from_str], obj.get("be_office_street"))
        be_office_town = from_union([from_none, from_str], obj.get("be_office_town"))
        head_office_lat = from_union([from_float, from_none], obj["head_office_lat"])
        head_office_lon = from_union([from_float, from_none], obj["head_office_lon"])
        head_office_post_code = from_union([from_none, from_str], obj["head_office_post_code"])
        head_office_postbox = from_union([from_none, from_str], obj["head_office_postbox"])
        members_100 = from_union([from_int, from_none], obj["members_100"])
        members_25 = from_union([from_int, from_none], obj["members_25"])
        members_50 = from_union([from_int, from_none], obj["members_50"])
        members_75 = from_union([from_int, from_none], obj["members_75"])
        native_name = from_none(obj["native_name"])
        networking = from_union([from_none, from_str], obj["networking"])
        number_of_natural_persons = from_union([from_int, from_none], obj["number_of_natural_persons"])
        other_code_of_conduct = from_union([from_none, from_str], obj["other_code_of_conduct"])
        web_site_url = from_union([from_none, from_str], obj["web_site_url"])
        return Result(activity_consult_committees, activity_eu_legislative, activity_expert_groups, activity_high_level_groups, activity_industry_forums, activity_inter_groups, activity_relevant_comm, code_of_conduct, contact_country, created_at, entity, goals, head, head_office_country, head_office_phone, head_office_street, head_office_town, id, identification_code, info_members, last_update_date, legal, legal_status, main_category, main_category_title, members, members_fte, name, registration_date, status, structure_members, sub_category, sub_category_title, updated_at, uri, acronym, activity_other, be_office_country, be_office_lat, be_office_lon, be_office_phone, be_office_post_code, be_office_postbox, be_office_street, be_office_town, head_office_lat, head_office_lon, head_office_post_code, head_office_postbox, members_100, members_25, members_50, members_75, native_name, networking, number_of_natural_persons, other_code_of_conduct, web_site_url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["activity_consult_committees"] = from_str(self.activity_consult_committees)
        result["activity_eu_legislative"] = from_str(self.activity_eu_legislative)
        result["activity_expert_groups"] = from_str(self.activity_expert_groups)
        result["activity_high_level_groups"] = from_str(self.activity_high_level_groups)
        result["activity_industry_forums"] = from_str(self.activity_industry_forums)
        result["activity_inter_groups"] = from_str(self.activity_inter_groups)
        result["activity_relevant_comm"] = from_str(self.activity_relevant_comm)
        result["code_of_conduct"] = from_str(self.code_of_conduct)
        result["contact_country"] = from_int(self.contact_country)
        result["created_at"] = self.created_at.isoformat()
        result["entity"] = from_str(self.entity)
        result["goals"] = from_str(self.goals)
        result["head"] = from_str(self.head)
        result["head_office_country"] = from_str(self.head_office_country)
        result["head_office_phone"] = from_str(self.head_office_phone)
        result["head_office_street"] = from_str(self.head_office_street)
        result["head_office_town"] = from_str(self.head_office_town)
        result["id"] = from_str(self.id)
        result["identification_code"] = from_str(self.identification_code)
        result["info_members"] = from_str(self.info_members)
        result["last_update_date"] = self.last_update_date.isoformat()
        result["legal"] = from_str(self.legal)
        result["legal_status"] = from_str(self.legal_status)
        result["main_category"] = from_int(self.main_category)
        result["main_category_title"] = from_str(self.main_category_title)
        result["members"] = from_int(self.members)
        result["members_fte"] = to_float(self.members_fte)
        result["name"] = from_str(self.name)
        result["registration_date"] = self.registration_date.isoformat()
        result["status"] = to_enum(Status, self.status)
        result["structure_members"] = from_str(self.structure_members)
        result["sub_category"] = from_int(self.sub_category)
        result["sub_category_title"] = from_str(self.sub_category_title)
        result["updated_at"] = self.updated_at.isoformat()
        result["uri"] = from_str(self.uri)
        result["acronym"] = from_union([from_none, from_str], self.acronym)
        result["activity_other"] = from_union([from_none, from_str], self.activity_other)
        if self.be_office_country is not None:
            result["be_office_country"] = from_union([from_none, from_str], self.be_office_country)
        if self.be_office_lat is not None:
            result["be_office_lat"] = from_union([to_float, from_none], self.be_office_lat)
        if self.be_office_lon is not None:
            result["be_office_lon"] = from_union([to_float, from_none], self.be_office_lon)
        if self.be_office_phone is not None:
            result["be_office_phone"] = from_union([from_none, from_str], self.be_office_phone)
        if self.be_office_post_code is not None:
            result["be_office_post_code"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.be_office_post_code)
        if self.be_office_postbox is not None:
            result["be_office_postbox"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.be_office_postbox)
        if self.be_office_street is not None:
            result["be_office_street"] = from_union([from_none, from_str], self.be_office_street)
        if self.be_office_town is not None:
            result["be_office_town"] = from_union([from_none, from_str], self.be_office_town)
        result["head_office_lat"] = from_union([to_float, from_none], self.head_office_lat)
        result["head_office_lon"] = from_union([to_float, from_none], self.head_office_lon)
        result["head_office_post_code"] = from_union([from_none, from_str], self.head_office_post_code)
        result["head_office_postbox"] = from_union([from_none, from_str], self.head_office_postbox)
        result["members_100"] = from_union([from_int, from_none], self.members_100)
        result["members_25"] = from_union([from_int, from_none], self.members_25)
        result["members_50"] = from_union([from_int, from_none], self.members_50)
        result["members_75"] = from_union([from_int, from_none], self.members_75)
        result["native_name"] = from_none(self.native_name)
        result["networking"] = from_union([from_none, from_str], self.networking)
        result["number_of_natural_persons"] = from_union([from_int, from_none], self.number_of_natural_persons)
        result["other_code_of_conduct"] = from_union([from_none, from_str], self.other_code_of_conduct)
        result["web_site_url"] = from_union([from_none, from_str], self.web_site_url)
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
