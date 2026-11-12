from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


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


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Kind(Enum):
    ONE = "one"
    TWO = "two"


@dataclass
class TopLevel:
    kind: Kind
    b: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        kind = Kind(obj["kind"])
        b = from_union([from_none, from_str], obj.get("b"))
        return TopLevel(kind, b)

    def to_dict(self) -> dict:
        result: dict = {}
        result["kind"] = to_enum(Kind, self.kind)
        if self.b is not None:
            result["b"] = from_union([from_none, from_str], self.b)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
