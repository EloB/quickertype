from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    empty: str
    top_level_continue: str
    null: str
    undefined: str
    x: str
    x_y: str
    top_level_x: str
    purple_x: str
    top_level: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        empty = from_str(obj[""])
        top_level_continue = from_str(obj["continue"])
        null = from_str(obj["null"])
        undefined = from_str(obj["undefined"])
        x = from_str(obj["x"])
        x_y = from_str(obj["x y"])
        top_level_x = from_str(obj["x\""])
        purple_x = from_str(obj["x'"])
        top_level = from_str(obj["{}"])
        return TopLevel(empty, top_level_continue, null, undefined, x, x_y, top_level_x, purple_x, top_level)

    def to_dict(self) -> dict:
        result: dict = {}
        result[""] = from_str(self.empty)
        result["continue"] = from_str(self.top_level_continue)
        result["null"] = from_str(self.null)
        result["undefined"] = from_str(self.undefined)
        result["x"] = from_str(self.x)
        result["x y"] = from_str(self.x_y)
        result["x\""] = from_str(self.top_level_x)
        result["x'"] = from_str(self.purple_x)
        result["{}"] = from_str(self.top_level)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
