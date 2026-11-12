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
    """Nested block comment openers:
    {-
    /*
    This text must remain inside the generated documentation comment.
    """
    value: str
    """Nested property block comment openers:
    {-
    /*
    This text must remain inside the generated property documentation comment.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        value = from_str(obj["value"])
        return TopLevel(value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["value"] = from_str(self.value)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
