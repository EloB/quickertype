from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class PC:
    count: int
    label: str
    peak24: int

    @staticmethod
    def from_dict(obj: Any) -> 'PC':
        assert isinstance(obj, dict)
        count = from_int(obj["count"])
        label = from_str(obj["label"])
        peak24 = from_int(obj["peak24"])
        return PC(count, label, peak24)

    def to_dict(self) -> dict:
        result: dict = {}
        result["count"] = from_int(self.count)
        result["label"] = from_str(self.label)
        result["peak24"] = from_int(self.peak24)
        return result


@dataclass
class TopLevel:
    pc: PC
    ps3: PC
    ps4: PC
    xbox: PC
    xone: PC

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        pc = PC.from_dict(obj["pc"])
        ps3 = PC.from_dict(obj["ps3"])
        ps4 = PC.from_dict(obj["ps4"])
        xbox = PC.from_dict(obj["xbox"])
        xone = PC.from_dict(obj["xone"])
        return TopLevel(pc, ps3, ps4, xbox, xone)

    def to_dict(self) -> dict:
        result: dict = {}
        result["pc"] = to_class(PC, self.pc)
        result["ps3"] = to_class(PC, self.ps3)
        result["ps4"] = to_class(PC, self.ps4)
        result["xbox"] = to_class(PC, self.xbox)
        result["xone"] = to_class(PC, self.xone)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
