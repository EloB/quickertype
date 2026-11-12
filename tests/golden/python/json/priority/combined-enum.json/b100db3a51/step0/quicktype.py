from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class X(Enum):
    THREE = "three"
    ONE = "one"
    TWO = "two"


@dataclass
class Bar:
    x: X

    @staticmethod
    def from_dict(obj: Any) -> 'Bar':
        assert isinstance(obj, dict)
        x = X(obj["x"])
        return Bar(x)

    def to_dict(self) -> dict:
        result: dict = {}
        result["x"] = to_enum(X, self.x)
        return result


@dataclass
class TopLevel:
    bar: list[Bar]
    foo: list[Bar]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        bar = from_list(Bar.from_dict, obj["bar"])
        foo = from_list(Bar.from_dict, obj["foo"])
        return TopLevel(bar, foo)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bar"] = from_list(lambda x: to_class(Bar, x), self.bar)
        result["foo"] = from_list(lambda x: to_class(Bar, x), self.foo)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
