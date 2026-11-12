import re
from dataclasses import dataclass
from typing import Any, cast, TypeVar, Type


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


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
    req_zero_min: int
    opt_double: float | None = None
    opt_int: int | None = None
    opt_pattern: str | None = None
    opt_string: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        req_zero_min = from_int(obj["reqZeroMin"])
        assert req_zero_min is None or 0 <= req_zero_min
        assert req_zero_min is None or req_zero_min <= 100
        opt_double = from_union([from_float, from_none], obj.get("optDouble"))
        assert opt_double is None or 0.5 <= opt_double
        assert opt_double is None or opt_double <= 99.5
        opt_int = from_union([from_int, from_none], obj.get("optInt"))
        assert opt_int is None or 0 <= opt_int
        assert opt_int is None or opt_int <= 100
        opt_pattern = from_union([from_str, from_none], obj.get("optPattern"))
        assert opt_pattern is None or re.search("^[a-z]+$", cast(str, obj.get("optPattern")))
        opt_string = from_union([from_str, from_none], obj.get("optString"))
        assert opt_string is None or 3 <= len(cast(str, obj.get("optString")))
        assert opt_string is None or len(cast(str, obj.get("optString"))) <= 10
        return TopLevel(req_zero_min, opt_double, opt_int, opt_pattern, opt_string)

    def to_dict(self) -> dict:
        result: dict = {}
        result["reqZeroMin"] = from_int(self.req_zero_min)
        if self.opt_double is not None:
            result["optDouble"] = from_union([to_float, from_none], self.opt_double)
        if self.opt_int is not None:
            result["optInt"] = from_union([from_int, from_none], self.opt_int)
        if self.opt_pattern is not None:
            result["optPattern"] = from_union([from_str, from_none], self.opt_pattern)
        if self.opt_string is not None:
            result["optString"] = from_union([from_str, from_none], self.opt_string)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
