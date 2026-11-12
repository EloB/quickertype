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
class Item:
    content: str | None = None
    id: str | None = None
    output: str | None = None
    summary: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Item':
        assert isinstance(obj, dict)
        content = from_union([from_str, from_none], obj.get("content"))
        id = from_union([from_str, from_none], obj.get("id"))
        output = from_union([from_str, from_none], obj.get("output"))
        summary = from_union([from_str, from_none], obj.get("summary"))
        return Item(content, id, output, summary)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.content is not None:
            result["content"] = from_union([from_str, from_none], self.content)
        if self.id is not None:
            result["id"] = from_union([from_str, from_none], self.id)
        if self.output is not None:
            result["output"] = from_union([from_str, from_none], self.output)
        if self.summary is not None:
            result["summary"] = from_union([from_str, from_none], self.summary)
        return result


@dataclass
class TopLevel:
    input: list[Item]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        input = from_list(Item.from_dict, obj["input"])
        return TopLevel(input)

    def to_dict(self) -> dict:
        result: dict = {}
        result["input"] = from_list(lambda x: to_class(Item, x), self.input)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
