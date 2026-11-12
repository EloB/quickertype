from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_none(x: Any) -> Any:
    assert x is None
    return x


@dataclass
class Bar:
    foo: 'TopLevel | list[TopLevel]'

    @staticmethod
    def from_dict(obj: Any) -> 'Bar':
        assert isinstance(obj, dict)
        foo = from_union([TopLevel.from_dict, lambda x: from_list(TopLevel.from_dict, x)], obj["foo"])
        return Bar(foo)

    def to_dict(self) -> dict:
        result: dict = {}
        result["foo"] = from_union([lambda x: to_class(TopLevel, x), lambda x: from_list(lambda x: to_class(TopLevel, x), x)], self.foo)
        return result


@dataclass
class TopLevel:
    bar: Bar | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        bar = from_union([Bar.from_dict, from_none], obj.get("bar"))
        return TopLevel(bar)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.bar is not None:
            result["bar"] = from_union([lambda x: to_class(Bar, x), from_none], self.bar)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
