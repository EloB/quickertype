from dataclasses import dataclass
from uuid import UUID
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    boolean_value: bool
    double_value: float
    int_value: int
    string_value: str
    uuid_value: UUID
    uuid_values: list[UUID]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        boolean_value = from_bool(obj["booleanValue"])
        double_value = from_float(obj["doubleValue"])
        int_value = from_int(obj["intValue"])
        string_value = from_str(obj["stringValue"])
        uuid_value = UUID(obj["uuidValue"])
        uuid_values = from_list(lambda x: UUID(x), obj["uuidValues"])
        return TopLevel(boolean_value, double_value, int_value, string_value, uuid_value, uuid_values)

    def to_dict(self) -> dict:
        result: dict = {}
        result["booleanValue"] = from_bool(self.boolean_value)
        result["doubleValue"] = to_float(self.double_value)
        result["intValue"] = from_int(self.int_value)
        result["stringValue"] = from_str(self.string_value)
        result["uuidValue"] = str(self.uuid_value)
        result["uuidValues"] = from_list(lambda x: str(x), self.uuid_values)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
