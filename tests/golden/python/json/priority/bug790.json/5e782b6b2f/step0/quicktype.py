from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    children_data: list['TopLevel']
    id: int
    is_active: bool
    level: int
    name: str
    parent_id: int
    position: int
    product_count: int

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        children_data = from_list(TopLevel.from_dict, obj["children_data"])
        id = from_int(obj["id"])
        is_active = from_bool(obj["is_active"])
        level = from_int(obj["level"])
        name = from_str(obj["name"])
        parent_id = from_int(obj["parent_id"])
        position = from_int(obj["position"])
        product_count = from_int(obj["product_count"])
        return TopLevel(children_data, id, is_active, level, name, parent_id, position, product_count)

    def to_dict(self) -> dict:
        result: dict = {}
        result["children_data"] = from_list(lambda x: to_class(TopLevel, x), self.children_data)
        result["id"] = from_int(self.id)
        result["is_active"] = from_bool(self.is_active)
        result["level"] = from_int(self.level)
        result["name"] = from_str(self.name)
        result["parent_id"] = from_int(self.parent_id)
        result["position"] = from_int(self.position)
        result["product_count"] = from_int(self.product_count)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
