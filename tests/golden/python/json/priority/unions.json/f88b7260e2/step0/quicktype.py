from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class ZClass:
    a: bool

    @staticmethod
    def from_dict(obj: Any) -> 'ZClass':
        assert isinstance(obj, dict)
        a = from_bool(obj["a"])
        return ZClass(a)

    def to_dict(self) -> dict:
        result: dict = {}
        result["a"] = from_bool(self.a)
        return result


@dataclass
class TopLevel:
    x: list[int | str | None]
    y: list[int | None]
    z: list[list[int] | ZClass | int]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        x = from_list(lambda x: from_union([from_int, from_none, from_str], x), obj["x"])
        y = from_list(lambda x: from_union([from_int, from_none], x), obj["y"])
        z = from_list(lambda x: from_union([lambda x: from_list(from_int, x), ZClass.from_dict, from_int], x), obj["z"])
        return TopLevel(x, y, z)

    def to_dict(self) -> dict:
        result: dict = {}
        result["x"] = from_list(lambda x: from_union([from_int, from_none, from_str], x), self.x)
        result["y"] = from_list(lambda x: from_union([from_int, from_none], x), self.y)
        result["z"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(ZClass, x), from_int], x), self.z)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
