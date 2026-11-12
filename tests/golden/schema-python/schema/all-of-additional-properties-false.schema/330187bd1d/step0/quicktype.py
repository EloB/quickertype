from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


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


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Frequency(Enum):
    WEEKLY = "Weekly"
    MONTHLY = "Monthly"
    ANNUALLY = "Annually"


class TypeEnum(Enum):
    GROSS_SALARY_AMOUNT = "GrossSalaryAmount"
    OVERTIME = "Overtime"


@dataclass
class TopLevel:
    amount: float
    frequency: Frequency
    type: TypeEnum
    description: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        amount = from_float(obj["amount"])
        frequency = Frequency(obj["frequency"])
        type = TypeEnum(obj["type"])
        description = from_union([from_str, from_none], obj.get("description"))
        return TopLevel(amount, frequency, type, description)

    def to_dict(self) -> dict:
        result: dict = {}
        result["amount"] = to_float(self.amount)
        result["frequency"] = to_enum(Frequency, self.frequency)
        result["type"] = to_enum(TypeEnum, self.type)
        if self.description is not None:
            result["description"] = from_union([from_str, from_none], self.description)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
