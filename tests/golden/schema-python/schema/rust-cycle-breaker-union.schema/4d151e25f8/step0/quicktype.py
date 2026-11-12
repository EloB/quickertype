from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


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
class Node:
    value: str
    next: 'Node | str | None' = None

    @staticmethod
    def from_dict(obj: Any) -> 'Node':
        assert isinstance(obj, dict)
        value = from_str(obj["value"])
        next = from_union([Node.from_dict, from_none, from_str], obj.get("next"))
        return Node(value, next)

    def to_dict(self) -> dict:
        result: dict = {}
        result["value"] = from_str(self.value)
        if self.next is not None:
            result["next"] = from_union([lambda x: to_class(Node, x), from_none, from_str], self.next)
        return result


@dataclass
class TopLevel:
    value: str
    next: Node | str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        value = from_str(obj["value"])
        next = from_union([Node.from_dict, from_none, from_str], obj.get("next"))
        return TopLevel(value, next)

    def to_dict(self) -> dict:
        result: dict = {}
        result["value"] = from_str(self.value)
        if self.next is not None:
            result["next"] = from_union([lambda x: to_class(Node, x), from_none, from_str], self.next)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
