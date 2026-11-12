from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    bar: bool
    foo: Any = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        bar = from_bool(obj["bar"])
        foo = obj.get("foo")
        return TopLevel(bar, foo)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bar"] = from_bool(self.bar)
        if self.foo is not None:
            result["foo"] = self.foo
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
