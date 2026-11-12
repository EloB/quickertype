from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


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
    free: float
    intersection: float
    max: float
    min: float
    minmax: float
    min_max_intersection: float
    min_max_union: float
    union: float

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        free = from_float(obj["free"])
        intersection = from_float(obj["intersection"])
        assert intersection is None or 4 <= intersection
        assert intersection is None or intersection <= 5
        max = from_float(obj["max"])
        assert max is None or max <= 5
        min = from_float(obj["min"])
        assert min is None or 3 <= min
        minmax = from_float(obj["minmax"])
        assert minmax is None or 3 <= minmax
        assert minmax is None or minmax <= 5
        min_max_intersection = from_float(obj["minMaxIntersection"])
        assert min_max_intersection is None or 3 <= min_max_intersection
        assert min_max_intersection is None or min_max_intersection <= 5
        min_max_union = from_float(obj["minMaxUnion"])
        union = from_float(obj["union"])
        assert union is None or 3 <= union
        assert union is None or union <= 6
        return TopLevel(free, intersection, max, min, minmax, min_max_intersection, min_max_union, union)

    def to_dict(self) -> dict:
        result: dict = {}
        result["free"] = to_float(self.free)
        result["intersection"] = to_float(self.intersection)
        result["max"] = to_float(self.max)
        result["min"] = to_float(self.min)
        result["minmax"] = to_float(self.minmax)
        result["minMaxIntersection"] = to_float(self.min_max_intersection)
        result["minMaxUnion"] = to_float(self.min_max_union)
        result["union"] = to_float(self.union)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
