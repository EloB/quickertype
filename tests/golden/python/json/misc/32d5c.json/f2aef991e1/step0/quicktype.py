import datetime
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
import dateutil.parser


T = TypeVar("T")


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


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


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevelElement:
    birth_date_is_protected: bool
    gender_type_id: int
    notes: str
    parliamentary_name: str
    person_id: int
    photo_url: str
    preferred_name: str
    birth_date: datetime.datetime | None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        birth_date_is_protected = from_bool(obj["BirthDateIsProtected"])
        gender_type_id = from_int(obj["GenderTypeID"])
        notes = from_str(obj["Notes"])
        parliamentary_name = from_str(obj["ParliamentaryName"])
        person_id = from_int(obj["PersonID"])
        photo_url = from_str(obj["PhotoURL"])
        preferred_name = from_str(obj["PreferredName"])
        birth_date = from_union([from_datetime, from_none], obj["BirthDate"])
        return TopLevelElement(birth_date_is_protected, gender_type_id, notes, parliamentary_name, person_id, photo_url, preferred_name, birth_date)

    def to_dict(self) -> dict:
        result: dict = {}
        result["BirthDateIsProtected"] = from_bool(self.birth_date_is_protected)
        result["GenderTypeID"] = from_int(self.gender_type_id)
        result["Notes"] = from_str(self.notes)
        result["ParliamentaryName"] = from_str(self.parliamentary_name)
        result["PersonID"] = from_int(self.person_id)
        result["PhotoURL"] = from_str(self.photo_url)
        result["PreferredName"] = from_str(self.preferred_name)
        result["BirthDate"] = from_union([lambda x: x.isoformat(), from_none], self.birth_date)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
