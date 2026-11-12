from dataclasses import dataclass
from typing import Any, cast, TypeVar, Type


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    intersection: str
    in_union: float | str
    maxlength: str
    minlength: str
    min_max_intersection: str
    minmaxlength: str
    min_max_union: str
    union: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        intersection = from_str(obj["intersection"])
        assert intersection is None or 4 <= len(cast(str, obj["intersection"]))
        assert intersection is None or len(cast(str, obj["intersection"])) <= 5
        in_union = from_union([from_float, from_str], obj["inUnion"])
        maxlength = from_str(obj["maxlength"])
        assert maxlength is None or len(cast(str, obj["maxlength"])) <= 5
        minlength = from_str(obj["minlength"])
        assert minlength is None or 3 <= len(cast(str, obj["minlength"]))
        min_max_intersection = from_str(obj["minMaxIntersection"])
        assert min_max_intersection is None or 3 <= len(cast(str, obj["minMaxIntersection"]))
        assert min_max_intersection is None or len(cast(str, obj["minMaxIntersection"])) <= 5
        minmaxlength = from_str(obj["minmaxlength"])
        assert minmaxlength is None or 3 <= len(cast(str, obj["minmaxlength"]))
        assert minmaxlength is None or len(cast(str, obj["minmaxlength"])) <= 5
        min_max_union = from_str(obj["minMaxUnion"])
        union = from_str(obj["union"])
        assert union is None or 3 <= len(cast(str, obj["union"]))
        assert union is None or len(cast(str, obj["union"])) <= 6
        return TopLevel(intersection, in_union, maxlength, minlength, min_max_intersection, minmaxlength, min_max_union, union)

    def to_dict(self) -> dict:
        result: dict = {}
        result["intersection"] = from_str(self.intersection)
        result["inUnion"] = from_union([to_float, from_str], self.in_union)
        result["maxlength"] = from_str(self.maxlength)
        result["minlength"] = from_str(self.minlength)
        result["minMaxIntersection"] = from_str(self.min_max_intersection)
        result["minmaxlength"] = from_str(self.minmaxlength)
        result["minMaxUnion"] = from_str(self.min_max_union)
        result["union"] = from_str(self.union)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
