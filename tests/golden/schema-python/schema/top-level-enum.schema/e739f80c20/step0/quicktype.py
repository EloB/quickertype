from enum import Enum
from typing import Any, TypeVar, Type


EnumT = TypeVar("EnumT", bound=Enum)


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


class TopLevel(Enum):
    ONE = "one"
    THREE = "three"
    TWO = "two"


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_enum(TopLevel, x)
