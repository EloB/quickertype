from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


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
class Constructor:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Constructor':
        assert isinstance(obj, dict)
        return Constructor()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TopLevel:
    constructor: float | Constructor | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        constructor = from_union([from_float, Constructor.from_dict, from_none], obj.get("constructor"))
        return TopLevel(constructor)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.constructor is not None:
            result["constructor"] = from_union([to_float, lambda x: to_class(Constructor, x), from_none], self.constructor)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
