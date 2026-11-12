from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    bar: int
    foo: int
    quux: bool

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        bar = from_int(obj["bar"])
        foo = from_int(obj["foo"])
        quux = from_bool(obj["quux"])
        return TopLevel(bar, foo, quux)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bar"] = from_int(self.bar)
        result["foo"] = from_int(self.foo)
        result["quux"] = from_bool(self.quux)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
