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
class Response:
    body: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Response':
        assert isinstance(obj, dict)
        body = from_union([from_str, from_none], obj.get("body"))
        return Response(body)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.body is not None:
            result["body"] = from_union([from_str, from_none], self.body)
        return result


@dataclass
class TopLevel:
    """Postman collection"""

    item: 'list[TopLevel] | None' = None
    name: str | None = None
    response: list[Response] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        item = from_union([lambda x: from_list(TopLevel.from_dict, x), from_none], obj.get("item"))
        name = from_union([from_str, from_none], obj.get("name"))
        response = from_union([lambda x: from_list(Response.from_dict, x), from_none], obj.get("response"))
        return TopLevel(item, name, response)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.item is not None:
            result["item"] = from_union([lambda x: from_list(lambda x: to_class(TopLevel, x), x), from_none], self.item)
        if self.name is not None:
            result["name"] = from_union([from_str, from_none], self.name)
        if self.response is not None:
            result["response"] = from_union([lambda x: from_list(lambda x: to_class(Response, x), x), from_none], self.response)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
