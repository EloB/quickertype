from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Country:
    code: str
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'Country':
        assert isinstance(obj, dict)
        code = from_str(obj["code"])
        name = from_str(obj["name"])
        return Country(code, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["code"] = from_str(self.code)
        result["name"] = from_str(self.name)
        return result


@dataclass
class TopLevel:
    countries: list[Country]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        countries = from_list(Country.from_dict, obj["countries"])
        return TopLevel(countries)

    def to_dict(self) -> dict:
        result: dict = {}
        result["countries"] = from_list(lambda x: to_class(Country, x), self.countries)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
