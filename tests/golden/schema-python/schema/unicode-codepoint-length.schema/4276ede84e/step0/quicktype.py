import re
from dataclasses import dataclass
from typing import Any, cast, TypeVar, Type


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    exact: str
    maximum: str
    minimum: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        exact = from_str(obj["exact"])
        assert exact is None or 2 <= len(cast(str, obj["exact"]))
        assert exact is None or len(cast(str, obj["exact"])) <= 2
        assert exact is None or re.search("^[^!]+$", cast(str, obj["exact"]))
        maximum = from_str(obj["maximum"])
        assert maximum is None or len(cast(str, obj["maximum"])) <= 1
        minimum = from_str(obj["minimum"])
        assert minimum is None or 2 <= len(cast(str, obj["minimum"]))
        return TopLevel(exact, maximum, minimum)

    def to_dict(self) -> dict:
        result: dict = {}
        result["exact"] = from_str(self.exact)
        result["maximum"] = from_str(self.maximum)
        result["minimum"] = from_str(self.minimum)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
