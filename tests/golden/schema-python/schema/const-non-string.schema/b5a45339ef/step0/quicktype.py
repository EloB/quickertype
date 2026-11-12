from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Kind(Enum):
    WIDGET = "widget"


@dataclass
class TopLevel:
    amount: int
    enabled: bool
    kind: Kind
    ratio: float
    version: float

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        amount = from_int(obj["amount"])
        enabled = from_bool(obj["enabled"])
        kind = Kind(obj["kind"])
        ratio = from_float(obj["ratio"])
        version = from_float(obj["version"])
        return TopLevel(amount, enabled, kind, ratio, version)

    def to_dict(self) -> dict:
        result: dict = {}
        result["amount"] = from_int(self.amount)
        result["enabled"] = from_bool(self.enabled)
        result["kind"] = to_enum(Kind, self.kind)
        result["ratio"] = to_float(self.ratio)
        result["version"] = to_float(self.version)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
