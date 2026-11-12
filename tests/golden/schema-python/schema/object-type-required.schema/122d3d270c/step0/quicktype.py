from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Empty:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Empty':
        assert isinstance(obj, dict)
        return Empty()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TopLevel:
    empty: Empty
    foo: str
    bar: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        empty = Empty.from_dict(obj["empty"])
        foo = from_str(obj["foo"])
        bar = from_union([from_str, from_none], obj.get("bar"))
        return TopLevel(empty, foo, bar)

    def to_dict(self) -> dict:
        result: dict = {}
        result["empty"] = to_class(Empty, self.empty)
        result["foo"] = from_str(self.foo)
        if self.bar is not None:
            result["bar"] = from_union([from_str, from_none], self.bar)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
