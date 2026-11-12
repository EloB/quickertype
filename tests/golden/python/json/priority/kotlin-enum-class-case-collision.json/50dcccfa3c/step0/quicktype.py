from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Category(Enum):
    EMPTY = " "
    CATEGORY = ""


@dataclass
class TopLevelElement:
    category: Category

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        category = Category(obj["category"])
        return TopLevelElement(category)

    def to_dict(self) -> dict:
        result: dict = {}
        result["category"] = to_enum(Category, self.category)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
