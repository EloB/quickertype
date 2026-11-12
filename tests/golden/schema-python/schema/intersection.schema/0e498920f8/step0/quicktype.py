from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


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


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Intersection:
    foo: float
    bar: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Intersection':
        assert isinstance(obj, dict)
        foo = from_float(obj["foo"])
        bar = from_union([from_str, from_none], obj.get("bar"))
        return Intersection(foo, bar)

    def to_dict(self) -> dict:
        result: dict = {}
        result["foo"] = to_float(self.foo)
        if self.bar is not None:
            result["bar"] = from_union([from_str, from_none], self.bar)
        return result


@dataclass
class TopLevel:
    intersection: Intersection | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        intersection = from_union([Intersection.from_dict, from_none], obj.get("intersection"))
        return TopLevel(intersection)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.intersection is not None:
            result["intersection"] = from_union([lambda x: to_class(Intersection, x), from_none], self.intersection)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
