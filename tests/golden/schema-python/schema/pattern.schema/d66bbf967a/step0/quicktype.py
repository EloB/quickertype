import re
from dataclasses import dataclass
from typing import Any, cast, TypeVar, Type


T = TypeVar("T")


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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class RegExp:
    pattern3: str

    @staticmethod
    def from_dict(obj: Any) -> 'RegExp':
        assert isinstance(obj, dict)
        pattern3 = from_str(obj["pattern3"])
        assert pattern3 is None or re.search("d[.]*", cast(str, obj["pattern3"]))
        return RegExp(pattern3)

    def to_dict(self) -> dict:
        result: dict = {}
        result["pattern3"] = from_str(self.pattern3)
        return result


@dataclass
class TopLevel:
    pattern1: str
    pattern2: str
    union: str
    reg_exp: RegExp | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        pattern1 = from_str(obj["pattern1"])
        assert pattern1 is None or re.search("a[.]*", cast(str, obj["pattern1"]))
        pattern2 = from_str(obj["pattern2"])
        assert pattern2 is None or re.search("b[.]*", cast(str, obj["pattern2"]))
        union = from_str(obj["union"])
        assert union is None or re.search("(b[.]*)|(c[.]*)", cast(str, obj["union"]))
        reg_exp = from_union([RegExp.from_dict, from_none], obj.get("RegExp"))
        return TopLevel(pattern1, pattern2, union, reg_exp)

    def to_dict(self) -> dict:
        result: dict = {}
        result["pattern1"] = from_str(self.pattern1)
        result["pattern2"] = from_str(self.pattern2)
        result["union"] = from_str(self.union)
        if self.reg_exp is not None:
            result["RegExp"] = from_union([lambda x: to_class(RegExp, x), from_none], self.reg_exp)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
