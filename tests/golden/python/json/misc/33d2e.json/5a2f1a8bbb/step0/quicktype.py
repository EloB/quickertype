import datetime
import re
from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
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


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


def from_date(x: Any) -> datetime.date:
    assert isinstance(x, str) and re.match(r"^\d{4}-\d{2}-\d{2}$", x)
    return dateutil.parser.parse(x).date()


class BornEnum(Enum):
    THE_00000000 = "0000-00-00"
    THE_18980000 = "1898-00-00"
    THE_19430000 = "1943-00-00"


class Gender(Enum):
    MALE = "male"
    FEMALE = "female"
    ORG = "org"


@dataclass
class AffiliationClass:
    city: str | None
    country: str | None
    name: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'AffiliationClass':
        assert isinstance(obj, dict)
        city = from_union([from_none, from_str], obj.get("city"))
        country = from_union([from_none, from_str], obj.get("country"))
        name = from_union([from_none, from_str], obj.get("name"))
        return AffiliationClass(city, country, name)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.city is not None:
            result["city"] = from_union([from_none, from_str], self.city)
        if self.country is not None:
            result["country"] = from_union([from_none, from_str], self.country)
        if self.name is not None:
            result["name"] = from_union([from_none, from_str], self.name)
        return result


class Category(Enum):
    PHYSICS = "physics"
    CHEMISTRY = "chemistry"
    PEACE = "peace"
    MEDICINE = "medicine"
    LITERATURE = "literature"
    ECONOMICS = "economics"


@dataclass
class Prize:
    affiliations: list[list[Any] | AffiliationClass]
    category: Category | None
    motivation: str | None
    overall_motivation: str | None
    share: int | None
    year: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'Prize':
        assert isinstance(obj, dict)
        affiliations = from_list(lambda x: from_union([lambda x: from_list(lambda x: x, x), AffiliationClass.from_dict], x), obj["affiliations"])
        category = from_union([Category, from_none], obj.get("category"))
        motivation = from_union([from_none, from_str], obj.get("motivation"))
        overall_motivation = from_union([from_none, from_str], obj.get("overallMotivation"))
        share = from_union([from_none, lambda x: int(from_str(x))], obj.get("share"))
        year = from_union([from_none, lambda x: int(from_str(x))], obj.get("year"))
        return Prize(affiliations, category, motivation, overall_motivation, share, year)

    def to_dict(self) -> dict:
        result: dict = {}
        result["affiliations"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: x, x), lambda x: to_class(AffiliationClass, x)], x), self.affiliations)
        if self.category is not None:
            result["category"] = from_union([lambda x: to_enum(Category, x), from_none], self.category)
        if self.motivation is not None:
            result["motivation"] = from_union([from_none, from_str], self.motivation)
        if self.overall_motivation is not None:
            result["overallMotivation"] = from_union([from_none, from_str], self.overall_motivation)
        if self.share is not None:
            result["share"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.share)
        if self.year is not None:
            result["year"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.year)
        return result


@dataclass
class Laureate:
    born: datetime.date | BornEnum
    died: datetime.date | BornEnum
    gender: Gender
    id: int
    prizes: list[Prize]
    born_city: str | None
    born_country: str | None
    born_country_code: str | None
    died_city: str | None
    died_country: str | None
    died_country_code: str | None
    firstname: str | None
    surname: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Laureate':
        assert isinstance(obj, dict)
        born = from_union([from_date, BornEnum], obj["born"])
        died = from_union([from_date, BornEnum], obj["died"])
        gender = Gender(obj["gender"])
        id = int(from_str(obj["id"]))
        prizes = from_list(Prize.from_dict, obj["prizes"])
        born_city = from_union([from_none, from_str], obj.get("bornCity"))
        born_country = from_union([from_none, from_str], obj.get("bornCountry"))
        born_country_code = from_union([from_none, from_str], obj.get("bornCountryCode"))
        died_city = from_union([from_none, from_str], obj.get("diedCity"))
        died_country = from_union([from_none, from_str], obj.get("diedCountry"))
        died_country_code = from_union([from_none, from_str], obj.get("diedCountryCode"))
        firstname = from_union([from_none, from_str], obj.get("firstname"))
        surname = from_union([from_none, from_str], obj.get("surname"))
        return Laureate(born, died, gender, id, prizes, born_city, born_country, born_country_code, died_city, died_country, died_country_code, firstname, surname)

    def to_dict(self) -> dict:
        result: dict = {}
        result["born"] = from_union([lambda x: x.isoformat(), lambda x: to_enum(BornEnum, x)], self.born)
        result["died"] = from_union([lambda x: x.isoformat(), lambda x: to_enum(BornEnum, x)], self.died)
        result["gender"] = to_enum(Gender, self.gender)
        result["id"] = from_str(str(self.id))
        result["prizes"] = from_list(lambda x: to_class(Prize, x), self.prizes)
        if self.born_city is not None:
            result["bornCity"] = from_union([from_none, from_str], self.born_city)
        if self.born_country is not None:
            result["bornCountry"] = from_union([from_none, from_str], self.born_country)
        if self.born_country_code is not None:
            result["bornCountryCode"] = from_union([from_none, from_str], self.born_country_code)
        if self.died_city is not None:
            result["diedCity"] = from_union([from_none, from_str], self.died_city)
        if self.died_country is not None:
            result["diedCountry"] = from_union([from_none, from_str], self.died_country)
        if self.died_country_code is not None:
            result["diedCountryCode"] = from_union([from_none, from_str], self.died_country_code)
        if self.firstname is not None:
            result["firstname"] = from_union([from_none, from_str], self.firstname)
        if self.surname is not None:
            result["surname"] = from_union([from_none, from_str], self.surname)
        return result


@dataclass
class TopLevel:
    laureates: list[Laureate]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        laureates = from_list(Laureate.from_dict, obj["laureates"])
        return TopLevel(laureates)

    def to_dict(self) -> dict:
        result: dict = {}
        result["laureates"] = from_list(lambda x: to_class(Laureate, x), self.laureates)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
