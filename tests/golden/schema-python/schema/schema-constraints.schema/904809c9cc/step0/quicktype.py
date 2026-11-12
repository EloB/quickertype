from dataclasses import dataclass
from typing import Any, cast, TypeVar, Type


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    min_max_length: str
    percent: float

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        min_max_length = from_str(obj["minMaxLength"])
        assert min_max_length is None or 5 <= len(cast(str, obj["minMaxLength"]))
        assert min_max_length is None or len(cast(str, obj["minMaxLength"])) <= 5
        percent = from_float(obj["percent"])
        assert percent is None or 0 <= percent
        assert percent is None or percent <= 1
        return TopLevel(min_max_length, percent)

    def to_dict(self) -> dict:
        result: dict = {}
        result["minMaxLength"] = from_str(self.min_max_length)
        result["percent"] = to_float(self.percent)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
