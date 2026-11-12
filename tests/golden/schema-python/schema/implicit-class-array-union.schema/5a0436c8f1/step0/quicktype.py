from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


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
class FooClass:
    bar: int

    @staticmethod
    def from_dict(obj: Any) -> 'FooClass':
        assert isinstance(obj, dict)
        bar = from_int(obj["bar"])
        return FooClass(bar)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bar"] = from_int(self.bar)
        return result


@dataclass
class TopLevel:
    foo: float | int | bool | str | list[int] | FooClass | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        foo = from_union([from_none, from_int, from_float, from_bool, from_str, lambda x: from_list(from_int, x), FooClass.from_dict], obj["foo"])
        return TopLevel(foo)

    def to_dict(self) -> dict:
        result: dict = {}
        result["foo"] = from_union([from_none, from_int, to_float, from_bool, from_str, lambda x: from_list(from_int, x), lambda x: to_class(FooClass, x)], self.foo)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
