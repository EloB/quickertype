from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Country(Enum):
    UNITED_STATES = "United States"


@dataclass
class TopLevelElement:
    age: int
    country: Country
    females: int
    males: int
    total: int
    year: int

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        age = from_int(obj["age"])
        country = Country(obj["country"])
        females = from_int(obj["females"])
        males = from_int(obj["males"])
        total = from_int(obj["total"])
        year = from_int(obj["year"])
        return TopLevelElement(age, country, females, males, total, year)

    def to_dict(self) -> dict:
        result: dict = {}
        result["age"] = from_int(self.age)
        result["country"] = to_enum(Country, self.country)
        result["females"] = from_int(self.females)
        result["males"] = from_int(self.males)
        result["total"] = from_int(self.total)
        result["year"] = from_int(self.year)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
