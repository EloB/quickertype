from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
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


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    foo: int
    bar: bool | None = None
    quux: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        foo = from_int(obj["foo"])
        bar = from_union([from_bool, from_none], obj.get("bar"))
        quux = from_union([from_str, from_none], obj.get("quux"))
        return TopLevel(foo, bar, quux)

    def to_dict(self) -> dict:
        result: dict = {}
        result["foo"] = from_int(self.foo)
        if self.bar is not None:
            result["bar"] = from_union([from_bool, from_none], self.bar)
        if self.quux is not None:
            result["quux"] = from_union([from_str, from_none], self.quux)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
