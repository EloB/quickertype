from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


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


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class EnumEnum(Enum):
    FOO = "foo"
    BAR = "bar"


@dataclass
class TopLevel:
    enum: EnumEnum | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        enum = from_union([from_none, EnumEnum], obj["enum"])
        return TopLevel(enum)

    def to_dict(self) -> dict:
        result: dict = {}
        result["enum"] = from_union([from_none, lambda x: to_enum(EnumEnum, x)], self.enum)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
