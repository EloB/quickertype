from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_none(x: Any) -> Any:
    assert x is None
    return x


class Code(Enum):
    SF = "sf"


class English(Enum):
    SF = "SF"


class Thai(Enum):
    เอสเอฟ = "เอสเอฟ"


@dataclass
class Group:
    code: Code
    english: English
    thai: Thai
    website: str

    @staticmethod
    def from_dict(obj: Any) -> 'Group':
        assert isinstance(obj, dict)
        code = Code(obj["code"])
        english = English(obj["english"])
        thai = Thai(obj["thai"])
        website = from_str(obj["website"])
        return Group(code, english, thai, website)

    def to_dict(self) -> dict:
        result: dict = {}
        result["code"] = to_enum(Code, self.code)
        result["english"] = to_enum(English, self.english)
        result["thai"] = to_enum(Thai, self.thai)
        result["website"] = from_str(self.website)
        return result


class Location(Enum):
    EMPTY = ""
    THE_5_TH_FL_EMPORIUM = "5th Fl. Emporium"


class Tel(Enum):
    EMPTY = ""
    THE_022688899 = "02-268-8899"


@dataclass
class Result:
    code: int
    english: str
    fav: bool
    group: Group
    location: Location
    min_screens: int
    num_views: int
    showtimes: str
    stars: int
    tel: Tel
    thai: str
    today_screens: int
    url: str
    website: str

    @staticmethod
    def from_dict(obj: Any) -> 'Result':
        assert isinstance(obj, dict)
        code = int(from_str(obj["code"]))
        english = from_str(obj["english"])
        fav = from_bool(obj["fav"])
        group = Group.from_dict(obj["group"])
        location = Location(obj["location"])
        min_screens = from_int(obj["min_screens"])
        num_views = from_int(obj["num_views"])
        showtimes = from_str(obj["showtimes"])
        stars = from_int(obj["stars"])
        tel = Tel(obj["tel"])
        thai = from_str(obj["thai"])
        today_screens = from_int(obj["today_screens"])
        url = from_str(obj["url"])
        website = from_str(obj["website"])
        return Result(code, english, fav, group, location, min_screens, num_views, showtimes, stars, tel, thai, today_screens, url, website)

    def to_dict(self) -> dict:
        result: dict = {}
        result["code"] = from_str(str(self.code))
        result["english"] = from_str(self.english)
        result["fav"] = from_bool(self.fav)
        result["group"] = to_class(Group, self.group)
        result["location"] = to_enum(Location, self.location)
        result["min_screens"] = from_int(self.min_screens)
        result["num_views"] = from_int(self.num_views)
        result["showtimes"] = from_str(self.showtimes)
        result["stars"] = from_int(self.stars)
        result["tel"] = to_enum(Tel, self.tel)
        result["thai"] = from_str(self.thai)
        result["today_screens"] = from_int(self.today_screens)
        result["url"] = from_str(self.url)
        result["website"] = from_str(self.website)
        return result


@dataclass
class TopLevel:
    count: int
    next: str
    results: list[Result]
    previous: None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        count = from_int(obj["count"])
        next = from_str(obj["next"])
        results = from_list(Result.from_dict, obj["results"])
        previous = from_none(obj["previous"])
        return TopLevel(count, next, results, previous)

    def to_dict(self) -> dict:
        result: dict = {}
        result["count"] = from_int(self.count)
        result["next"] = from_str(self.next)
        result["results"] = from_list(lambda x: to_class(Result, x), self.results)
        result["previous"] = from_none(self.previous)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
