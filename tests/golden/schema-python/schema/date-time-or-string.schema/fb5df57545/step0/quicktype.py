import datetime
from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class BarEnum(Enum):
    QUUX = "quux"


@dataclass
class TopLevel:
    bar: BarEnum | datetime.datetime
    foo: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        bar = from_union([BarEnum, from_datetime], obj["bar"])
        foo = from_str(obj["foo"])
        return TopLevel(bar, foo)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bar"] = from_union([lambda x: to_enum(BarEnum, x), lambda x: x.isoformat()], self.bar)
        result["foo"] = from_str(self.foo)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
