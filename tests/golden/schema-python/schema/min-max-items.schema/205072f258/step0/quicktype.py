from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


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
    max_only: list[int]
    min_and_max: list[float]
    min_only: list[str]
    plain: list[str]
    union_items: list[int | str]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        max_only = from_list(from_int, obj["maxOnly"])
        assert max_only is None or len(max_only) <= 3
        min_and_max = from_list(from_float, obj["minAndMax"])
        assert min_and_max is None or 1 <= len(min_and_max)
        assert min_and_max is None or len(min_and_max) <= 4
        min_only = from_list(from_str, obj["minOnly"])
        assert min_only is None or 2 <= len(min_only)
        plain = from_list(from_str, obj["plain"])
        union_items = from_list(lambda x: from_union([from_int, from_str], x), obj["unionItems"])
        assert union_items is None or 2 <= len(union_items)
        return TopLevel(max_only, min_and_max, min_only, plain, union_items)

    def to_dict(self) -> dict:
        result: dict = {}
        result["maxOnly"] = from_list(from_int, self.max_only)
        result["minAndMax"] = from_list(to_float, self.min_and_max)
        result["minOnly"] = from_list(from_str, self.min_only)
        result["plain"] = from_list(from_str, self.plain)
        result["unionItems"] = from_list(lambda x: from_union([from_int, from_str], x), self.union_items)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
