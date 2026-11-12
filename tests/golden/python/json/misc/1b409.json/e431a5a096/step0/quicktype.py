import datetime
import re
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast
from enum import Enum
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


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


def from_date(x: Any) -> datetime.date:
    assert isinstance(x, str) and re.match(r"^\d{4}-\d{2}-\d{2}$", x)
    return dateutil.parser.parse(x).date()


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Meta:
    limit: int
    offset: int
    total_count: int

    @staticmethod
    def from_dict(obj: Any) -> 'Meta':
        assert isinstance(obj, dict)
        limit = from_int(obj["limit"])
        offset = from_int(obj["offset"])
        total_count = from_int(obj["total_count"])
        return Meta(limit, offset, total_count)

    def to_dict(self) -> dict:
        result: dict = {}
        result["limit"] = from_int(self.limit)
        result["offset"] = from_int(self.offset)
        result["total_count"] = from_int(self.total_count)
        return result


@dataclass
class Extra:
    address: str
    office: str
    contact_form: str | None
    fax: str | None
    rss_url: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Extra':
        assert isinstance(obj, dict)
        address = from_str(obj["address"])
        office = from_str(obj["office"])
        contact_form = from_union([from_none, from_str], obj.get("contact_form"))
        fax = from_union([from_none, from_str], obj.get("fax"))
        rss_url = from_union([from_none, from_str], obj.get("rss_url"))
        return Extra(address, office, contact_form, fax, rss_url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["address"] = from_str(self.address)
        result["office"] = from_str(self.office)
        if self.contact_form is not None:
            result["contact_form"] = from_union([from_none, from_str], self.contact_form)
        if self.fax is not None:
            result["fax"] = from_union([from_none, from_str], self.fax)
        if self.rss_url is not None:
            result["rss_url"] = from_union([from_none, from_str], self.rss_url)
        return result


class Party(Enum):
    REPUBLICAN = "Republican"
    DEMOCRAT = "Democrat"


class Gender(Enum):
    MALE = "male"
    FEMALE = "female"


class GenderLabel(Enum):
    MALE = "Male"
    FEMALE = "Female"


class Namemod(Enum):
    EMPTY = ""
    JR = "Jr."
    II = "II"
    III = "III"
    IV = "IV"


@dataclass
class Person:
    bioguideid: str
    birthday: datetime.date
    cspanid: int
    firstname: str
    gender: Gender
    gender_label: GenderLabel
    id: int
    lastname: str
    link: str
    middlename: str
    name: str
    namemod: Namemod
    nickname: str
    osid: str
    sortname: str
    pvsid: int | None
    twitterid: str | None
    youtubeid: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Person':
        assert isinstance(obj, dict)
        bioguideid = from_str(obj["bioguideid"])
        birthday = from_date(obj["birthday"])
        cspanid = from_int(obj["cspanid"])
        firstname = from_str(obj["firstname"])
        gender = Gender(obj["gender"])
        gender_label = GenderLabel(obj["gender_label"])
        id = from_int(obj["id"])
        lastname = from_str(obj["lastname"])
        link = from_str(obj["link"])
        middlename = from_str(obj["middlename"])
        name = from_str(obj["name"])
        namemod = Namemod(obj["namemod"])
        nickname = from_str(obj["nickname"])
        osid = from_str(obj["osid"])
        sortname = from_str(obj["sortname"])
        pvsid = from_union([from_none, lambda x: int(from_str(x))], obj["pvsid"])
        twitterid = from_union([from_none, from_str], obj["twitterid"])
        youtubeid = from_union([from_none, from_str], obj["youtubeid"])
        return Person(bioguideid, birthday, cspanid, firstname, gender, gender_label, id, lastname, link, middlename, name, namemod, nickname, osid, sortname, pvsid, twitterid, youtubeid)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bioguideid"] = from_str(self.bioguideid)
        result["birthday"] = self.birthday.isoformat()
        result["cspanid"] = from_int(self.cspanid)
        result["firstname"] = from_str(self.firstname)
        result["gender"] = to_enum(Gender, self.gender)
        result["gender_label"] = to_enum(GenderLabel, self.gender_label)
        result["id"] = from_int(self.id)
        result["lastname"] = from_str(self.lastname)
        result["link"] = from_str(self.link)
        result["middlename"] = from_str(self.middlename)
        result["name"] = from_str(self.name)
        result["namemod"] = to_enum(Namemod, self.namemod)
        result["nickname"] = from_str(self.nickname)
        result["osid"] = from_str(self.osid)
        result["sortname"] = from_str(self.sortname)
        result["pvsid"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.pvsid)
        result["twitterid"] = from_union([from_none, from_str], self.twitterid)
        result["youtubeid"] = from_union([from_none, from_str], self.youtubeid)
        return result


class RoleType(Enum):
    REPRESENTATIVE = "representative"


class RoleTypeLabel(Enum):
    REPRESENTATIVE = "Representative"
    DELEGATE = "Delegate"
    RESIDENT_COMMISSIONER = "Resident Commissioner"


class Title(Enum):
    REP = "Rep."
    COMMISH = "Commish."


@dataclass
class Object:
    congress_numbers: list[int]
    current: bool
    description: str
    district: int
    enddate: datetime.date
    extra: Extra
    id: int
    party: Party
    person: Person
    phone: str
    role_type: RoleType
    role_type_label: RoleTypeLabel
    startdate: datetime.date
    state: str
    title: Title
    title_long: RoleTypeLabel
    website: str
    caucus: None
    leadership_title: str | None
    senator_class: None
    senator_rank: None

    @staticmethod
    def from_dict(obj: Any) -> 'Object':
        assert isinstance(obj, dict)
        congress_numbers = from_list(from_int, obj["congress_numbers"])
        current = from_bool(obj["current"])
        description = from_str(obj["description"])
        district = from_int(obj["district"])
        enddate = from_date(obj["enddate"])
        extra = Extra.from_dict(obj["extra"])
        id = from_int(obj["id"])
        party = Party(obj["party"])
        person = Person.from_dict(obj["person"])
        phone = from_str(obj["phone"])
        role_type = RoleType(obj["role_type"])
        role_type_label = RoleTypeLabel(obj["role_type_label"])
        startdate = from_date(obj["startdate"])
        state = from_str(obj["state"])
        title = Title(obj["title"])
        title_long = RoleTypeLabel(obj["title_long"])
        website = from_str(obj["website"])
        caucus = from_none(obj["caucus"])
        leadership_title = from_union([from_none, from_str], obj["leadership_title"])
        senator_class = from_none(obj["senator_class"])
        senator_rank = from_none(obj["senator_rank"])
        return Object(congress_numbers, current, description, district, enddate, extra, id, party, person, phone, role_type, role_type_label, startdate, state, title, title_long, website, caucus, leadership_title, senator_class, senator_rank)

    def to_dict(self) -> dict:
        result: dict = {}
        result["congress_numbers"] = from_list(from_int, self.congress_numbers)
        result["current"] = from_bool(self.current)
        result["description"] = from_str(self.description)
        result["district"] = from_int(self.district)
        result["enddate"] = self.enddate.isoformat()
        result["extra"] = to_class(Extra, self.extra)
        result["id"] = from_int(self.id)
        result["party"] = to_enum(Party, self.party)
        result["person"] = to_class(Person, self.person)
        result["phone"] = from_str(self.phone)
        result["role_type"] = to_enum(RoleType, self.role_type)
        result["role_type_label"] = to_enum(RoleTypeLabel, self.role_type_label)
        result["startdate"] = self.startdate.isoformat()
        result["state"] = from_str(self.state)
        result["title"] = to_enum(Title, self.title)
        result["title_long"] = to_enum(RoleTypeLabel, self.title_long)
        result["website"] = from_str(self.website)
        result["caucus"] = from_none(self.caucus)
        result["leadership_title"] = from_union([from_none, from_str], self.leadership_title)
        result["senator_class"] = from_none(self.senator_class)
        result["senator_rank"] = from_none(self.senator_rank)
        return result


@dataclass
class TopLevel:
    meta: Meta
    objects: list[Object]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        meta = Meta.from_dict(obj["meta"])
        objects = from_list(Object.from_dict, obj["objects"])
        return TopLevel(meta, objects)

    def to_dict(self) -> dict:
        result: dict = {}
        result["meta"] = to_class(Meta, self.meta)
        result["objects"] = from_list(lambda x: to_class(Object, x), self.objects)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
