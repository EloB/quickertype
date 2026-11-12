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
class BoolInUnion:
    a: bool

    @staticmethod
    def from_dict(obj: Any) -> 'BoolInUnion':
        assert isinstance(obj, dict)
        a = from_bool(obj["a"])
        return BoolInUnion(a)

    def to_dict(self) -> dict:
        result: dict = {}
        result["a"] = from_bool(self.a)
        return result


@dataclass
class TopLevel:
    bool_in_union: BoolInUnion
    union: list[bool | int]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        bool_in_union = BoolInUnion.from_dict(obj["BoolInUnion"])
        union = from_list(lambda x: from_union([from_bool, from_int], x), obj["union"])
        return TopLevel(bool_in_union, union)

    def to_dict(self) -> dict:
        result: dict = {}
        result["BoolInUnion"] = to_class(BoolInUnion, self.bool_in_union)
        result["union"] = from_list(lambda x: from_union([from_bool, from_int], x), self.union)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
