from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


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


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Option:
    name: str
    foo: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Option':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        foo = from_union([from_none, from_str], obj.get("foo"))
        return Option(name, foo)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        if self.foo is not None:
            result["foo"] = from_union([from_none, from_str], self.foo)
        return result


@dataclass
class TopLevel:
    options: list[Option]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        options = from_list(Option.from_dict, obj["options"])
        return TopLevel(options)

    def to_dict(self) -> dict:
        result: dict = {}
        result["options"] = from_list(lambda x: to_class(Option, x), self.options)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
