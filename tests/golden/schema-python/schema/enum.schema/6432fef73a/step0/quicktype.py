from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class OtherArr(Enum):
    FOO = "foo"
    BAR = "bar"
    IF = "if"


class Gve(Enum):
    GOOD = "good"
    NEUTRAL = "neutral"
    EVIL = "evil"


class Lvc(Enum):
    LAWFUL = "lawful"
    NEUTRAL = "neutral"
    CHAOTIC = "chaotic"


@dataclass
class TopLevel:
    gve: Gve
    arr: list[int | OtherArr] | None = None
    top_level_for: str | None = None
    lvc: Lvc | None = None
    other_arr: list[OtherArr] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        gve = Gve(obj["gve"])
        arr = from_union([lambda x: from_list(lambda x: from_union([from_int, OtherArr], x), x), from_none], obj.get("arr"))
        top_level_for = from_union([from_str, from_none], obj.get("for"))
        lvc = from_union([Lvc, from_none], obj.get("lvc"))
        other_arr = from_union([lambda x: from_list(OtherArr, x), from_none], obj.get("otherArr"))
        return TopLevel(gve, arr, top_level_for, lvc, other_arr)

    def to_dict(self) -> dict:
        result: dict = {}
        result["gve"] = to_enum(Gve, self.gve)
        if self.arr is not None:
            result["arr"] = from_union([lambda x: from_list(lambda x: from_union([from_int, lambda x: to_enum(OtherArr, x)], x), x), from_none], self.arr)
        if self.top_level_for is not None:
            result["for"] = from_union([from_str, from_none], self.top_level_for)
        if self.lvc is not None:
            result["lvc"] = from_union([lambda x: to_enum(Lvc, x), from_none], self.lvc)
        if self.other_arr is not None:
            result["otherArr"] = from_union([lambda x: from_list(lambda x: to_enum(OtherArr, x), x), from_none], self.other_arr)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
