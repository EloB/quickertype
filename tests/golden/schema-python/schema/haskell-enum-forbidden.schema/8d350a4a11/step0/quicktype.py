from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Health(Enum):
    OK = "ok"
    ERROR = "error"


@dataclass
class TopLevel:
    health: Health

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        health = Health(obj["health"])
        return TopLevel(health)

    def to_dict(self) -> dict:
        result: dict = {}
        result["health"] = to_enum(Health, self.health)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
