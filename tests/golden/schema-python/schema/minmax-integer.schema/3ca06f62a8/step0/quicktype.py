from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    free: int
    intersection: int
    max: int
    min: int
    minmax: int
    min_max_intersection: int
    min_max_union: int
    union: int

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        free = from_int(obj["free"])
        intersection = from_int(obj["intersection"])
        assert intersection is None or 4 <= intersection
        assert intersection is None or intersection <= 5
        max = from_int(obj["max"])
        assert max is None or max <= 5
        min = from_int(obj["min"])
        assert min is None or 3 <= min
        minmax = from_int(obj["minmax"])
        assert minmax is None or 3 <= minmax
        assert minmax is None or minmax <= 5
        min_max_intersection = from_int(obj["minMaxIntersection"])
        assert min_max_intersection is None or 3 <= min_max_intersection
        assert min_max_intersection is None or min_max_intersection <= 5
        min_max_union = from_int(obj["minMaxUnion"])
        union = from_int(obj["union"])
        assert union is None or 3 <= union
        assert union is None or union <= 6
        return TopLevel(free, intersection, max, min, minmax, min_max_intersection, min_max_union, union)

    def to_dict(self) -> dict:
        result: dict = {}
        result["free"] = from_int(self.free)
        result["intersection"] = from_int(self.intersection)
        result["max"] = from_int(self.max)
        result["min"] = from_int(self.min)
        result["minmax"] = from_int(self.minmax)
        result["minMaxIntersection"] = from_int(self.min_max_intersection)
        result["minMaxUnion"] = from_int(self.min_max_union)
        result["union"] = from_int(self.union)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
