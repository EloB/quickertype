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
class TopLevel:
    my_property: str | None = None
    second_property: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        my_property = from_union([from_str, from_none], obj.get("myProperty"))
        second_property = from_union([from_str, from_none], obj.get("secondProperty"))
        return TopLevel(my_property, second_property)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.my_property is not None:
            result["myProperty"] = from_union([from_str, from_none], self.my_property)
        if self.second_property is not None:
            result["secondProperty"] = from_union([from_str, from_none], self.second_property)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
