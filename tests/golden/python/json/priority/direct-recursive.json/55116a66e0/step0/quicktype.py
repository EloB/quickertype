from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    bar: bool
    foo: int
    moo: float
    quux: str
    also: 'TopLevel | None'

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        bar = from_bool(obj["bar"])
        foo = from_int(obj["foo"])
        moo = from_float(obj["moo"])
        quux = from_str(obj["quux"])
        also = from_union([TopLevel.from_dict, from_none], obj.get("also"))
        return TopLevel(bar, foo, moo, quux, also)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bar"] = from_bool(self.bar)
        result["foo"] = from_int(self.foo)
        result["moo"] = to_float(self.moo)
        result["quux"] = from_str(self.quux)
        if self.also is not None:
            result["also"] = from_union([lambda x: to_class(TopLevel, x), from_none], self.also)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
