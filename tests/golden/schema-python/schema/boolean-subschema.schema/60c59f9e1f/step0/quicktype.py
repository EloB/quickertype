from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    empty: list[Any]
    foo: str
    disallowed: Any = None
    impossible: Any = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        empty = from_list(lambda x: x, obj["empty"])
        foo = from_str(obj["foo"])
        disallowed = obj.get("disallowed")
        impossible = obj.get("impossible")
        return TopLevel(empty, foo, disallowed, impossible)

    def to_dict(self) -> dict:
        result: dict = {}
        result["empty"] = from_list(lambda x: x, self.empty)
        result["foo"] = from_str(self.foo)
        if self.disallowed is not None:
            result["disallowed"] = self.disallowed
        if self.impossible is not None:
            result["impossible"] = self.impossible
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
