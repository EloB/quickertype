from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Cookies:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Cookies':
        assert isinstance(obj, dict)
        return Cookies()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TopLevel:
    cookies: Cookies

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        cookies = Cookies.from_dict(obj["cookies"])
        return TopLevel(cookies)

    def to_dict(self) -> dict:
        result: dict = {}
        result["cookies"] = to_class(Cookies, self.cookies)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
