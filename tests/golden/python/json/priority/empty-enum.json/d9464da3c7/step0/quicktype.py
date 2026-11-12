from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Foo:
    bar: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Foo':
        assert isinstance(obj, dict)
        bar = from_union([from_none, from_str], obj.get("bar"))
        return Foo(bar)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.bar is not None:
            result["bar"] = from_union([from_none, from_str], self.bar)
        return result


@dataclass
class TopLevel:
    foo: list[Foo]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        foo = from_list(Foo.from_dict, obj["foo"])
        return TopLevel(foo)

    def to_dict(self) -> dict:
        result: dict = {}
        result["foo"] = from_list(lambda x: to_class(Foo, x), self.foo)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
