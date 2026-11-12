from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


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


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


@dataclass
class UnionListClass:
    next: 'UnionListClass | float'

    @staticmethod
    def from_dict(obj: Any) -> 'UnionListClass':
        assert isinstance(obj, dict)
        next = from_union([UnionListClass.from_dict, from_float], obj["next"])
        return UnionListClass(next)

    def to_dict(self) -> dict:
        result: dict = {}
        result["next"] = from_union([lambda x: to_class(UnionListClass, x), to_float], self.next)
        return result


@dataclass
class TopLevel:
    list: UnionListClass | float

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        list = from_union([UnionListClass.from_dict, from_float], obj["list"])
        return TopLevel(list)

    def to_dict(self) -> dict:
        result: dict = {}
        result["list"] = from_union([lambda x: to_class(UnionListClass, x), to_float], self.list)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
