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
class Cookie:
    name: str
    value: str

    @staticmethod
    def from_dict(obj: Any) -> 'Cookie':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        value = from_str(obj["value"])
        return Cookie(name, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        result["value"] = from_str(self.value)
        return result


@dataclass
class TopLevel:
    cookies: list[Cookie]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        cookies = from_list(Cookie.from_dict, obj["cookies"])
        return TopLevel(cookies)

    def to_dict(self) -> dict:
        result: dict = {}
        result["cookies"] = from_list(lambda x: to_class(Cookie, x), self.cookies)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
