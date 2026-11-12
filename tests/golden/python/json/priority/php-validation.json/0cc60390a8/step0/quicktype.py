from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    boolean: bool
    integer: int
    integers: list[int]
    number: float
    string: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        boolean = from_bool(obj["boolean"])
        integer = from_int(obj["integer"])
        integers = from_list(from_int, obj["integers"])
        number = from_float(obj["number"])
        string = from_str(obj["string"])
        return TopLevel(boolean, integer, integers, number, string)

    def to_dict(self) -> dict:
        result: dict = {}
        result["boolean"] = from_bool(self.boolean)
        result["integer"] = from_int(self.integer)
        result["integers"] = from_list(from_int, self.integers)
        result["number"] = to_float(self.number)
        result["string"] = from_str(self.string)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
