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


class Callsign(Enum):
    ALPHA = "alpha"
    BRAVO = "bravo"
    CHARLIE = "charlie"
    DELTA = "delta"
    ECHO = "echo"
    FOXTROT = "foxtrot"
    GOLF = "golf"
    HOTEL = "hotel"
    INDIA = "india"
    JULIETT = "juliett"
    KILO = "kilo"
    LIMA = "lima"
    MIKE = "mike"
    NOVEMBER = "november"
    OSCAR = "oscar"
    PAPA = "papa"
    QUEBEC = "quebec"
    ROMEO = "romeo"
    SIERRA = "sierra"
    TANGO = "tango"


class Priority(Enum):
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"


@dataclass
class TopLevel:
    callsign: Callsign
    priority: Priority

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        callsign = Callsign(obj["callsign"])
        priority = Priority(obj["priority"])
        return TopLevel(callsign, priority)

    def to_dict(self) -> dict:
        result: dict = {}
        result["callsign"] = to_enum(Callsign, self.callsign)
        result["priority"] = to_enum(Priority, self.priority)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
