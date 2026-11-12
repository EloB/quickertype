from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Value(Enum):
    C0 = "c0\u0001\u001b\u001f"
    C1 = "c1\u007f\u0080\u0085\u009f"


@dataclass
class TopLevel:
    the_11: int
    literal: str
    values: list[Value]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        the_11 = from_int(obj["#{1+1}"])
        literal = from_str(obj["literal"])
        values = from_list(Value, obj["values"])
        return TopLevel(the_11, literal, values)

    def to_dict(self) -> dict:
        result: dict = {}
        result["#{1+1}"] = from_int(self.the_11)
        result["literal"] = from_str(self.literal)
        result["values"] = from_list(lambda x: to_enum(Value, x), self.values)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
