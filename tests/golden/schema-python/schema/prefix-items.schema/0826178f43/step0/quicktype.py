from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
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
    open: list[bool | int]
    tuple: list[bool | int]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        open = from_list(lambda x: from_union([from_bool, from_int], x), obj["open"])
        tuple = from_list(lambda x: from_union([from_bool, from_int], x), obj["tuple"])
        return TopLevel(open, tuple)

    def to_dict(self) -> dict:
        result: dict = {}
        result["open"] = from_list(lambda x: from_union([from_bool, from_int], x), self.open)
        result["tuple"] = from_list(lambda x: from_union([from_bool, from_int], x), self.tuple)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
